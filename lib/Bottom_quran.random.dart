import 'dart:math';
import 'package:flutter/material.dart';
import 'package:al_quran/al_quran.dart';

class PageQuranRandom extends StatefulWidget {

  const PageQuranRandom({super.key});

  @override
  State<PageQuranRandom> createState() => _PageQuranRandomState();
}

class _PageQuranRandomState extends State<PageQuranRandom> {
  var intValue = 1 ;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 150),

            Text(AlQuran.getBismillah.ar,style: const TextStyle(fontSize: 40)),

            const SizedBox(height: 40),

            Text(AlQuran.surahDetails.bySurahNumber(intValue).name , style: const TextStyle(fontSize: 35)),

            Text('عدد الآيات ${AlQuran.surahDetails.bySurahNumber(intValue).ayahs.length.ar}' , style: const TextStyle(fontSize: 35)),

            Text('رقم الآية ${AlQuran.surahDetails.bySurahNumber(intValue).number.ar}' , style: const TextStyle(fontSize: 35)),

            ElevatedButton(onPressed: () {
              setState(() {
                intValue = Random().nextInt(113)+1;
              });
            },style: const ButtonStyle(
                shape: MaterialStatePropertyAll<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)))),
                fixedSize: MaterialStatePropertyAll<Size>(Size(220, 50)),
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.green)
            ),
                child: const Text('سُورَة عشوائية',style: TextStyle(fontSize: 25))
            ),

          ],
        ),
      ),
    );
  }
}

