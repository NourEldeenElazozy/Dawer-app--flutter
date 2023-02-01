import 'package:dawerf/HomePage.dart';
import 'package:dawerf/HomeScreen/dawer_home.dart';
import 'package:dawerf/Utiils/colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';



class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscure = true;
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(  centerTitle: true,backgroundColor:  ColorResources.green129,
          title:  const Text('D A W E R', textAlign: TextAlign.center),
        ),
        body:  Form(
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


                    controller: emailController,
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
                        Icons.supervised_user_circle_outlined,
                      ),
                      labelText: "اسم المستخدم ",
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
                        icon: Icon(  _isObscure ? Icons.visibility_off : Icons.visibility),
                        onPressed: (){
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



                     onPressed: () {

                      if (formKey.currentState!.validate()) {
                        Get.to(HomePage());
                        /*
                          LoginCubit.get(context).userLogin(
                            userName: emailController.text,
                            password: passwordController.text,
                          );


                           */
                      }
                    },child: const Text('دخول')
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                   Center(
                    child: InkWell(
                      onTap: () {


                     },
                      child:  const Text("سجل الأن", style:  TextStyle(color: Colors.blue, decoration: TextDecoration.underline),),

                  ),
                  )

                ],
              ),
            ),
          ),
        ),
      )
      ),
    );
  }
}
