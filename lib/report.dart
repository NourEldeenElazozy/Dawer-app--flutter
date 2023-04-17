import 'dart:async';
import 'dart:io';
import 'package:dawerf/HomeScreen/dawer_home.dart';
import 'package:dawerf/Utiils/User.dart';
import 'package:dawerf/menu.dart';
import 'package:intl/intl.dart' as a ;
import 'package:dawerf/Controller/location_controller.dart';
import 'package:dawerf/HomePage.dart';

import 'package:dawerf/Utiils/colors.dart';
import 'package:dawerf/Utiils/common_widgets.dart';
import 'package:dawerf/Utiils/images.dart';
import 'package:dawerf/Utiils/text_font_family.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:dawerf/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';
import 'package:geolocator/geolocator.dart';
import 'package:quickalert/quickalert.dart';

class ReportScreen extends StatefulWidget {
  ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {

  var mylocations;
  Completer<GoogleMapController> _controller = Completer();
// on below line we have specified camera position
// camera code 
  static const CameraPosition _kGoogle = CameraPosition(
    target: LatLng(20.42796133580664, 80.885749655962),
    zoom: 14.4746,
  );
  final List<Marker> _markers = <Marker>[
    const Marker(
        markerId: MarkerId('1'),
        position: LatLng(1.42796133580664, 1.885749655962),
        infoWindow: InfoWindow(
          title: 'My Position',
        )
    ),
  ];
  Future<Position> getUserCurrentLocation() async {
    
    await Geolocator.requestPermission().then((value){
    }).onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR"+error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }
  final LocationController locationController = Get.put(LocationController());

  final TextEditingController typeController = TextEditingController();
  final TextEditingController aryaController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final TextEditingController NoteController = TextEditingController();
  final TextEditingController TitleController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();

  final TextEditingController addressController = TextEditingController();
  CollectionReference report = FirebaseFirestore.instance.collection('reporting-service');


  CollectionReference notifications = FirebaseFirestore.instance.collection('notifications');

  Future<void> addReporting(typeReport,description,companyStatus,companyId,location,image,dateAdded) {
    // Call the user's CollectionReference to add a new Report
    return report
        .add({
      'typeReport': typeReport,
      'description': description,
      'companyStatus': companyStatus,
      'companyId': companyId,
      'location': location,
      'images': image,
      'dateAdded': dateAdded,
      'assignedCompany':null,
      'favorite': false,
      'senderPhone': User.phone,
      'title': TitleController.text,
      'area': selectedLocation2,
    })
        .then((value) => print("Report Added $value"))
        .catchError((error) => print("Failed to add user: $error"));
  }
  Future<void> Addnotifications(date,title) {
    User.numOfOrders ++;
    // Call the user's CollectionReference to add a new user
    return notifications
        .add({
      'title': "تم وصول بلاغك بنجاح",
      'phone': User.phone,
      'date': date,
    })
        .then((value) => print("Report Added $value"))
        .catchError((error) => print("Failed to add user: $error"));
  }
  String selectedLocation = '';
  String selectedLocation2 = '';
  List<String> _listDrugs= [];
  List<String> _listDrugs2= [];


  final ImagePicker _picker = ImagePicker();
  var imageurl;
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

          imageurl=value
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

  Future getsections() async {
    if (_listDrugs.length>4) {
      _listDrugs.length = 4;
    }

    FirebaseFirestore.instance.collection("sections").get().then(
          (value) {
        value.docs.forEach(
              (element) {
            print(element.data().values.toString());
            _listDrugs.add(element.data().values.toString());
          },
        );
      },
    );
    }
  Future getareas() async {

    if (_listDrugs2.length>5) {
      _listDrugs2.length = 5;
    }

    FirebaseFirestore.instance.collection("areas").get().then(
          (value) {
        value.docs.forEach(
              (element) {
                var field = element.data();
            print(element.data().values.toString());
            _listDrugs2.add( field['title']);
          },
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    DateTime today = new DateTime.now();
    String dateSlug ="${today.year.toString()}-${today.month.toString().padLeft(2,'0')}-${today.day.toString().padLeft(2,'0')}";
    print('dateSlug=$dateSlug');

    getsections();
    getareas();



    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: ColorResources.whiteF6F,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
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
                  physics: ClampingScrollPhysics(),
                  controlsBuilder: (context, details) => Row(
                    children: [

                      SingleChildScrollView(
                        child: Container(
                          width: 200,
                          height: 35,
                          child:  commonButton(() {
                            if(_index>0){
                              print('_index');
                              print(_index);
                              {
                                getUserCurrentLocation().then((value) async {
                                  print(value.latitude.toString() +" "+value.longitude.toString());
                                  mylocations=value.latitude.toString() +" "+value.longitude.toString();
                                  print(mylocations);

                                  // marker added for current users location
                                  _markers.add(
                                      Marker(
                                        markerId: MarkerId("2"),
                                        position: LatLng(value.latitude, value.longitude),
                                        infoWindow: InfoWindow(
                                          title: 'My Current Location',
                                        ),
                                      )
                                  );

                                  // specified current users location
                                  CameraPosition cameraPosition = new CameraPosition(
                                    target: LatLng(value.latitude, value.longitude),
                                    zoom: 14,
                                  );

                                  final GoogleMapController controller = await _controller.future;
                                  controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
                                  addReporting(selectedLocation.substring(1,selectedLocation.length-1), NoteController.text, 1, null, mylocations,imageurl,dateSlug).then((value) {
                                    Addnotifications(dateSlug,NoteController.text) ;
                                  });
                                  QuickAlert.show(
                                    title: '',
                                    text:'تم إضافة النموذج بنجاح',
                                    confirmBtnText: 'موافق',
                                    onConfirmBtnTap: () {
                                    Get.to(DawerHome());

                                    },
                                    context: context,
                                    type: QuickAlertType.success,
                                    
                                  );
                                  setState(() {
                                    
                                  });
                                });
                              }
                            }


                            if (_index <= 0) {
                              setState(() {
                                _index += 1;
                              });
                            }


                          }, "التالي", Colors.orange, ColorResources.white),
                        ),
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
                      content: SingleChildScrollView(
                        child: Column(
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
                                                            Colors.orange,
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
                                                            Colors.orange,
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
                                      backgroundColor: Colors.orange,
                                      child: SvgPicture.asset(Images.cameraImage),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 50),
                            Container(
                                child: mediumText(
                                    'الرجاء رفع أو تصوير صورة تكون واضحة على المشكلة',
                                    ColorResources.grey9AA,
                                    15)),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                     Step(
                      title: Text('إدخال تفاصيل المشكلة'),
                      content: Column(
                        children: [
                          Container(

                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                mediumText('نوع المخالفة', ColorResources.black4A4, 16),
                                DropdownButton<String>(
                                  hint: bookText(selectedLocation,ColorResources.black4A4,16),


                                  items: _listDrugs.map((String value)  {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: mediumText(value,ColorResources.black4A4,16),
                                    );
                                  }).toList(),

                                  onChanged: (newVal) {

                                    selectedLocation=newVal!;




                                    this.setState(() {



                                    });
                                  },
                                ),



                              ],
                            ),
                          ),
                          Container(

                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                mediumText('المنطقة', ColorResources.black4A4, 16),
                                DropdownButton<String>(
                                  hint: bookText(selectedLocation2,ColorResources.black4A4,16),


                                  items: _listDrugs2.map((String value)  {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: mediumText(value,ColorResources.black4A4,16),
                                    );
                                  }).toList(),

                                  onChanged: (newVal) {

                                    selectedLocation2=newVal!;




                                    this.setState(() {



                                    });
                                  },
                                ),



                              ],
                            ),
                          ),
                          Container(
                            width: 500,
                            height: 200,
                            child: SafeArea(
                              // on below line creating google maps
                              child: GoogleMap(
                               myLocationEnabled: true,
                                // on below line setting camera position
                                initialCameraPosition: _kGoogle,
                                // on below line we are setting markers on the map
                                markers: Set<Marker>.of(_markers),
                                // on below line specifying map type.
                                mapType: MapType.normal,
                                // on below line setting user location enabled.
                                // on below line setting compass enabled.
                                compassEnabled: true,
                                // on below line specifying controller on map complete.
                                onMapCreated: (GoogleMapController controller){
                                  _controller.complete(controller);
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          Container(
                            child: TextField(
                              controller: NoteController,
                              decoration: InputDecoration(
                                hintText: 'ملاحظات',
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(width: 3, color: Colors.orangeAccent), //<-- SEE HERE
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                              ),

                            )
                          ),
                          SizedBox(height: 20,),
                          Container(
                              child: TextField(
                                controller: TitleController,
                                decoration: InputDecoration(
                                  hintText: 'عنوان البلاغ',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(width: 3, color: Colors.orangeAccent), //<-- SEE HERE
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                ),

                              )
                          ),
                          SizedBox(height: 20,),




                        ],

                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
              ],
            ),
          ),
        ),


      ),
    );
  }
}