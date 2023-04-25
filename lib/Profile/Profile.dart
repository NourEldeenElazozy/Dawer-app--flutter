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


class Profile extends StatefulWidget {




  @override

  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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

                                stream: FirebaseFirestore.instance.collection('companies')
                                    .where("phone", isEqualTo: User.phone.toString())
                                    .where("password", isEqualTo: User.password.toString()).snapshots(),
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
                                        Get.to(WelcomeScreen());
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
                                        child: InkWell(
                                          onTap: (){
                                            showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alertDialog3();
                            },);
                                          },
                                          child: Center(
                                            child:  mediumText("خروج",ColorResources.white,16),
                                          ),
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

class alertDialog3 extends StatefulWidget {
  @override
  State<alertDialog3> createState() => _alertDialogState();
}

class _alertDialogState extends State<alertDialog3> {


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
              title: mediumText('هل تريد تسجيل الخروج؟',ColorResources.black,18),
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
                                    content: mediumText(
                                        'تم انهاء العملية بنجاح',
                                        ColorResources.whiteF6F,
                                        14);
                                    backgroundColor: (Colors.green);
                                   
                                  
                                   Get.offAll(WelcomeScreen(),transition: Transition.fade);
                              setState(() {

                              });


                          },
                          child:mediumText('نعم',ColorResources.whiteF6F,14),
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
                            setState(() {

                            });


                          },
                          child:mediumText('لا',ColorResources.white,14),
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