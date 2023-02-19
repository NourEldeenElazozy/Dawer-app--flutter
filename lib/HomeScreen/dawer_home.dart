import 'package:carousel_slider/carousel_slider.dart';
import 'package:dawerf/Profile/Profile.dart';

import 'package:dawerf/Utiils/colors.dart';
import 'package:dawerf/Utiils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
class DawerHome extends StatefulWidget {
  const DawerHome({Key? key}) : super(key: key);

  @override
  State<DawerHome> createState() => _DawerHomeState();
}

CollectionReference student = FirebaseFirestore.instance.collection('students');

class _DawerHomeState extends State<DawerHome> {
  CollectionReference student = FirebaseFirestore.instance.collection('users');
  final firestoreInstance = FirebaseFirestore.instance;
  // Initial Selected Value
  String dropdownvalue = 'طرابلس';

  // List of items in our dropdown menu
  var items = [
    'بنغازي',
    'طرابلس',
  ];

  //استدعاء مواقع صناديق القمامة
  final CollectionReference containers =
  FirebaseFirestore.instance.collection('containers');

  //استدعاء الإعلانات
  final CollectionReference ads =
  FirebaseFirestore.instance.collection('ads');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(


              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(


                      height:40,
                      width: 40,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(100)
                        //more than 50% of width makes circle
                      ),
                      child: IconButton(icon:const Icon(Icons.person,),color: Colors.grey.shade500, onPressed: (

                          ) {    Get.to(Profile()); }, ),
                    ),
                  )
                ],
              ),
            ),
            StreamBuilder(
                stream: ads.snapshots(),

                builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.hasData){

                    return Container(

                        child: CarouselSlider.builder(

                          itemCount: streamSnapshot.data!.docs.length,
                          options: CarouselOptions(
                            aspectRatio: 2.0,
                            enlargeCenterPage: true,
                            autoPlay: true,
                          ),
                          itemBuilder: (ctx, index, realIdx) {
                            final DocumentSnapshot documentSnapshot =
                            streamSnapshot.data!.docs[index];
                            return Container(
                              width: 500,
                              margin: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image:  DecorationImage(
                                  image: NetworkImage(
                                      documentSnapshot['image'].toString()),
                                  fit: BoxFit.cover

                                ),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      mediumText(documentSnapshot['title'],ColorResources.black, 25),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      mediumText(documentSnapshot['description'],ColorResources.black, 20),
                                    ],
                                  ),



                                ],
                              ),
                            );
                          },
                        ));
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
            ),



            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  mediumText(
                      "جميع صناديق القمامة", ColorResources.grey777, 16),
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
              height: 250,
              child:     StreamBuilder(
                stream: containers.snapshots(), //build connection
                builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.hasData) {
                    return ListView.builder(
                      itemCount: streamSnapshot.data!.docs.length,  //number of rows
                      itemBuilder: (context, index) {
                        final DocumentSnapshot documentSnapshot =
                        streamSnapshot.data!.docs[index];
                        return Container(
                          width: 500,
                          height: 200,
                          margin: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            image: DecorationImage(
                              image: NetworkImage(
                                  documentSnapshot['image']),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    bookText(
                                        documentSnapshot['address'], ColorResources.whiteF6F, 40),
                                  ],
                                ),
                              )
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
              ) ,
            )

          ],
        ),
      ),
    );

  }}

