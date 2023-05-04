import 'package:dawerf/AuthScreens/WelcomeScreen.dart';
import 'package:dawerf/Profile/Profile2.dart';
import 'package:dawerf/Utiils/User.dart';
import 'package:dawerf/Utiils/colors.dart';
import 'package:dawerf/Utiils/common_widgets.dart';
import 'package:dawerf/Utiils/text_font_family.dart';
import 'package:dawerf/chatpage..dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';


class Profile2 extends StatefulWidget {




  @override

  _Profile2State createState() => _Profile2State();
}

class _Profile2State extends State<Profile2> {
  @override
  void initState() {
    super.initState();
    setState(() {
      print('dd');
    });

  }
  @override
  Widget build(BuildContext context) {
    int? numw;
    getcom(phone, pass) async {
      await FirebaseFirestore.instance
          .collection('users')
          .where("name", isEqualTo: User.name)

          .get()
          .then((event) {
        if (event.docs.isNotEmpty) {
          Map<String, dynamic> documentData =
          event.docs.single.data(); //if it is a single document

          event.docs.forEach((f) {
            User.documentID = f.reference.id;
            print("documentID---- ${f.reference.id}");
          });



          User.numOfOrders = documentData['numOfOrders'];
          numw=documentData['numOfOrders'];
          //test=documentData['name'];
          print("yes data");
          print(numw);
        }

      }).catchError((e) => print("error fetching data: $e"));
    }
    getcom(User.phone, User.password);
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;




    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(backgroundColor:  Colors.deepOrange,),
        body: Container(
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.deepOrange,
                      Colors.orange,
                    ], begin: Alignment.topCenter, end: Alignment.center)),
              ),
              Scaffold(
                backgroundColor: Colors.transparent,
                body: Container(
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.only(top: _height / 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              CircleAvatar(

                                backgroundImage:
                                AssetImage('assets/images/logo.png'),backgroundColor: ColorResources.white,
                                radius: _height / 10,
                              ),
                              SizedBox(
                                height: _height / 30,
                              ),
                              mediumText(
                                  User.name.toString(), ColorResources.black, 20),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: _height / 2.2),
                        child: Container(
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: _height / 2.6,
                            left: _width / 20,
                            right: _width / 20),
                        child: Column(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  color:  Colors.deepOrange,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black45,
                                        blurRadius: 2.0,
                                        offset: Offset(0.0, 2.0))
                                  ]),
                              child: Padding(
                                padding: EdgeInsets.all(_width / 20),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      StreamBuilder(

                                        stream: FirebaseFirestore.instance.collection('users')
                                            .where("name", isEqualTo: User.name).snapshots(),
                                        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {

                                          return   mediumText(

                                              streamSnapshot.data!.docs[0]['numOfOrders'].toString()+' بلاغ ', ColorResources.black, 20);
                                        },
                                      ),

                                      Image.asset(

                                        'assets/images/recycle-symbol.png',
                                        width: 24,
                                        height:24,
                                      ),

                                    ]),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: _height / 20),
                              child: Column(
                                children: <Widget>[
                                  InkWell(

                                    child: infoChild(
                                        _width, Icons.support_agent, 'خدمة العملاء'),
                                    onTap: (){
                                      Get.to(chatpage(email:User.name,));
                                    },
                                  ),

                                  InkWell(
                                    onTap: (){
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return alertDialog();
                                        },);},
                                    child: infoChild(
                                        _width, Icons.lock, 'تغيير كلمة المرور'),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(top: _height / 30),
                                    child: InkWell(
                                      onTap: () {
                                           showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alertDialog2();
                            },);
                                      },
                                      child: Container(

                                        width: _width / 3,
                                        height: _height / 20,
                                        decoration: BoxDecoration(
                                            color: ColorResources.redF22,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(_height / 40)),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black87,
                                                  blurRadius: 2.0,
                                                  offset: Offset(0.0, 1.0))
                                            ]),
                                        child: Center(
                                          child:  mediumText("خروج",ColorResources.white,16),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget headerChild(String header, String value) => Expanded(
      child: Column(
        children: <Widget>[
          mediumText(header,ColorResources.black,16),
          SizedBox(
            height: 8.0,
          ),
          Text(
            '$value',
            style: TextStyle(
                fontSize: 14.0,
                color: const Color(0xFF26CBE6),
                fontWeight: FontWeight.bold,fontFamily: TextFontFamily.KHALED_FONT),
          )
        ],
      ));

  Widget infoChild(double width, IconData icon, data) => Padding(
    padding: EdgeInsets.only(bottom: 8.0),
    child: InkWell(
      child: Row(
        children: <Widget>[
          SizedBox(
            width: width / 10,
          ),
          Icon(
            icon,
            color: ColorResources.custom,
            size: 36.0,
          ),
          SizedBox(
            width: width / 20,
          ),
          mediumText(data,ColorResources.black,16),
        ],
      ),

    ),
  );
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
class alertDialog2 extends StatefulWidget {
  @override
  State<alertDialog2> createState() => _alertDialogState2();
}

class _alertDialogState2 extends State<alertDialog2> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [


         AlertDialog(


              scrollable: true,
              title: mediumText('تسجيل الخروج؟',ColorResources.black,18),
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
                            Get.to(WelcomeScreen());

                          },
                          child:mediumText('تسجيل خروج',ColorResources.whiteF6F,14),
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


                        

                          },
                          child:mediumText('إلغاء',ColorResources.white,14),
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