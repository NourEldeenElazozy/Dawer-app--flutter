import 'package:dawerf/AuthScreens/Login.dart';
import 'package:dawerf/AuthScreens/Login_company.dart';
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
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: ColorResources.green129,
            title: const Text('D A W E R', textAlign: TextAlign.center),
          ),
          body:Column(
            children: [
              Center(
                child: Container(
                  child:  const Image(
                    image: AssetImage('assets/images/logo.png'),
                    height: 200.0,
                  ),
                ),

              ),
              Column(
                children: [
                  InkWell(
                    onTap: (){
                      Get.to(LoginCompanyScreen());
                    },
                    child: Padding(padding: EdgeInsets.all(20),
                      child:commonButton(null, 'شركة خاصة', ColorResources.blue0C1, ColorResources.whiteF6F) ,

                    ),
                  ),
                  Divider(),
                  InkWell(
                    onTap: (){
                      Get.to(LoginScreen());
                    },
                    child: Padding(padding: EdgeInsets.all(20),
                      child:commonButton(null , 'مستخدم', ColorResources.custom, ColorResources.whiteF6F) ,

                    ),
                  ),

                ],
              )

            ],

          )

      ),
    );
  }
}
