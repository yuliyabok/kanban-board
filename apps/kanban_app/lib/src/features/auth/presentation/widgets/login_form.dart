import 'package:flutter/material.dart';

enum AuthFormMode { signIn, register }

class LoginForm extends StatefulWidget {
  const LoginForm({
    required this.isLoading,
    required this.onSignIn,
    required this.onRegister,
    super.key,
  });

  final bool isLoading;
  final void Function(String email, String password) onSignIn;
  final void Function(String email, String password, String? displayName)
  onRegister;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _displayNameController = TextEditingController();

  AuthFormMode _mode = AuthFormMode.signIn;

  bool get _isRegistering => _mode == AuthFormMode.register;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _displayNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onSurface;

    return Form(
      key: _formKey,
      child: AutofillGroup(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              _isRegistering ? 'Регистрация' : 'Вход',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            SegmentedButton<AuthFormMode>(
              segments: const [
                ButtonSegment(
                  value: AuthFormMode.signIn,
                  label: Text('Вход'),
                  icon: Icon(Icons.login),
                ),
                ButtonSegment(
                  value: AuthFormMode.register,
                  label: Text('Регистрация'),
                  icon: Icon(Icons.person_add_alt),
                ),
              ],
              selected: {_mode},
              onSelectionChanged: widget.isLoading
                  ? null
                  : (selection) {
                      setState(() => _mode = selection.single);
                    },
            ),
            const SizedBox(height: 24),
            if (_isRegistering) ...[
              TextFormField(
                controller: _displayNameController,
                style: TextStyle(color: textColor),
                autofillHints: const [AutofillHints.name],
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Имя',
                ),
              ),
              const SizedBox(height: 12),
            ],
            TextFormField(
              controller: _emailController,
              style: TextStyle(color: textColor),
              autofillHints: const [AutofillHints.email],
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Почта',
              ),
              validator: (value) {
                final email = value?.trim() ?? '';
                if (email.isEmpty) {
                  return 'Укажите почту';
                }
                if (!email.contains('@')) {
                  return 'Введите корректную почту';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _passwordController,
              style: TextStyle(color: textColor),
              autofillHints: const [AutofillHints.password],
              obscureText: true,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Пароль',
              ),
              onFieldSubmitted: (_) => _submit(),
              validator: (value) {
                final password = value ?? '';
                if (password.isEmpty) {
                  return 'Укажите пароль';
                }
                if (_isRegistering && password.length < 8) {
                  return 'Минимум 8 символов';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: widget.isLoading ? null : _submit,
              icon: widget.isLoading
                  ? const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Icon(_isRegistering ? Icons.person_add_alt : Icons.login),
              label: Text(_isRegistering ? 'Создать аккаунт' : 'Войти'),
            ),
          ],
        ),
      ),
    );
  }

  void _submit() {
    final form = _formKey.currentState;
    if (form == null || !form.validate()) {
      return;
    }

    final email = _emailController.text;
    final password = _passwordController.text;
    if (_isRegistering) {
      widget.onRegister(
        email,
        password,
        _displayNameController.text.trim(),
      );
      return;
    }

    widget.onSignIn(email, password);
  }
}
