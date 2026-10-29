import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/ai/ai_errors.dart';
import '../../../core/config/env.dart';
import '../domain/profile.dart';
import 'profile_rows.dart';

part 'resume_importer.g.dart';

/// Debe coincidir con MAX_PDF_BYTES en la función `import-resume`.
const maxResumeBytes = 5 * 1024 * 1024;

enum ResumeImportFailure {
  tooLarge,
  unreadable,
  rateLimited,
  dailyLimit,
  busy,
  other,
}

class ResumeImportException implements Exception {
  const ResumeImportException(this.reason);

  final ResumeImportFailure reason;

  @override
  String toString() => 'ResumeImportException($reason)';
}

/// Lee una HV en PDF y devuelve lo que contiene, sin guardar nada.
abstract interface class ResumeImporter {
  Future<ProfileData> extract(Uint8List pdf);
}

class SupabaseResumeImporter implements ResumeImporter {
  SupabaseResumeImporter(this._functions);

  final FunctionsClient _functions;

  @override
  Future<ProfileData> extract(Uint8List pdf) async {
    if (pdf.lengthInBytes > maxResumeBytes) {
      throw const ResumeImportException(ResumeImportFailure.tooLarge);
    }
    try {
      final response = await invokeAi(
        _functions,
        'import-resume',
        body: {'pdf_base64': base64Encode(pdf)},
      );
      return importedProfileFromJson(
        (response.data as Map).cast<String, dynamic>(),
      );
    } on FunctionException catch (error) {
      if (isDailyLimit(error)) {
        throw const ResumeImportException(ResumeImportFailure.dailyLimit);
      }
      throw ResumeImportException(switch (error.status) {
        413 => ResumeImportFailure.tooLarge,
        422 => ResumeImportFailure.unreadable,
        429 => ResumeImportFailure.rateLimited,
        503 => ResumeImportFailure.busy,
        _ => ResumeImportFailure.other,
      });
    }
  }
}

/// Convierte la respuesta de `import-resume` en datos del perfil.
ProfileData importedProfileFromJson(Map<String, dynamic> json) {
  List<Map<String, dynamic>> list(String key) => [
    for (final item in json[key] as List? ?? const [])
      item as Map<String, dynamic>,
  ];
  final profileJson = json['profile'] as Map<String, dynamic>;
  final links =
      (profileJson['links'] as Map? ?? const {}).cast<String, String>()
        ..removeWhere((key, url) => url.trim().isEmpty);
  return ProfileData(
    profile: Profile.fromJson({...profileJson, 'links': links}),
    experiences: sortExperiences(list('experiences').map(experienceFromRow)),
    projects: list('projects').map(Project.fromJson).toList(),
    skills: list('skills').map(Skill.fromJson).toList(),
    education: sortEducation(list('education').map(Education.fromJson)),
  );
}

/// Nulo en modo local: importar necesita el servidor.
@Riverpod(keepAlive: true)
ResumeImporter? resumeImporter(Ref ref) {
  if (!Env.hasBackend) return null;
  return SupabaseResumeImporter(Supabase.instance.client.functions);
}

/// Abre el selector de archivos; devuelve nulo si el usuario cancela.
typedef PdfPicker = Future<Uint8List?> Function();

@Riverpod(keepAlive: true)
PdfPicker pdfPicker(Ref ref) => () async {
  // pickFile elige un solo archivo: basta con tocarlo.
  final file = await FilePicker.pickFile(
    type: FileType.custom,
    allowedExtensions: const ['pdf'],
  );
  return file?.xFile.readAsBytes();
};
