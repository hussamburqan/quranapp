import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quran/components/my_bottom_navbar.dart';
import 'package:quran/Bottom_quran.random.dart';
import 'package:quran/page/activite.dart';
import 'package:quran/page/leaderboard.dart';
import 'package:quran/page/profile.dart';
import '../auth/VerifiedPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedindex = 0;

  late QuerySnapshot<Map<String, dynamic>> data; // Make sure to define data properly

  bool isloading = true;

  // Define getData() as a Future method
  Future<void> getData() async {
    setState(() {
      isloading = true;
    });
    try {
      data = await FirebaseFirestore.instance
          .collection('Users')
          .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
          .get();
      setState(() {
        isloading = false;
      });
    } catch (error) {
      setState(() {
        isloading = false;
      });
      print("Error fetching data: $error");
    }
  }

  final List<Widget> _pages = const [
    PageQuranRandom(),
    LeaderBoard(),
    Activite(),
    Profile(),
  ];

  void navigateBottomBar(int index) {
    setState(() {
      _selectedindex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return (FirebaseAuth.instance.currentUser!.emailVerified == false)
        ? const VerifiedPage()
        : isloading
        ? const Scaffold(
          backgroundColor: Colors.green,
           body: Center(child: CircularProgressIndicator()),
          )
        : Scaffold(
          bottomNavigationBar:
            MyBottomNavBar(onTabChange: navigateBottomBar),
               backgroundColor: Colors.greenAccent.shade100,
               body: _pages[_selectedindex],
               appBar: AppBar(
                 title: Row(
                   children: [
                     Text(
                       'Welcome ${data.docs[0]['name']}',
                       style: const TextStyle(fontWeight: FontWeight.bold),
                     ),
                     const Spacer(),
                     Text(
                       '${data.docs[0]['score']}',
                       textAlign: TextAlign.right,
                       style: const TextStyle(fontWeight: FontWeight.bold),
                     ),
                   ],
                 ),
                 backgroundColor: Colors.green,
               ),
    );
  }
}
