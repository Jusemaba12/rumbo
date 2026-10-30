import 'dart:io';

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:flutter_test/flutter_test.dart';

/// Convenciones del proyecto que los lints no cubren. Los tests se ejecutan
/// desde la raíz.
void main() {
  final List<File> files = _sourceFiles();

  test('ningún archivo está vacío ni empieza con una línea en blanco', () {
    expect(<String>[
      for (final File file in files)
        if (file.readAsStringSync().trim().isEmpty ||
            file.readAsStringSync().startsWith('\n'))
          file.path,
    ], isEmpty);
  });

  test('los archivos están en snake_case y sus nombres no se repiten', () {
    final RegExp snakeCase = RegExp(r'^[a-z][a-z0-9_]*\.dart$');
    final List<String> names = <String>[for (final File f in files) _name(f)];
    expect(names.where((String name) => !snakeCase.hasMatch(name)), isEmpty);
    expect(
      names.where(
        (String name) => names.indexOf(name) != names.lastIndexOf(name),
      ),
      isEmpty,
    );
  });

  test('no se silencian lints con comentarios ignore', () {
    final RegExp ignore = RegExp(r'//\s*ignore(_for_file)?\s*:');
    expect(<String>[
      for (final File file in files)
        if (ignore.hasMatch(file.readAsStringSync())) file.path,
    ], isEmpty);
  });

  test('cada capa solo depende de las que le tocan', () {
    expect(<String>[
      for (final File file in files)
        for (final String forbidden in _forbiddenImports(file.path))
          if (file.readAsStringSync().contains(forbidden))
            '${file.path} no puede importar $forbidden',
    ], isEmpty);
  });

  test('sin barrel files ni export', () {
    expect(_violations(files, (_Visitor v) => v.exports), isEmpty);
  });

  test('los métodos bool no empiezan por get', () {
    expect(_violations(files, (_Visitor v) => v.boolGetters), isEmpty);
  });

  test('constructores con un parámetro posicional como máximo', () {
    expect(_violations(files, (_Visitor v) => v.constructors), isEmpty);
  });

  test('métodos y funciones con un parámetro posicional como máximo', () {
    final List<String> m = _violations(files, (_Visitor v) => v.methods);
    expect(m.join('\n'), isEmpty);
  });
}

/// Código escrito a mano: sin generados ni las traducciones.
List<File> _sourceFiles() => <File>[
  for (final FileSystemEntity entity in Directory(
    'lib',
  ).listSync(recursive: true))
    if (entity is File &&
        entity.path.endsWith('.dart') &&
        !entity.path.endsWith('.g.dart') &&
        !entity.path.endsWith('.freezed.dart') &&
        !entity.path.contains('configurations/language/'))
      entity,
];

/// `domain` es Dart puro; `application` no conoce las pantallas y solo
/// toca `infrastructure` por sus providers de `di`.
List<String> _forbiddenImports(String path) {
  if (path.contains('/domain/')) {
    return const <String>[
      'package:flutter/',
      'package:flutter_riverpod/',
      'package:riverpod_annotation/',
      'package:supabase_flutter/',
      '/application/use_cases/',
      '/infrastructure/',
      '/presentation/',
    ];
  }
  if (path.contains('/application/use_cases/')) {
    return const <String>[
      'package:flutter/',
      'package:supabase_flutter/',
      '/infrastructure/repositories/',
      '/infrastructure/mappers/',
      '/presentation/',
    ];
  }
  return const <String>[];
}

String _name(File file) => file.uri.pathSegments.last;

List<String> _violations(
  List<File> files,
  List<String> Function(_Visitor visitor) select,
) {
  final List<String> found = <String>[];
  for (final File file in files) {
    final ParseStringResult parsed = parseFile(
      path: file.absolute.path,
      featureSet: FeatureSet.latestLanguageVersion(),
    );
    final _Visitor visitor = _Visitor();
    parsed.unit.accept(visitor);
    found.addAll(select(visitor).map((String v) => '${file.path}: $v'));
  }
  return found;
}

class _Visitor extends RecursiveAstVisitor<void> {
  final List<String> exports = <String>[];
  final List<String> boolGetters = <String>[];
  final List<String> constructors = <String>[];
  final List<String> methods = <String>[];

  int _positional(FormalParameterList? parameters) =>
      parameters?.parameters
          .where((FormalParameter p) => p.isPositional)
          .length ??
      0;

  @override
  void visitExportDirective(ExportDirective node) {
    exports.add(node.toSource());
    super.visitExportDirective(node);
  }

  @override
  void visitConstructorDeclaration(ConstructorDeclaration node) {
    if (node.factoryKeyword == null && _positional(node.parameters) > 1) {
      constructors.add(node.toSource().split('\n').first);
    }
    super.visitConstructorDeclaration(node);
  }

  void _check(String name, TypeAnnotation? type, FormalParameterList? params) {
    if (type?.toSource() == 'bool' && name.startsWith('get')) {
      boolGetters.add(name);
    }
    final List<FormalParameter> list =
        params?.parameters.toList() ?? <FormalParameter>[];
    // Pasar el contexto, los textos o el Ref delante es la costumbre de
    // Flutter y de Riverpod.
    final String first = list.isEmpty ? '' : list.first.toSource();
    final bool exempt =
        first.contains('BuildContext') ||
        first.contains('AppLocalizations') ||
        first.startsWith('Ref ');
    if (!exempt && _positional(params) > 1) methods.add(name);
  }

  @override
  void visitMethodDeclaration(MethodDeclaration node) {
    final bool isOverride = node.metadata.any(
      (Annotation a) => a.name.name == 'override',
    );
    if (!isOverride) {
      _check(node.name.lexeme, node.returnType, node.parameters);
    }
    super.visitMethodDeclaration(node);
  }

  @override
  void visitFunctionDeclaration(FunctionDeclaration node) {
    // Las funciones locales son detalles de implementación.
    if (node.parent is! FunctionDeclarationStatement) {
      _check(
        node.name.lexeme,
        node.returnType,
        node.functionExpression.parameters,
      );
    }
    super.visitFunctionDeclaration(node);
  }
}
