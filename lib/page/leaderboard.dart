import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({Key? key});

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  late List<QueryDocumentSnapshot> data = [];

  Future<List<QueryDocumentSnapshot>> getData() async {
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection('Users').get();
    data = querySnapshot.docs;
    return data;
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, AsyncSnapshot<List<QueryDocumentSnapshot>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (snapshot.hasData) {
          return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var userData = snapshot.data![index].data() as Map<String, dynamic>; // Explicit cast to Map<String, dynamic>
                  return Card(
                    child: Container(padding: EdgeInsets.all(10),
                      height: 100,
                      child: Row(
                        children: [
                          userData['mainpic'] != 'null'
                              ? Image.network(
                            userData['mainpic'],
                            height: 70,
                            width: 70,
                          )
                              : const Icon(Icons.person,
                            size: 70,
                            ),

                          Text(userData['name']),
                          Flexible(child: Container()),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(userData['score'] != null ? userData['score'].toString() : '0'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
        } else {
          return const Center(
            child: Text('No data available'),
          );
        }
      },
    );
  }
}
