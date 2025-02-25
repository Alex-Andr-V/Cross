import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:book_finder/app/features/auth/auth_bloc.dart';
import 'package:go_router/go_router.dart';


class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            // Перенаправляем на главный экран после успешного входа
            context.go('/');
          }
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(LoginRequested(
                      emailController.text,
                      passwordController.text,
                    ));
                  },
                  child: Text('Login'),
                ),
                TextButton(
                  onPressed: () {
                    context.go('/signup'); // Переход на экран регистрации
                  },
                  child: Text('Don\'t have an account? Sign Up'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}