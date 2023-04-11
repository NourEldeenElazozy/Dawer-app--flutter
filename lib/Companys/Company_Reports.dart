import 'package:dawerf/Companys/ReportDetiles.dart';
import 'package:dawerf/Utiils/User.dart';
import 'package:dawerf/Utiils/colors.dart';
import 'package:dawerf/Utiils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;
class CompanyReports extends StatelessWidget {
  CompanyReports({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
Map<String, dynamic>? a;
    getReportsd(id) async {
      await FirebaseFirestore.instance
          .collection('reporting-service')
          .doc(id)
          .get()
          .then((event) {
         (a=event.data() );
         ReportDet.image=a!['images'];
         ReportDet.dateAdded=a!['dateAdded'];
         ReportDet.description=a!['description'];
         ReportDet.location=a!['location'];
         ReportDet.typeReport=a!['typeReport'];
         ReportDet.documentID=id;

      }).catchError((e) => print("error fetching data: $e"));


    }



    return Scaffold(
      body: Column(
        children: [
          Flexible(
            child: StreamBuilder(
              stream:
              FirebaseFirestore.instance.
              collection('reporting-service').
              where("companyId", isEqualTo: User.documentID).
              where("companyStatus", isEqualTo: 1)

                  .snapshots(), //build connection
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if(streamSnapshot.data?.size == 0){
                  return  Center(
                    child: Image.asset("assets/images/404.png"),
                  );
                }
                 if (streamSnapshot.hasData) {
                  return ListView.builder(
                    itemCount: streamSnapshot.data!.size,  //number of rows
                    itemBuilder: (context, index) {

                      final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                      if(streamSnapshot.data?.size == 0){
                        return  Center(
                          child: mediumText("لا يوجد عمليات تم قبولها", Colors.red, 20),
                        );
                      }else{

                      }
                      return InkWell(
                        onTap: (){
                          print(ReportDet.image);

                          getReportsd(documentSnapshot.id);
                          Get.to(ReportDetails());

                        },
                        child: Container(
                          width: double.infinity,
                          height: 100,

                          margin: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: [
                                
                              ],
                              color:Colors.grey.withAlpha(30)

                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(

                                    children: [

                                      Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children:  [

                                          
                                            bookText(
                                                documentSnapshot['description'], ColorResources.grey777, 15),
 SizedBox(
                                            height: 50,
                                            width: 50,
                                            child: const Icon(Icons.recycling_rounded, color: Colors.deepOrange),),

                                          ],
                                        ),
                                      ),
                                      Center(
                                        child: Row(

                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                          children:  [
                                            mediumText('اضغط لمعرفة التفاصيل', ColorResources.grey777, 14),

                                            mediumText(  documentSnapshot['dateAdded'], ColorResources.grey777, 14),


                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                )
                              ],
                            ),
                          ),
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
      ),
    );
  }
}
