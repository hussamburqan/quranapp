import 'package:flutter/material.dart';

import 'Home_Page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage ({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.green,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                //Padding
                const SizedBox(height: 120),
                //Logo
                Image.asset('images/quranlogo.png',height: 250,),
                //Padding
                const SizedBox(height: 50),
                //Title
                const Text('القرآن الكريم',style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold),),
                //Padding
                const SizedBox(height: 10),
                //Sub Title
                const Text('تطبيق تجريبي للتشجيع على قراءة القرآن',style: TextStyle(fontSize: 20),),
                //Padding
                const SizedBox(height: 50),
                //Buttom
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context)=> const HomePage()
                      ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12)
                    ),
                    padding: const EdgeInsets.all(25),
                    child: const Center(
                      child: Text(
                        'دخول',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}
