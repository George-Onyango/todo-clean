import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../packages/auth_service/lib/auth.dart';
import '../bloc/signup_bloc.dart';
import 'signup_view.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupBloc(
        authService: context.read<FirebaseAuthService>(),
      ),
      child: const SignUpView(),
    );
  }
}
