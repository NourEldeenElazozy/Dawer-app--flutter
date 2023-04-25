import 'package:dawerf/AuthScreens/Login.dart';
import 'package:dawerf/AuthScreens/Login_company.dart';
import 'package:dawerf/AuthScreens/Register.dart';
import 'package:dawerf/HomePage.dart';
import 'package:dawerf/HomeScreen/dawer_home.dart';
import 'package:dawerf/Utiils/colors.dart';
import 'package:dawerf/Utiils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dawerf/Utiils/User.dart';

import 'package:get/get.dart';
class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late String test;



  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.deepOrange,
            title:  mediumText('بيئتي',ColorResources.white,18),
          ),
          body:Stack(
            children: [



              Container(
                color: Colors.white,

                child: Column(

                  children: [
                    Center(
                      child: Container(
                        child:  const Image(
                          image: AssetImage('assets/images/logo.png'),
                          fit: BoxFit.cover,

                          height: 200.0,
                        ),
                      ),

                    ),
                    SizedBox(
                      height: 150,
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: (){
                            Get.to(LoginScreen(), transition: Transition.circularReveal);
                          },
                          child: Padding(padding: EdgeInsets.all(20),
                            child:commonButton(null, ' تسجيل دخول', Colors.deepOrange, ColorResources.whiteF6F) ,

                          ),
                        ),

                        InkWell(
                          onTap: (){
                            Get.to(RigesterScreen(), transition: Transition.circularReveal);
                          },
                          child: Padding(padding: EdgeInsets.all(20),
                            child:commonButton2(null , 'انشاء حساب', ColorResources.white, ColorResources.custom) ,

                          ),
                        ),


                     TextButton(
                         onPressed: (){
                           Get.to(LoginCompanyScreen(), transition: Transition.downToUp);
                           },
                         child: mediumText('الدخول كشركة', ColorResources.blue0C1, 18)),

                      ],
                    ),


                  ],

                ),
              ),
              Container(
                width: double.infinity,
                height: 350,
                child: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(

                            'assets/images/login.png',
                          ),
                          fit: BoxFit.fill,),),
                    ),
                    Center(
                      child: Container(
                        child:  const Image(
                          image: AssetImage('assets/images/logo.png'),
                          height: 300.0,
                        ),
                      ),

                    ),

                  ],
                ),
             ),


            ],
          )

      ),
    );
  }
}
