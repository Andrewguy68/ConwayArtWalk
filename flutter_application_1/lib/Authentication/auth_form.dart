import 'package:flutter/material.dart';
import 'package:flutter_application_1/Authentication/auth_service.dart';

class AuthForm extends StatefulWidget {
  //This Has been reused from my previous project (Hang out) which I have modified.
  const AuthForm({
    super.key,
    required this.submitLabel,
    this.emailFieldLabel = 'Email',
    required this.usernameValidator,
    required this.passwordValidator,
    required this.onSubmit,
    required this.footer,
  });

  final String submitLabel;
  final String emailFieldLabel;
  final FormFieldValidator<String> usernameValidator;
  final FormFieldValidator<String> passwordValidator;
  final Future<void> Function(String email, String password) onSubmit;
  final Widget footer;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });

    try {
      await widget.onSubmit(
        _emailController.text.trim(),
        _passwordController.text,
      );
    } catch (error) {
      if (mounted) {
        setState(() => _errorMessage = authErrorMessage(error));
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 420),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: widget.emailFieldLabel),
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              textInputAction: TextInputAction.next,
              validator: widget.usernameValidator,
              enabled: !_isSubmitting,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              textInputAction: TextInputAction.done,
              validator: widget.passwordValidator,
              enabled: !_isSubmitting,
              onFieldSubmitted: (_) => _submit(),
            ),
            if (_errorMessage != null) ...[
              const SizedBox(height: 16),
              Text(
                _errorMessage!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _isSubmitting ? null : _submit,
              child: _isSubmitting
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(widget.submitLabel),
            ),
            widget.footer,
          ],
        ),
      ),
    );
  }
}
