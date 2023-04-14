import 'package:dawerf/Utiils/User.dart';
import 'package:dawerf/Utiils/colors.dart';
import 'package:dawerf/Utiils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:timeago/timeago.dart' as timeago;
class NotificationScreen extends StatelessWidget {
   NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Column(
        children: [
          Flexible(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('notifications').where("phone", isEqualTo: User.phone).snapshots(),
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

                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20, left: 10,right: 10),
                                    child: Card(
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                      color: Theme.of(context).colorScheme.surfaceVariant,
                                      child:  SizedBox(
                                        width: 350,
                                        height: 100,
                                        
                                        child: Flexible(
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:  EdgeInsets.all(10.0),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    
                                                    Row(
                                                      children: [
                                                      
                                                           mediumText(documentSnapshot['title'], Colors.deepOrange, 18),
                                                          
                                                          Icon(Icons.recycling, color: Colors.deepOrange,)      
                                                      ],
                                                    ),
                                                    
                                                    Row(
                                                      


                                  children:  [
                                    mediumText(documentSnapshot['date'].toString(), ColorResources.grey777, 14),

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