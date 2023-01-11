import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/signup/presentation/pages/signup_view.dart';
import 'package:todo/packages/auth_service/lib/auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Flutter Demo',
      home: RepositoryProvider(
        create: (context) => FirebaseAuthService(
          authService: FirebaseAuth.instance,
        ),
        child: const SignUpView(),
      ),
    );
  }
}
