import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/notice_banner.dart';
import '../data/auth_repository.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  static final _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  // Supabase permite configurar códigos de 6 a 10 dígitos.
  static const _minCodeLength = 6;
  static const _maxCodeLength = 10;

  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _code = TextEditingController();
  bool _codeSent = false;
  bool _busy = false;
  bool _failed = false;

  @override
  void dispose() {
    _email.dispose();
    _code.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _busy = true;
      _failed = false;
    });
    final auth = ref.read(authRepositoryProvider);
    final email = _email.text.trim();
    try {
      if (_codeSent) {
        // El router redirige al detectar la sesión.
        await auth.verifyCode(email: email, code: _code.text.trim());
      } else {
        await auth.sendCode(email);
        if (mounted) setState(() => _codeSent = true);
      }
    } catch (_) {
      if (mounted) setState(() => _failed = true);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: context.colors.hero,
                          borderRadius: BorderRadius.circular(
                            AppTheme.radius - 2,
                          ),
                        ),
                        child: Icon(
                          Icons.explore_outlined,
                          size: 30,
                          color: context.colors.heroAccent,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      l10n.signInTitle,
                      style: AppTheme.screenTitle(context),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.signInSubtitle,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: context.colors.muted,
                      ),
                    ),
                    const SizedBox(height: 28),
                    TextFormField(
                      controller: _email,
                      enabled: !_codeSent && !_busy,
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const [AutofillHints.email],
                      autocorrect: false,
                      decoration: InputDecoration(labelText: l10n.emailLabel),
                      validator: (value) =>
                          _emailPattern.hasMatch(value?.trim() ?? '')
                          ? null
                          : l10n.emailInvalid,
                    ),
                    if (_codeSent) ...[
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _code,
                        enabled: !_busy,
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        autofillHints: const [AutofillHints.oneTimeCode],
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(_maxCodeLength),
                        ],
                        decoration: InputDecoration(labelText: l10n.codeLabel),
                        validator: (value) {
                          final length = value?.trim().length ?? 0;
                          return length >= _minCodeLength &&
                                  length <= _maxCodeLength
                              ? null
                              : l10n.codeInvalid;
                        },
                      ),
                    ],
                    if (_failed) ...[
                      const SizedBox(height: 16),
                      NoticeBanner(
                        text: l10n.signInError,
                        icon: Icons.error_outline,
                        tone: Tone.risk,
                      ),
                    ],
                    const SizedBox(height: 24),
                    FilledButton(
                      onPressed: _busy ? null : _submit,
                      child: Text(_codeSent ? l10n.verifyCode : l10n.sendCode),
                    ),
                    if (_codeSent)
                      TextButton(
                        onPressed: _busy
                            ? null
                            : () => setState(() {
                                _codeSent = false;
                                _failed = false;
                                _code.clear();
                              }),
                        child: Text(l10n.changeEmail),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
