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
UpdateCompany(){
  print('ReportDet.documentID');
  print(ReportDet.documentID);
  FirebaseFirestore.instance
      .collection('reporting-service')
      .doc(ReportDet.documentID)
      .update({
    //"companyId":User.documentID,

    "companyStatus":3
  }).then((result){
    print("new USesr true");
  }).catchError((onError){
    print('onErrorss');
    print(onError);
  });
}


Updatenum(){
  print(User.documentID);
  FirebaseFirestore.instance
      .collection('companies')
      .doc(User.documentID)
      .update({
    'numOfOrders': FieldValue.increment(1),
  }).then((result){
    print("new companies  true");
  }).catchError((onError){
    print("onError companies");
  });
}
getcom(phone, pass) async {
  await FirebaseFirestore.instance
      .collection('companies')
      .where("phone", isEqualTo: phone.toString())
      .where("password", isEqualTo: pass.toString())
      .get()
      .then((event) {
    if (event.docs.isNotEmpty) {
      Map<String, dynamic> documentData =
      event.docs.single.data(); //if it is a single document

      event.docs.forEach((f) {
        User.documentID = f.reference.id;
        print("documentID---- ${f.reference.id}");
      });


      User.name = documentData['name'];
      User.phone = documentData['phone'];
      User.password = documentData['password'];
      User.city = documentData['city'];
      User.numOfOrders = documentData['numOfOrders'];
      //test=documentData['name'];
      print("yes data");
      print( User.numOfOrders);
    }

  }).catchError((e) => print("error fetching data: $e"));
}
UpdateRemoveCompany(){
  print(ReportDet.documentID);
  FirebaseFirestore.instance
      .collection('reporting-service')
      .doc(ReportDet.documentID)
      .update({
    "companyId":null,
    "companyStatus":0
  }).then((result){
    print("new USer true");
  }).catchError((onError){
    print("onError");
  });
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
                where("companyId", isEqualTo: User.documentID). where("companyStatus", isEqualTo: 0)
                   .snapshots(),

              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if(streamSnapshot.data?.size == 0){
                  return  Center(
                    child: mediumText("لا يوجد عمليات تم قبولها", Colors.red, 20),
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
                          ReportDet.documentID= documentSnapshot.id;


                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alertDialog2();
                            },);

                        },
                        child: Container(


                          margin: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              boxShadow: [
                               
                              ],
                              color: Colors.grey.withAlpha(20)

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
                                                documentSnapshot['description'], Colors.black54, 18),

                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 20,),
                                      Center(
                                        child: Row(

                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                          children:  [
                                            mediumText('اضغط في حالة الإنتهاء ', Colors.black26, 18),

                                            mediumText(  documentSnapshot['dateAdded'], Colors.black26, 14),


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
                          onPressed: () async {



                              SnackBar snackBar;
                              UpdateCompany().then(
                                  Updatenum(),
                                  await getcom(User.phone,User.password),
                                  snackBar = SnackBar(
                                    content: mediumText(
                                        'تم انهاء العملية بنجاح',
                                        ColorResources.whiteF6F,
                                        14),
                                    backgroundColor: (Colors.green),
                                    action: SnackBarAction(
                                      label: 'موافق',
                                      onPressed: () {

                                      },
                                    ),
                                  ),
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar),   Get.back()
                              );
                              setState(() {

                              });


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
                            Get.back();


                            SnackBar snackBar;
                            UpdateRemoveCompany().then(
                                snackBar = SnackBar(
                                  content: mediumText(
                                      'تم حذف العملية بنجاح',
                                      ColorResources.whiteF6F,
                                      14),
                                  backgroundColor: (Colors.green),
                                  action: SnackBarAction(
                                    label: 'موافق',
                                    onPressed: () {

                                    },
                                  ),
                                ),
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar)
                            );
                            setState(() {

                            });


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