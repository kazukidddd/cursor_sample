import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/core/utils/app_error.dart';
import 'package:todo_app/core/utils/validator.dart';
import 'package:todo_app/features/auth/application/auth_provider.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isSignIn = true;
  bool _isObscure = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      if (_isSignIn) {
        await ref.read(authControllerProvider.notifier).signIn(
              _emailController.text,
              _passwordController.text,
            );
      } else {
        await ref.read(authControllerProvider.notifier).signUp(
              _emailController.text,
              _passwordController.text,
            );
      }

      if (context.mounted) {
        context.go('/todos');
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppError.getMessage(e)),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(_isSignIn ? 'サインイン' : 'サインアップ'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'メールアドレス',
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validator: Validator.validateEmail,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'パスワード',
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                ),
              ),
              obscureText: _isObscure,
              validator: Validator.validatePassword,
            ),
            const SizedBox(height: 32),
            if (state.isLoading)
              const Center(child: CircularProgressIndicator())
            else
              Column(
                children: [
                  ElevatedButton(
                    onPressed: _submit,
                    child: Text(_isSignIn ? 'サインイン' : 'サインアップ'),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isSignIn = !_isSignIn;
                      });
                    },
                    child: Text(_isSignIn ? 'アカウントを作成' : 'サインインに戻る'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
