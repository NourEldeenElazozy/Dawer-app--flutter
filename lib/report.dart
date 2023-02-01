import 'dart:io';

import 'package:dawerf/Controller/location_controller.dart';

import 'package:dawerf/Utiils/colors.dart';
import 'package:dawerf/Utiils/common_widgets.dart';
import 'package:dawerf/Utiils/images.dart';
import 'package:dawerf/Utiils/text_font_family.dart';

import 'package:dawerf/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';

class ReportScreen extends StatefulWidget {
  ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final LocationController locationController = Get.put(LocationController());

  final TextEditingController typeController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController dateOfBirthController = TextEditingController();

  final TextEditingController addressController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  var url;
  File? _photo;
  // ignore: prefer_typing_uninitialized_variables

  bool isImageChange = false;

  Future uploadFile() async {
    if (_photo == null) return;

    final fileName = basename(_photo!.path);
    final destination = 'reports/$fileName';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination);


      await ref.putFile(_photo!);





      await  ref.getDownloadURL().then((value) => (

          url=value
      ));

    } catch (e) {
      print(e);
    }
  }
  _getImageGallery() async {

    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  _getImageCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: ColorResources.whiteF6F,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    width: 350,
                    child: Text(
                        "بلغ عن المشكلة الأن وسيتم فريق محترف بالإهتمام بها",
                        style: TextStyle(
                            fontFamily: TextFontFamily.KHALED_FONT,
                            fontSize: 18,
                            color: ColorResources.black),
                        maxLines: 2),
                  ),
                ],
              ),
            ),
            Stepper(
              controlsBuilder: (context, details) => Row(
                children: [
                  Container(
                    width: 200,
                    height: 35,
                    child: commonButton(() {
                      if (_index <= 0) {
                        setState(() {
                          _index += 1;
                        });
                      }
                    }, "التالي", ColorResources.green129, ColorResources.white),
                  ),
                ],
              ),
              currentStep: _index,
              onStepContinue: () {

                if (_index <= 0) {
                  uploadFile();
                  setState(() {
                    _index += 1;

                  });
                }
              },
              onStepTapped: (int index) {
                setState(() {
                  print(_index);
                  _index = index;
                });
              },
              steps: <Step>[
                Step(
                  title: mediumText('تصوير البلاغ', ColorResources.black, 15),
                  content: Column(
                    children: [
                      SizedBox(height: 20),
                      Stack(
                        alignment: Alignment.topCenter,
                        clipBehavior: Clip.none,
                        children: [
                          Center(
                            child: Container(
                              height: 170,
                              width: 170,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: ColorResources.greyEDE,
                              ),
                              child: _photo == null
                                  ? Center(
                                      child: Container(
                                      height: 200,
                                      width: 500,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(Images.report),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ))

                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Image.file(
                                        File.fromUri(
                                            Uri.parse(_photo!.path)),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                          ),

                          Positioned(
                            right: 80,
                            top: -10,
                            child: InkWell(
                              onTap: () {
                                Get.bottomSheet(
                                  Container(
                                    height: 100,
                                    width: Get.width,
                                    color: ColorResources.white,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  _getImageCamera();
                                                  Get.back();
                                                },
                                                child: Icon(
                                                  Icons.camera_alt_outlined,
                                                  color:
                                                      ColorResources.green009,
                                                  size: 28,
                                                ),
                                              ),
                                              Text(
                                                "Camera",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: ColorResources.black,
                                                  fontFamily: TextFontFamily
                                                      .AVENIR_LT_PRO_BOOK,
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            width: 80,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  _getImageGallery();
                                                  Get.back();

                                                },
                                                child: Icon(
                                                  Icons.image_outlined,
                                                  color:
                                                      ColorResources.green009,
                                                  size: 28,
                                                ),
                                              ),
                                              Text(
                                                "Gallery",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: ColorResources.black,
                                                  fontFamily: TextFontFamily
                                                      .AVENIR_LT_PRO_BOOK,
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: ColorResources.green009,
                                child: SvgPicture.asset(Images.cameraImage),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                          child: mediumText(
                              'الرجاء رفع أو تصوير صورة تكون واضحة على المشكلة',
                              ColorResources.grey9AA,
                              15)),
                    ],
                  ),
                ),
                 Step(
                  title: Text('إدخال تفاصيل المشكلة'),
                  content: Column(
                    children: [
                      TextFormField(
                        cursorColor: ColorResources.black,
                        style: TextStyle(
                          color: ColorResources.black,
                          fontSize: 16,
                          fontFamily: TextFontFamily.AVENIR_LT_PRO_BOOK,
                        ),

                        controller: typeController,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [

                                SvgPicture.asset(Images.arrowDownIcon),
                              ],
                            ),
                          ),
                          hintText: "نوع المخالفة",
                          hintStyle: TextStyle(
                            color: ColorResources.greyA0A,
                            fontSize: 18,
                            fontFamily: TextFontFamily.AVENIR_LT_PRO_BOOK,
                          ),
                          filled: true,
                          fillColor: ColorResources.whiteF6F,
                          border: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: ColorResources.greyA0A, width: 1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: ColorResources.greyA0A, width: 1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: ColorResources.greyA0A, width: 1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
