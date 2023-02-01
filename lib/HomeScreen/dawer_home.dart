import 'package:carousel_slider/carousel_slider.dart';

import 'package:dawerf/Utiils/colors.dart';
import 'package:dawerf/Utiils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  final CollectionReference containers =
  FirebaseFirestore.instance.collection('containers');

  final CollectionReference ads =
  FirebaseFirestore.instance.collection('ads');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
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
          Flexible(
            child: StreamBuilder(
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
            ),
          ),
        ],
      ),
    );

  }}

/*
Scaffold(
        body: Column(
          children: [
            Expanded(
              child: ListView(children: [
                CarouselSlider(
                  items: [
                    Container(
                      width: 500,
                      margin: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: NetworkImage(
                              "https://pbs.twimg.com/profile_images/1108430392267280389/ufmFwzIn_400x400.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        children: [
                          Text('dddd'),
                          Text('dddd'),
                          Text('dddd'),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: NetworkImage(
                              "https://resize.indiatvnews.com/en/centered/newbucket/1200_675/2020/11/breaking-1603159815-1604711829.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: NetworkImage(
                              "https://media-cldnry.s-nbcnews.com/image/upload/newscms/2019_01/2705191/nbc-social-default.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                  options: CarouselOptions(
                    height: 380.0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration:
                    Duration(milliseconds: 800),
                    viewportFraction: 0.8,
                  ),
                ),
              ]),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            Expanded(
              child: ListView(
                children: [
                  Container(
                    width: 500,
                    height: 200,
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7ZuCSW7_2Ja2b2mQ5c20oseOSiYG73e-tgw&usqp=CAU"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(50.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              bookText(
                                  "الفرناج", ColorResources.redF21, 50),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 500,
                    height: 200,
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7ZuCSW7_2Ja2b2mQ5c20oseOSiYG73e-tgw&usqp=CAU"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(50.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              bookText("المدينة القديمة",
                                  ColorResources.redF21, 40),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      );
 */