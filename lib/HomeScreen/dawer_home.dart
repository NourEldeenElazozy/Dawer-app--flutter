import 'package:carousel_slider/carousel_slider.dart';
import 'package:dawerf/NewsPage.dart';
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

  final CollectionReference advertisement =
  FirebaseFirestore.instance.collection('advertisement');

  //استدعاء الإعلانات
  final CollectionReference ads = FirebaseFirestore.instance.collection('ads');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),

                    )
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  mediumText("مايحدث الأن", ColorResources.black, 16),
                ],
              ),
            ),
            Container(
              width: double.infinity,

              child: StreamBuilder(
                stream: advertisement.snapshots(), //build connection
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.hasData) {
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
                                image: DecorationImage(
                                    image: NetworkImage(
                                        documentSnapshot['image'].toString()),
                                    fit: BoxFit.cover),
                              ),

                            );
                          },
                        ));
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            SizedBox(height: 50,),
            StreamBuilder(
                stream: ads.snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.hasData) {
                    return Container(
                      height: 350,
                        width: 400,
                        child: CarouselSlider.builder(
                          itemCount: streamSnapshot.data!.docs.length,
                          options: CarouselOptions(
                            scrollDirection: Axis.vertical,
                            aspectRatio: 2.0,
                            enlargeCenterPage: true,
                            autoPlay: true,
                          ),
                          itemBuilder: (ctx, index, realIdx) {
                            final DocumentSnapshot documentSnapshot =
                            streamSnapshot.data!.docs[index];
                            return InkWell(
                              onTap: () {
                                Get.to(NewsPage(documentSnapshot['title'],documentSnapshot['description'],documentSnapshot['image']));
                              },
                              child: Container(
                                width: 500,


                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          documentSnapshot['image'].toString()),
                                      fit: BoxFit.cover),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        mediumText(documentSnapshot['title'],
                                            ColorResources.black, 25),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        mediumText(documentSnapshot['description'],
                                            ColorResources.black, 20),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ));
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
            SizedBox(
              height: 15,
            ),
            /*
               Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 120,
                  width: 120,
                  padding: new EdgeInsets.all(10.0),
                  child: Card(
                    child: _buildButtonColumn(
                        Colors.cyan,

                      "assets/images/Vector.png",

                        'الأخبار'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                Container(
                  height: 120,
                  width: 120,
                  padding: new EdgeInsets.all(10.0),
                  child: Card(
                    child: _buildButtonColumn(
                        ColorResources.redF22,   "assets/images/fff.png", 'الحاويات'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                Container(
                  height: 120,
                  width: 120,
                  padding: new EdgeInsets.all(10.0),
                  child: Card(
                    child: _buildButtonColumn(
                        ColorResources.green,   "assets/images/recycle-symbol.png", 'بلاغ'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
              ],
            ),
             */



          ],
        ),
      ),
    );
  }
}

Column _buildButtonColumn(Color color, String img, String label) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
       Image.asset(

         img,
        width: 24,
        height:24,
      ),

      Container(
        margin: const EdgeInsets.only(top: 8),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: color,
          ),
        ),
      ),
    ],
  );
}
