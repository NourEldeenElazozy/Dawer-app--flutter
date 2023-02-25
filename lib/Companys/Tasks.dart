import 'package:dawerf/Companys/ReportDetiles.dart';
import 'package:dawerf/Utiils/User.dart';
import 'package:dawerf/Utiils/colors.dart';
import 'package:dawerf/Utiils/common_widgets.dart';
import 'package:dawerf/Utiils/text_font_family.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;
class TasksReports extends StatefulWidget {
  TasksReports({Key? key}) : super(key: key);

  @override
  State<TasksReports> createState() => _TasksReportsState();
}

class _TasksReportsState extends State<TasksReports> {
  Map<String, dynamic>? a;
  final CollectionReference reporting =
  FirebaseFirestore.instance.collection('reporting-service');
  getReport() async {
    await FirebaseFirestore.instance
        .collection('reporting-service')
        .where(
        "companyId",
        isNotEqualTo: 'RNGdmUBVEn9W7Ag7xJaq'
    )
        .get()
        .then((event) {
          if(event.docs.isEmpty){
            print(12);
          }
          if(event.docs.isNotEmpty){
            (a=event.docs.single.data());
            print(User.documentID);




            ReportDet.image=a!['images'];
            ReportDet.dateAdded=a!['dateAdded'];
            ReportDet.description=a!['description'];
            ReportDet.location=a!['location'];
            ReportDet.typeReport=a!['typeReport'];

            print(1);


          }





    }).catchError((e) => print("error fetching data: $e"));

   return'd';
  }
  @override
  Widget build(BuildContext context) {

    getReport();




    return Scaffold(
      body: Column(
        children: [
          Flexible(
            child: StreamBuilder(
            stream:
               FirebaseFirestore.instance.
                   collection('reporting-service').
                where("companyId", isEqualTo: User.documentID)
                   .snapshots(),

              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if(streamSnapshot.data?.size != 1){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (streamSnapshot.hasData) {


                  return ListView.builder(
                    itemCount:streamSnapshot.data!.docs.length,  //number of rows
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                      return InkWell(
                        onTap: (){



                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alertDialog2();
                            },);

                        },
                        child: Container(
                          width: 450,
                          height: 180,

                          margin: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.indigo.withOpacity(0.4),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                              color: ColorResources.custom

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
                                          children:  [

                                            bookText(
                                                documentSnapshot['description'], ColorResources.white, 25),

                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 50,),
                                      Center(
                                        child: Row(

                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                          children:  [
                                            mediumText('اضغط لمعرفة التفاصيل', ColorResources.white, 18),

                                            mediumText(  documentSnapshot['dateAdded'], ColorResources.white, 25),


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
class alertDialog2 extends StatefulWidget {
  @override
  State<alertDialog2> createState() => _alertDialogState();
}

class _alertDialogState extends State<alertDialog2> {


  var passwordController = TextEditingController();

  var passwordController2 = TextEditingController();

  void  a;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [


         AlertDialog(


              scrollable: true,
              title: mediumText('هل تمت العملية؟',ColorResources.black,18),
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  child: Row(

                    children: <Widget>[

                      Container(
                        width: 130,
                        height: 40,
                        child: MaterialButton(

                          color: ColorResources.custom,
                          onPressed: (){
                          },
                          child:mediumText('تمت العملية',ColorResources.whiteF6F,14),
                        ),
                      ),
                      SizedBox(width: 5,),
                      Container(
                        width: 130,
                        height: 40,
                        child: MaterialButton(

                          color: ColorResources.redF22,
                          onPressed: (){
                          },
                          child:mediumText('حذف العملية',ColorResources.white,14),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),

        ],
      ),
    );
  }
}