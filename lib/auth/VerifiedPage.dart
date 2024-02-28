import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class VerifiedPage extends StatelessWidget {
  const VerifiedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 200),
            const Text('Verify your account to continue.\n If there is no message in your email,\n click here',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(const Color(0xBEFFFFFF))),
                onPressed: () async {
                    FirebaseAuth.instance.currentUser!.sendEmailVerification();
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.success,
                    animType: AnimType.rightSlide,
                    title: 'Sent to Email',
                    desc: 'We sent a link to your email to verify the account',
                  ).show();
                },
                child: const Text('Send to email',
                  style: TextStyle(
                      color: Colors.black
                  ),
                )
            ),
            const SizedBox(height: 10),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(const Color(0xBEFFFFFF))),
                onPressed: () async {
                  GoogleSignIn googlesignin = GoogleSignIn();
                  googlesignin.disconnect();
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushNamedAndRemoveUntil('login', (route) => false);
                },
                child: const Text('login out',
                  style: TextStyle(
                      color: Colors.black
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}
