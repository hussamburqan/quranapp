import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}


class _ProfileState extends State<Profile> {

  File? file;
  String? url;
  late QuerySnapshot data;
  bool isloading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: getData(),builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (snapshot.hasError) {
        return Center(
          child: Text('Error: ${snapshot.error}'),
        );
      } else if (snapshot.hasData) {
        return Column(
          children: [
            const SizedBox(height: 100),
            data.docs[0]['mainpic'] != 'null'
                ? Center(
              child: Image.network(
                data.docs[0]['mainpic'],
                height: 100,
                width: 100,
              ),
            )
                : const Center(
                child: Icon(Icons.person, size: 100)),
            const SizedBox(height: 10),
            ElevatedButton(
                style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.green)),
                onPressed: () {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.noHeader,
                    animType: AnimType.rightSlide,
                    title: 'Choose what you want to complete',
                    btnCancelColor: Colors.green,
                    btnOkColor: Colors.lightGreen,
                    btnCancelText: 'Camera' ,
                    btnCancelOnPress: () {
                      _pickimagefromcamera(context,'camera');
                    },
                    btnOkText: 'Galary',
                    btnOkOnPress: () {
                      _pickimagefromcamera(context,'galary');
                    },
                  ).show();
                },
                child: const Text('Change Photo',style: TextStyle(color: Colors.black),)
            ),
            const SizedBox(height: 30),
            Card(
              color: Colors.green,
              child: SizedBox(width: 380,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${data.docs[0]['name']}',style: const TextStyle(
                            fontSize: 20,fontWeight: FontWeight.bold)),
                        InkWell(
                            onTap: () {

                            },
                            child: const Icon(Icons.edit,size: 30)
                        ),
                      ]
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Card(
              color: Colors.green,
              child: SizedBox(width: 380,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${data.docs[0]['email']}',
                          style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                        ),
                        const Icon(Icons.email_rounded,size: 30),
                      ],

                    )
                ),
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.green)),
                onPressed: () {

                },
                child: const Text('Change Password',
                  style: TextStyle(color: Colors.black),)
            ),
          ],
        );
      }else {
        return const Center(
          child: Text('No data available'),
        );
      }
    },

    );
  }

  getData() async {
    isloading = true;
    data = await FirebaseFirestore.instance
        .collection('Users')
        .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get();
    isloading = false;
    return data;
  }

  Future<void> _pickimagefromcamera(context,String type) async {
    try {
      final ImagePicker picker = ImagePicker();
      late XFile? imagecamera;
      if(type == 'camera'){
        imagecamera = await picker.pickImage(source: ImageSource.camera);
      } else if(type == 'galary'){
        imagecamera = await picker.pickImage(source: ImageSource.gallery);
      }
      if (imagecamera != null) {
        file = File(imagecamera.path);
        var imagename = basename(imagecamera.path);
        var refStorge = FirebaseStorage.instance.ref('images').child(imagename);
        await refStorge.putFile(file!);
        url = await refStorge.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('Users')
            .doc(data.docs[0].id)
            .update({'mainpic': url});

        setState(() {});

        AwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          animType: AnimType.rightSlide,
          title: 'Wait for some time\nto upload the image',
          desc: 'when the image changed you see it',
        ).show();
      }
    } catch (e) {
      print("Error uploading image: $e");
    }
    setState(() {});
  }

}
