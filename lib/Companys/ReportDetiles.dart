import 'package:dawerf/Companys/HomePageCompany.dart';
import 'package:dawerf/Utiils/User.dart';
import 'package:dawerf/Utiils/colors.dart';
import 'package:dawerf/Utiils/common_widgets.dart';
import 'package:dawerf/Utiils/text_font_family.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
UpdateCompany(){
print(ReportDet.documentID);
  FirebaseFirestore.instance
      .collection('reporting-service')
      .doc(ReportDet.documentID)
      .update({
    //"companyId":User.documentID,
    "companyStatus":0
  }).then((result){
    print("new USer true");
  }).catchError((onError){
    print("onError");
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
        print("documentIDs---- ${f.reference.id}");
      });

      print("yes data22");


      User.numOfOrders ++;
      print("yes sw ${User.numOfOrders}");
      //test=documentData['name'];

      print( User.numOfOrders);
    }

  }).catchError((e) => print("error fetching data: $e"));
}

UpdateCancelCompany(){
  print(ReportDet.documentID);
  FirebaseFirestore.instance
      .collection('reporting-service')
      .doc(ReportDet.documentID)
      .update({
    //"companyId":User.documentID,
    "companyStatus":1
  }).then((result){
    print("new USer true");
  }).catchError((onError){
    print("onError");
  });
}
class ReportDetails extends StatefulWidget {
  @override
  State<ReportDetails> createState() => _ReportDetailsState();
}

class _ReportDetailsState extends State<ReportDetails> {
  Future<void> _launchUrl(String location) async {
    final Uri url = Uri.parse('https://www.google.com/maps/@$location');
    print(url);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
  @override
  Widget build(BuildContext context) {
   return Directionality(
     textDirection: TextDirection.rtl,
     child: Scaffold(
       appBar: AppBar(backgroundColor: ColorResources.custom,),
       body: Padding(
         padding: const EdgeInsets.all(8.0),
         child: SingleChildScrollView(
           child: Column(

             children: [
               Center(
                 child: Container(
                   height: 250, width: 400,
           margin: EdgeInsets.all(8.0),
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(10.0),
             image:  DecorationImage(
                   image: NetworkImage(
                       ReportDet.image.toString()
                      ),
                   fit: BoxFit.cover
                 ),)),
               ),
               SizedBox(height: 20,),
               Row(
                 children: [
                   mediumText('تاريخ البلاغ',ColorResources.redF22, 20),
                   mediumText( ReportDet.dateAdded.toString(),ColorResources.black, 20),
                 ],
               ),
               SizedBox(height: 20,),
               Row(
                 children: [
                   mediumText('نوع البلاغ',ColorResources.redF22, 20),
                   mediumText( ReportDet.typeReport.toString(),ColorResources.black, 20),
                 ],
               ),

               SizedBox(height: 20,),
               Row(
                 children: [
                   mediumText( 'تفاصيل المشكلة:',ColorResources.redF22, 20),
                 ],
               ),
               Row(
                 children: [

                   Container(

                     width: 350,
                    
                     child:   Text(ReportDet.description.toString(),maxLines:5,  style: TextStyle(
                         fontFamily: TextFontFamily.KHALED_FONT,
                         fontSize: 18,
                         color: ColorResources.black),overflow:TextOverflow.ellipsis ),
                   ),


                 ],
               ),
               SizedBox(height: 10,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Column(
                     children: [
                        InkWell(
                          onTap: () {
                             LaunchMap(ReportDet.location.toString());
                            

                          },
                          child: Image(
                           image: AssetImage('assets/images/map.png'),
                           width: 50,
                           height: 50.0,
                       ),
                        ),
                       mediumText( 'اضفط لعرض الموقع على الخريطة',ColorResources.greyA0A, 15),
                     ],
                   ),


                 ],
               ),
               SizedBox(height: 5,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                   MaterialButton(

                     color: ColorResources.custom,
                     onPressed: () async {

                       SnackBar snackBar;
                       await UpdateCompany().then(
                          await getcom(User.phone, User.password),
                    
                        snackBar = SnackBar(
                       content: mediumText(
                       'تم قبول العملية بنجاح',
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

                     },
                     child:mediumText('قبول العملية',ColorResources.whiteF6F,18),
                   ),
                   MaterialButton(
                     onPressed: (){

                       SnackBar snackBar;
                       UpdateCancelCompany().then(
                           snackBar = SnackBar(
                             content: mediumText(
                                 'تم رفض العملية بنجاح',
                                 ColorResources.whiteF6F,
                                 14),
                             backgroundColor: (Colors.red),
                             action: SnackBarAction(
                               label: 'موافق',
                               onPressed: () {

                               },
                             ),
                           ),
                           ScaffoldMessenger.of(context)
                               .showSnackBar(snackBar)
                       );

                     },
                     color: ColorResources.redF22,

                     child:mediumText('رفض',ColorResources.whiteF6F,18),
                   ),
                 ],
               )

             ],
           ),


         ),
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