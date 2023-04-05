import 'package:dawerf/Utiils/colors.dart';
import 'package:dawerf/Utiils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:timeago/timeago.dart' as timeago;
class NotificationScreen extends StatelessWidget {
   NotificationScreen({Key? key}) : super(key: key);
  final CollectionReference notifications =
  FirebaseFirestore.instance.collection('notifications');
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(

        children: [
          Flexible(
            child: StreamBuilder(
              stream: notifications.snapshots(), //build connection
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,  //number of rows
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                      return Row(
mainAxisAlignment: MainAxisAlignment.center,
             
                              children: [
                                Container(
                                                width: 80,
                                                height: 80,
                                                margin: EdgeInsets.all(0.0),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(0.0),
                                                  image: DecorationImage(
                                                    image: AssetImage('assets/images/logo.png'),

                                                    fit: BoxFit.cover,
                                                  ),
                                                ),

                                              ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Card(
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
                                                child: Column(
                                                  children: [
                                                    
                                                    Row(
                                                      children: [
                                                      
                                                           mediumText(documentSnapshot['title'], ColorResources.custom, 18),
                                                      
                                                      ],
                                                    ),
                                                    Row(

                                                      children: [
                                                      
                                                           mediumText(timeago.format(documentSnapshot['date'].toDate()), ColorResources.grey777, 15),
                                                      
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              

                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),


                          // Container(
                          //   width: 350,
                          //   height: 120,

                          //   margin: const EdgeInsets.all(10.0),
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(30.0),
                          //       boxShadow: [
                          //         BoxShadow(
                          //           color: Colors.indigo.withOpacity(0.4),
                          //           spreadRadius: 5,
                          //           blurRadius: 7,
                          //           offset: const Offset(0, 3), // changes position of shadow
                          //         ),
                          //       ],
                          //     color: ColorResources.whiteF6F

                          //   ),
                          //   child: Column(
                          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //     children: [
                          //       Row(
                          //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //         children: [

                          //           mediumText(
                          //               documentSnapshot['title'], ColorResources.custom, 25),
                          //         ],),
                          //       Row(

                          //         mainAxisAlignment: MainAxisAlignment.center,

                          //         children:  [
                          //           mediumText(timeago.format(documentSnapshot['date'].toDate()), ColorResources.grey777, 25),



                          //         ],
                          //       ),


                          //     ],


                          //   ),
                          // ),
                        ],
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
      ),
    );
  }
}
