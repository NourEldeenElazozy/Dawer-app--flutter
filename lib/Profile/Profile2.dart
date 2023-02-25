import 'package:dawerf/Utiils/User.dart';
import 'package:dawerf/Utiils/colors.dart';
import 'package:dawerf/Utiils/common_widgets.dart';
import 'package:dawerf/Utiils/text_font_family.dart';
import 'package:dawerf/chatpage..dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
class Profile2 extends StatelessWidget {

  final Stream<QuerySnapshot> products = FirebaseFirestore.instance.collection('users').snapshots();
   Profile2({Key? key}) : super(key: key);

  your_async_method () async {

    await FirebaseFirestore.instance.collection('users').where(
      "name",
        isEqualTo: "فراس"
    ).get().then((event) {
      if (event.docs.isNotEmpty) {
        Map<String, dynamic> documentData = event.docs.single.data(); //if it is a single document
        print('documentData');
        print(documentData['name']);
      }
    }).catchError((e) => print("error fetching data: $e"));
  }





  @override
  Widget build(BuildContext context) {



// Remove the 'service' field from the document



    your_async_method();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(backgroundColor: ColorResources.green129,),
        body: Column(
          children: [
            Container(
              width: 450,
              height: 100,
              margin: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.indigo.withOpacity(0.4),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  color: ColorResources.custom),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Icon(
                                  Icons.tag_faces_rounded,
                                  color: ColorResources.yellow,
                                  size: 40.0,
                                ),
                                Column(
                                  children: [
                                    bookText(
                                        User.name, ColorResources.whiteF6F, 25),
                                    bookText(User.phone.toString(),
                                        ColorResources.whiteF6F, 25),
                                  ],
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      mediumText(
                                          User.numOfOrders.toString()+' بلاغ ', ColorResources.yellow, 20),
                                      const Icon(
                                        Icons.transfer_within_a_station_sharp,
                                        color: ColorResources.yellow,
                                        size: 40.0,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              color: Colors.black,
              height: 2,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Icon(
                    Icons.support_agent,
                    color: ColorResources.yellow,
                    size: 40.0,
                  ),
                ),

                InkWell(
                  onTap: (){
                    Get.to(chatpage(email:User.name,));
                  },
                  child: Container(
                    child: Row(
                      children: [
                        bookText('خدمة العملاء', ColorResources.black, 25),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: (){
        showDialog(
             context: context,
             builder: (BuildContext context) {
            return alertDialog();
              },);},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Icon(
                      Icons.lock,
                      color: ColorResources.yellow,
                      size: 40.0,
                    ),
                  ),

                  Container(
                    child: Row(
                      children: [
                        bookText('تغيير كلمة المرور', ColorResources.black, 25),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class alertDialog extends StatefulWidget {
  @override
  State<alertDialog> createState() => _alertDialogState();
}

class _alertDialogState extends State<alertDialog> {


  var passwordController = TextEditingController();

  var passwordController2 = TextEditingController();

 void  a;
  ChangePass(pass)async{
    await  FirebaseFirestore.instance.collection("users").doc(User.documentID)
        .update({"password": pass}).then(
      (value) {
        User.password=pass;
      },
    );
  }
  @override
  Widget build(BuildContext context) {
  return Directionality(
    textDirection: TextDirection.rtl,
    child: AlertDialog(

    scrollable: true,
    title: mediumText('تغيير كلمة المرور',ColorResources.black,18),
    content: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Form(
    child: Column(
    children: <Widget>[
    TextFormField(
      controller: passwordController,
    decoration: InputDecoration(
    labelText: 'كلمة المرور الحالية',labelStyle: TextStyle(fontFamily: TextFontFamily.KHALED_FONT),
    icon: Icon(Icons.lock_clock),
    ),
    ),
      TextFormField(
        controller: passwordController2,
        decoration: InputDecoration(
          labelText: 'كلمة المرور الجديدة',labelStyle: TextStyle(fontFamily: TextFontFamily.KHALED_FONT),
          icon: Icon(Icons.lock_person),
        ),
      ),
      MaterialButton(

        color: ColorResources.custom,
        onPressed: (){
          if(passwordController.text!=User.password){
            final snackBar = SnackBar(
              content: mediumText(
                  'اسم المستخدم او كلمة المرور غير صحيحة',
                  ColorResources.whiteF6F,
                  14),
              backgroundColor: (Colors.red),
              action: SnackBarAction(
                label: 'موافق',
                onPressed: () {},
              ),
            );
            ScaffoldMessenger.of(context)
                .showSnackBar(snackBar);

          }
          else if(passwordController2.text.length <4){
            final snackBar = SnackBar(
              content: mediumText(
                  'يجب ان تكون كلمة المرور اكثر من 4 حقول',
                  ColorResources.whiteF6F,
                  14),
              backgroundColor: (Colors.red),
              action: SnackBarAction(
                label: 'موافق',
                onPressed: () {},
              ),
            );
            ScaffoldMessenger.of(context)
                .showSnackBar(snackBar);

          }
          else{
            ChangePass(passwordController2.text);
            final snackBar = SnackBar(
              content: mediumText(
                  'تم تغيير كلمة المرور بنجاح',
                  ColorResources.whiteF6F,
                  14),
              backgroundColor: (Colors.green),
              action: SnackBarAction(
                label: 'موافق',
                onPressed: () {},
              ),
            );
            ScaffoldMessenger.of(context)
                .showSnackBar(snackBar);
            Get.back();
          }

        },
        child:mediumText('تأكيد',ColorResources.whiteF6F,18),
      ),

    ],
    ),
    ),
    ),
    ),
  );
  }
}
