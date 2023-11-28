import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:sinavanalizi/features/homepage/homepage_view.dart';

class LoginView extends StatelessWidget {
   LoginView({Key? key}) : super(key: key);
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthFlowBuilder<EmailFlowController>(
        builder: (context, state, controller, _) {
          if (state is AwaitingEmailAndPassword) {
            return Column(
              children: [
                TextField(controller: emailCtrl),
                TextField(controller: passwordCtrl),
                ElevatedButton(
                  onPressed: () {
                    controller.setEmailAndPassword(
                      emailCtrl.text,
                      passwordCtrl.text,
                    );
                  },
                  child: const Text('Sign in'),
                ),
              ],
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
