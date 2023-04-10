import 'package:dawerf/Utiils/colors.dart';
import 'package:dawerf/Utiils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class Containers extends StatefulWidget {
  const Containers({Key? key}) : super(key: key);

  @override
  State<Containers> createState() => _ContainersState();
}

class _ContainersState extends State<Containers> {
  String dropdownvalue = 'طرابلس';
  var items = [
    'بنغازي',
    'طرابلس',
  ];

  Future<void> _launchUrl(String location) async {
    final Uri url = Uri.parse('https://www.google.com/maps/$location');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
  final CollectionReference containers =
  FirebaseFirestore.instance.collection('containers');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: SingleChildScrollView(
       child: Padding(
          padding: const EdgeInsets.all(20.0),
          child:Column(

            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    mediumText("جميع صناديق القمامة", ColorResources.grey777, 16),
                    DropdownButton(
                      value: dropdownvalue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 500,
                child: StreamBuilder(
                  stream: containers.snapshots(), //build connection
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      return ListView.builder(

                        itemCount:
                        streamSnapshot.data!.docs.length, //number of rows
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                          return InkWell(
                            onTap: ()  {

                             // _launchUrl(documentSnapshot['location']);
                             LaunchMap(documentSnapshot['location']);
                             
                            },
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Card(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                      elevation: 10,
                                      color: Theme.of(context).colorScheme.surfaceVariant,
                                      child:  SizedBox(
                                        width: 350,
                                        height: 100,
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding:  EdgeInsets.all(10.0),
                                                child: Row(

                                                  children: [
                                                  Center(
                                                    child:   mediumText(documentSnapshot['address'],
                                                        ColorResources.black4A4, 20),
                                                  )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 150,
                                                height: 200,
                                                margin: EdgeInsets.all(0.0),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(0.0),
                                                  image: DecorationImage(
                                                    image: NetworkImage(documentSnapshot['image']),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),

                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),


                              ],
                            ),
                          );
                        },
                      );
                    }

                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              )
            ],
          )
        ),
     ),
    );
    
  }

  Future<void> LaunchMap(documentSnapshot) async {
   final String googleMapslocationUrl = "https://www.google.com/maps/search/?api=1&query=${documentSnapshot}";
    final String encodedURl = Uri.encodeFull(googleMapslocationUrl);

    if (await canLaunch(encodedURl)) {
      await launch(encodedURl);
    } else {
      print('Could not launch $encodedURl');
      throw 'Could not launch $encodedURl';
    }
  }
  
  
}
