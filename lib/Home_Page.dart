import 'package:flutter/material.dart';
import 'package:quran/my_bottom_navbar.dart';
import 'package:quran/page2.dart';
import 'package:quran/page_quran.random.dart';
import 'dart:ui' show ImageFilter;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedindex = 0;

  final List<Widget> _pages = [
    const PageQuranRandom(),
    const Page2(),

  ];
  void navigateBottomBar(int index){
    setState(() {
      _selectedindex = index;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyBottomNavBar(onTabChange: (index) => navigateBottomBar(index)),
      backgroundColor: Colors.greenAccent.shade100,
      body: _pages[_selectedindex],
      drawer: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0 , sigmaY: 10.0 ),
        child: Drawer(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  bottomRight: Radius.circular(40))),
          backgroundColor: Colors.green,
          child: Column(
            children: [
              //Logo
              DrawerHeader(padding: const EdgeInsets.only(top:  30), child: Image.asset('images/quranlogo.png')),

              Padding(
                padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.black),
                child: const ListTile(
                    leading: Icon(Icons.home,color: Colors.white,),
                    title: Text('home', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
              const SizedBox(height: 5),

                Padding(
                padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.black),
                child: const ListTile(
                    leading: Icon(Icons.info,color: Colors.white,),
                    title: Text('about us', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),


      appBar: AppBar(
        centerTitle: true,
        title: const Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(builder: (context) => IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.green,
              size: 40,
            ),
            onPressed: () => Scaffold.of(context).openDrawer()
        ),

        )
      ),
    );
  }
}
