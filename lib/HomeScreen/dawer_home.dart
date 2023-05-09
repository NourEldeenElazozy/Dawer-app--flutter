import 'package:carousel_slider/carousel_slider.dart';
import 'package:dawerf/NewsPage.dart';
import 'package:dawerf/Utiils/colors.dart';
import 'package:dawerf/Utiils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
class DawerHome extends StatefulWidget {

    final PageController pageViewController =  PageController();
     DawerHome({Key? key}) : super(key: key);

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
    PersistentTabController controller;
    controller = PersistentTabController(initialIndex: 0);
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
             Padding(
               padding: const EdgeInsets.only(left: 25.0, right: 25),
               child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [

                    mediumText("مايحدث الأن", ColorResources.black, 16),
                  ],
                ),
             ),
           StreamBuilder(
             stream: ads.snapshots(),
             builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if(streamSnapshot.hasData){
                return ListView.separated(
                        shrinkWrap: true,
                        itemCount:streamSnapshot.data!.docs.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                          return InkWell(
                            onTap: ()
                            {
                              if(documentSnapshot['image'].toString() != null)
                              {
                                  Get.to(NewsPage(documentSnapshot['title'],documentSnapshot['description'],documentSnapshot['image'], timeago.format(documentSnapshot['date'].toDate())));                              }
                            },
                             child: Container(
                              padding: EdgeInsets.all(17),
                              margin: EdgeInsets.only(left: 25, right: 25),
                              decoration: BoxDecoration(color:  Colors.grey.withAlpha(30),borderRadius: BorderRadius.circular(8)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 120,
                                    width: 110,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                    child: 
                                    Image.network( documentSnapshot['image'].toString(),fit: BoxFit.fill,width: 110,height: 110),
                                  ),
                                  const SizedBox(width: 20,),
                                  Expanded(
                                    child: SizedBox(
                                      height: 120,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(child: Text(documentSnapshot['title'], overflow:TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: 16, height: 1.5, fontWeight: FontWeight.w600))
                                          ),
                                         Text(documentSnapshot['description'], overflow:TextOverflow.ellipsis,maxLines: 3,
                                            style: TextStyle(fontSize: 12, color: Colors.grey, height: 1,)),
                                          
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(timeago.format(documentSnapshot['date'].toDate()),style: Theme.of(context).textTheme.labelMedium),
                                              
                                            ],
                                          ),
                                ],
                              )
                              
                             ),
                             
                                  ),
                                ],
                              ),
                             )
                             
                          );
                          
                        }
                        , separatorBuilder: (BuildContext context, int index) { return Container(height: 15);},
                );
              }else
                return _widthOutNetworkView();
               
           }
           ),
                // StreamBuilder(
                //     stream: ads.snapshots(),
                //     builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                //       if (streamSnapshot.hasData) {
                //         return Container(
                //           height: 350,
                //             width: 400,
                //             child: CarouselSlider.builder(
                //               itemCount: streamSnapshot.data!.docs.length,
                //               options: CarouselOptions(
                //                 scrollDirection: Axis.vertical,
                //                 aspectRatio: 2.0,
                //                 enlargeCenterPage: true,
                //                 autoPlay: true,
                //               ),
                //               itemBuilder: (ctx, index, realIdx) {
                //                 final DocumentSnapshot documentSnapshot =
                //                 streamSnapshot.data!.docs[index];
                //                 return InkWell(
                //                   onTap: () {
                //                     Get.to(NewsPage(documentSnapshot['title'],documentSnapshot['description'],documentSnapshot['image']));
                //                   },
                //                   child: Container(
                //                     width: 500,
           
           
                //                     margin: EdgeInsets.symmetric(horizontal: 5.0),
                //                     decoration: BoxDecoration(
                //                       borderRadius: BorderRadius.circular(10.0),
                //                       image: DecorationImage(
                //                           image: NetworkImage(
                //                               documentSnapshot['image'].toString()),
                //                           fit: BoxFit.cover),
                //                     ),
                //                     child: Column(
                //                       children: [
                //                         Row(
                //                           children: [
                //                             mediumText(documentSnapshot['title'],
                //                                 ColorResources.black, 25),
                //                           ],
                //                         ),
                //                         Row(
                //                           children: [
                //                             mediumText(documentSnapshot['description'],
                //                                 ColorResources.black, 20),
                //                           ],
                //                         ),
                //                       ],
                //                     ),
                //                   ),
                //                 );
                //               },
                //             ));
                //       }
                //       return const Center(
                //         child: CircularProgressIndicator(),
                //       );
                //     }),
                SizedBox(
                  height: 15,
                ),
                
                     
             
          
           ]
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
 
  Widget _widthOutNetworkView(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:
        [
          Image.asset("assets/images/noInternet.png",fit: BoxFit.contain,height: 125,width: 125,),
          SizedBox(height: 10,),
          DefaultTextStyle(
            style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w500),
            child: Text("Check Internet and try again ☺",style: TextStyle(color: Colors.black.withOpacity(0.8)),)
          ),
        ],
      ),
    );
  }
 
