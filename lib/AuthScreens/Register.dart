import 'package:dawerf/AuthScreens/Login.dart';
import 'package:dawerf/HomePage.dart';
import 'package:dawerf/HomeScreen/dawer_home.dart';
import 'package:dawerf/Utiils/colors.dart';
import 'package:dawerf/Utiils/common_widgets.dart';
import 'package:dawerf/Utiils/text_font_family.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dawerf/Utiils/User.dart';

import 'package:get/get.dart';

class RigesterScreen extends StatefulWidget {
  @override
  _RigesterScreenState createState() => _RigesterScreenState();
}

class _RigesterScreenState extends State<RigesterScreen> {
  late String test;
  CollectionReference User = FirebaseFirestore.instance.collection('users');
  Future<void> Rigistermethod(name,phone,city,pass) {
    // Call the user's CollectionReference to add a new user
    return User
        .add({
      'name': name, // John Doe
      'phone': phone, // Stokes and Sons
      'city': city,
      'pass': pass,
      'numOfOrders': 0,


    })
        .then((value) => test='yes data')
        .catchError((error) => test='no data');
  }


  bool _isObscure = true;

  var cityController = TextEditingController();
  var nameController = TextEditingController();
  var mobileController = TextEditingController();
  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.deepOrange,
            title:  mediumText('بيئتي',ColorResources.white,18),
          ),
          body: Form(
            key: formKey,
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Image(
                        image: AssetImage('assets/images/logo.png'),
                        height: 250.0,
                      ),

                      mediumText(
                          'مرحباً بك  معًا من أجل بيئة نظيفة',
                          ColorResources.blue0C1,
                          18
                      ),const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        enabled: true,
                        keyboardType: TextInputType.name,

                        controller: nameController,
                        //controller: emailController..text = '119900408110',
                        validator: (value) {
                          if (value!.length <=3 ) {
                            print('dd');
                            return 'يجب ان يكون اسم المستخدم اكبر من 3 حروف';
                          }
                          if (value == null || value.isEmpty) {
                            print('dd');
                            return 'يجب كتابة اسم المستخدم';
                          }
                          return null;
                        },
                        decoration:  InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                          ),
                          labelStyle:TextStyle( fontFamily: TextFontFamily.KHALED_FONT,),
                          labelText: "اسم المستخدم",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        enabled: true,
                        keyboardType: TextInputType.name,

                        controller: cityController,
                        //controller: emailController..text = '119900408110',
                        validator: (value) {
                          if (value!.length <=3 ) {
                            print('dd');
                            return 'يجب ان يكون اسم المدينة اكبر من 3 حروف';
                          }
                          if (value == null || value.isEmpty) {
                            print('dd');
                            return 'يجب كتابة المدينة';
                          }
                          return null;
                        },
                        decoration:  InputDecoration(
                          prefixIcon: Icon(
                            Icons. location_on_outlined,
                          ),
                          labelStyle:TextStyle( fontFamily: TextFontFamily.KHALED_FONT,),
                          labelText: "المدينة",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        enabled: true,
                        keyboardType: TextInputType.phone,

                        controller: mobileController,
                        //controller: emailController..text = '119900408110',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            print('dd');
                            return 'يجب كتابة رقم الهاتف';
                          }
                          return null;
                        },
                        decoration:  InputDecoration(
                          prefixIcon: Icon(
                            Icons.phone,
                          ),
                          labelStyle:TextStyle( fontFamily: TextFontFamily.KHALED_FONT,),
                          labelText: "رقم الهاتف ",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        enabled: true,
                        controller: passwordController,
                        obscureText: _isObscure,
                        validator: (value) {
                            if (value!.length <6 ) {
                            print('dd');
                            return 'يجب ان تكون كلمة المرور على الأقل 6 خانات';
                          }
                          if (value!.isEmpty) {
                            return 'يجب كتابة كلمة المرور';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.lock_open_outlined,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(_isObscure
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          ),
                          labelStyle:TextStyle( fontFamily: TextFontFamily.KHALED_FONT,),
                          labelText: 'كلمة المرور',
                          border:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        height: 40.0,
                        width: double.infinity,
                        child: MaterialButton(
                            color: Colors.deepOrange,
                            splashColor: ColorResources.custom,
                            shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.transparent)),
                            elevation: 5,
                            onPressed: () async {
                              print(mobileController.text);
                              print(passwordController.text);
                              if (formKey.currentState!.validate()) {
                                await Rigistermethod(
                                  nameController.text.toString(),
                                    mobileController.text.toString(),
                                  cityController.text.toString(),
                                    passwordController.text.toString(),
                                );
                                if (test == 'no data') {
                                  final snackBar = SnackBar(
                                    content: mediumText(
                                        'خطاء في بيانات التسجيل',
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
                                } else if (test == 'yes data') {
                                  final snackBar = SnackBar(
                                    content: mediumText(
                                        'تم التسجيل بنجاح',
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
                                  Get.offAll(LoginScreen(), transition: Transition.fadeIn);
                                }

                                /*
                          LoginCubit.get(context).userLogin(
                            userName: emailController.text,
                            password: passwordController.text,
                          );


                           */
                              }
                            },
                            child:  mediumText('تسجيل',ColorResources.white,14)),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),

                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
