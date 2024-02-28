import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quran/components/mytextfield.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../components/passtextfield.dart';

class IntroPage extends StatefulWidget {
  IntroPage ({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();


  Future signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if(googleUser == null){
      return ;
    }

    final GoogleSignInAuthentication? googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);

    Navigator.of(context).pushNamedAndRemoveUntil('homepage', (route) => false);
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.green,
      body: ListView(children: [
        Form(
          key: formState,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  //Padding
                  const SizedBox(height: 50),
                  //Logo
                  Image.asset('images/quranlogo.png',height: 250),
                  //Padding
                  const SizedBox(height: 10),
                  //Title
                  const Text('القرآن الكريم',style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold),),
                  //Sub Title
                  const Text('تطبيق تجريبي للتشجيع على قراءة القرآن',style: TextStyle(fontSize: 20),),
                  //Padding
                  const SizedBox(height: 20),
                  //textfield email
                  MyTextField(
                      hinttext: 'Enter your email' ,
                      mycontroller: email ,
                      validator: (val) {
                        if (val == '') {
                          return 'ادخل الايميل';
                        }
                        return null;
                      }
                  ),
                  const SizedBox(height: 10),
                  //textfield password
                  PassTextField(
                      hinttext: 'Enter your password' ,
                      mycontroller: password,
                      validator: (val) {
                        if (val == '') {
                          return 'ادخل كلمة المرور';
                        }
                        return null;
                      }
                  ),
                  InkWell(
                      onTap: () async{
                          if (email.text != '') {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.warning,
                              animType: AnimType.rightSlide,
                              title: '${email.text}',
                              desc: 'Are you sure to send a password reset message to your email?',
                              btnCancelOnPress: () {

                              },
                              btnOkText: 'Yes',
                              btnOkOnPress: () async{
                                try {
                                  await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.success,
                                    animType: AnimType.rightSlide,
                                    title: 'success',
                                    desc: 'If the written email exists,\ncheck your email to reset the password',
                                  ).show();
                                }
                                catch(e){
                                  print(e);
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.error,
                                    animType: AnimType.rightSlide,
                                    title: 'Error',
                                    desc: 'Write Correct email',
                                  ).show();}
                              },
                            ).show();
                          }else{
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              title: 'Error',
                              desc: 'Write the email in the fill',
                            ).show();
                          }
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 20),
                        alignment: Alignment.centerRight,
                        child: const Text(
                          "هل نسيت كلمة المرور ؟",
                          style: TextStyle(
                            color: Color(0xFF1A1A1A),
                            fontSize: 14,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  //Buttom
                  MaterialButton(
                    height: 40,
                    minWidth: 400,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Colors.black,
                    textColor: Colors.white,
                    onPressed: () async {

                        if (formState.currentState!.validate()) {
                          try {
                            //isLoading = true;
                            setState(() {});
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                email: email.text,
                                password: password.text
                            );
                            //isLoading = false;
                            setState(() {});
                            Navigator.of(context).pushNamedAndRemoveUntil('homepage',(route) => false);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'invalid-email') {
                              //isLoading = false;
                              setState(() {});
                              print('No user found for that email.');
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                title: 'Error',
                                desc: 'No user found for that email.',
                              ).show();
                            } else if (e.code == 'invalid-credential') {
                              //isLoading = false;
                              setState(() {});
                              print('Wrong password provided for that user.');

                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                title: 'Error',
                                desc: 'Wrong email or password.',
                              ).show();

                            } else {
                              //isLoading = false;
                              setState(() {});
                              print(e);
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                title: 'Error',
                                desc: '${e.code}',
                              ).show();
                            }
                          }
                        }
                      },
                    child: const Text('Login' , style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(height: 10),
                  MaterialButton(
                    height: 40,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Colors.red[900],
                    textColor: Colors.white,
                    onPressed: () async{
                        signInWithGoogle();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Login With Google  "),
                        Image.asset(
                          "images/Google.png",
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed("signup");
                    },
                    child: const Center(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "ليس لديك حساب ؟ ",
                              style: TextStyle(fontWeight: FontWeight.bold)
                            ),
                            TextSpan(
                              text: "قم باللإنشاء",
                              style: TextStyle(
                                color: Color(0xFFFFF1EF),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]
      ),
    );
  }
}
