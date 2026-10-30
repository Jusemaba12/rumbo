import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rumbo/features/auth/presentation/providers/sign_in/sign_in_provider.dart';
import 'package:rumbo/features/auth/presentation/providers/sign_in/sign_in_state.dart';
import 'package:rumbo/shared/configurations/language/app_localizations.dart';
import 'package:rumbo/shared/configurations/theme/app_colors.dart';
import 'package:rumbo/shared/configurations/theme/app_theme.dart';
import 'package:rumbo/shared/presentation/extensions/build_context_extension.dart';
import 'package:rumbo/shared/presentation/widgets/notice_banner.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  static final RegExp _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  // Supabase permite configurar códigos de 6 a 10 dígitos.
  static const int _minCodeLength = 6;
  static const int _maxCodeLength = 10;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _code = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _code.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    // Al verificar, el router redirige al detectar la sesión.
    await ref
        .read(signInControllerProvider.notifier)
        .submit(email: _email.text, code: _code.text);
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    final ThemeData theme = Theme.of(context);
    final SignInState signIn = ref.watch(signInControllerProvider);
    final bool codeSent = signIn.codeSent;
    final bool busy = signIn.isLoading;
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
                  children: <Widget>[
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
                      enabled: !codeSent && !busy,
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const <String>[AutofillHints.email],
                      autocorrect: false,
                      decoration: InputDecoration(labelText: l10n.emailLabel),
                      validator: (String? value) =>
                          _emailPattern.hasMatch(value?.trim() ?? '')
                          ? null
                          : l10n.emailInvalid,
                    ),
                    if (codeSent) ...<Widget>[
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _code,
                        enabled: !busy,
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        autofillHints: const <String>[
                          AutofillHints.oneTimeCode,
                        ],
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(_maxCodeLength),
                        ],
                        decoration: InputDecoration(labelText: l10n.codeLabel),
                        validator: (String? value) {
                          final int length = value?.trim().length ?? 0;
                          return length >= _minCodeLength &&
                                  length <= _maxCodeLength
                              ? null
                              : l10n.codeInvalid;
                        },
                      ),
                    ],
                    if (signIn.hasFailed) ...<Widget>[
                      const SizedBox(height: 16),
                      NoticeBanner(
                        text: l10n.signInError,
                        icon: Icons.error_outline,
                        tone: Tone.risk,
                      ),
                    ],
                    const SizedBox(height: 24),
                    FilledButton(
                      onPressed: busy ? null : _submit,
                      child: Text(codeSent ? l10n.verifyCode : l10n.sendCode),
                    ),
                    if (codeSent)
                      TextButton(
                        onPressed: busy
                            ? null
                            : () {
                                _code.clear();
                                ref
                                    .read(signInControllerProvider.notifier)
                                    .changeEmail();
                              },
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
