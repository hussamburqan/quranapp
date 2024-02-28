import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/mytextfield.dart';
import '../components/passtextfield.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  adddata() async {
    try {
      CollectionReference collectionnote =
      FirebaseFirestore.instance.collection('Users');
      await collectionnote.add(
          {
            'email': email.text,
            'name': name.text,
            'mainpic': 'null',
            'score' : 0
          }
      );
    }catch (e){
      rethrow ;
    }
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
                  //title
                  const Text('القرآن الكريم',style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold),),
                  //Padding
                  const SizedBox(height: 10),
                  //Sub Title
                  const Text('قم بإنشاء حسابك لك داخل تطبيقنا', style: TextStyle(fontSize: 20 ),),
                  //Padding
                  const SizedBox(height: 20),
                  MyTextField(
                      hinttext: 'Enter your name' ,
                      mycontroller: name ,
                      validator: (val) {
                        if (val == '') {
                          return 'ادخل الأسم';
                        }
                        return null;
                      }
                  ),
                  const SizedBox(height: 10),
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
                  SizedBox(height: 20),
                  //Buttom
                  MaterialButton(
                    height: 50,
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
                              .createUserWithEmailAndPassword(
                              email: email.text,
                              password: password.text
                          );
                          adddata();
                          //isLoading = false;
                          setState(() {});
                          Navigator.of(context).pushNamedAndRemoveUntil('homepage',(route) => false);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'invalid-email') {
                            //isLoading = false;
                            setState(() {});
                            print('Error in email ');
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              title: 'Error',
                              desc: 'Error in email.',
                            ).show();
                          } else if (e.code == 'weak-password') {
                            //isLoading = false;
                            setState(() {});
                            print('the password very ez');

                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              title: 'Error',
                              desc: 'the password very ez',
                            ).show();

                          } else if (e.code == 'email-already-in-use') {
                            //isLoading = false;
                            setState(() {});
                            print('Email already in use');

                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              title: 'Error',
                              desc: 'Email already in use',
                            ).show();

                          }else {
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
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed("login");
                    },
                    child: const Center(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text: "لديك حساب بالفعل ؟ ",
                                style: TextStyle(fontWeight: FontWeight.bold)
                            ),
                            TextSpan(
                              text: "سَجل",
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
