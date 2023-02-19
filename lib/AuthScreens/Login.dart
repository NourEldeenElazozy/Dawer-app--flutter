import 'package:dawerf/HomePage.dart';
import 'package:dawerf/HomeScreen/dawer_home.dart';
import 'package:dawerf/Utiils/colors.dart';
import 'package:dawerf/Utiils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dawerf/Utiils/User.dart';

import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String test;
  logInmethod(phone, pass) async {
    await FirebaseFirestore.instance
        .collection('users')

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

        test = "yes data";
        User.name = documentData['name'];
        User.phone = documentData['phone'];
        User.password = documentData['password'];
        User.city = documentData['city'];
        User.numOfOrders = documentData['numOfOrders'];
        //test=documentData['name'];
        print("yes data");
      }
      if (event.docs.isEmpty) {
        test = "no data";
        print(test);
      }
    }).catchError((e) => print("error fetching data: $e"));
  }

  bool _isObscure = true;
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
            backgroundColor: ColorResources.green129,
            title: const Text('D A W E R', textAlign: TextAlign.center),
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
                      const Text(
                        'سجل دخولك كي تتمكن من استخدام التطبيق',
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        enabled: true,
                        keyboardType: TextInputType.phone,

                        controller: mobileController,
                        //controller: emailController..text = '119900408110',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            print('dd');
                            return 'error';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.phone,
                          ),
                          labelText: "رقم الهاتف ",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        enabled: true,
                        controller: passwordController,
                        //controller: passwordController..text = '119900408110',
                        obscureText: _isObscure,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'err';
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
                          labelText: 'كلمة المرور',
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        height: 40.0,
                        width: double.infinity,
                        child: MaterialButton(
                            color: ColorResources.green129,
                            onPressed: () async {
                              print(mobileController.text);
                              print(passwordController.text);
                              if (formKey.currentState!.validate()) {
                                await logInmethod(
                                    mobileController.text.toString(),
                                    passwordController.text.toString());
                                if (test == 'no data') {
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
                                } else if (test == 'yes data') {
                                   Get.off(HomePage());
                                }

                                /*
                          LoginCubit.get(context).userLogin(
                            userName: emailController.text,
                            password: passwordController.text,
                          );


                           */
                              }
                            },
                            child: const Text('دخول')),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Center(
                        child: InkWell(
                          onTap: () {},
                          child: const Text(
                            "سجل الأن",
                            style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
