import 'package:flutter_firebase_auth/login_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:machsite/admin_viewpage.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: LoginScreen("AI MACHINAE", "Please Sign In", {
      "loginGitHub": false,
      "loginGoogle": true,
      "loginEmail": false,
      "loginSSO": false,
      "loginAnonymous": true,
      "signupOption": false,
    }));
  }
}
