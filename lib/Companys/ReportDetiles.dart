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
    "companyId":User.documentID
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
                            _launchUrl(ReportDet.location.toString());

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
                     onPressed: (){

                       SnackBar snackBar;
                       UpdateCompany().then(
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

                     color: ColorResources.redF22,
                     onPressed: (){


                     },
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

}