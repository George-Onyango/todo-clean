import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/packages/auth_service/lib/auth.dart';

import '../bloc/login_bloc.dart';
import 'login_view.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        authService: context.read<FirebaseAuthService>(),
      ),
      child: const LoginView(),
    );
  }
}
