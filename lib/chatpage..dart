import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dawerf/ChatScreen.dart';
import 'package:dawerf/HomePage.dart';
import 'package:dawerf/Utiils/User.dart';
import 'package:dawerf/Utiils/colors.dart';
import 'package:dawerf/Utiils/common_widgets.dart';
import 'package:dawerf/Utiils/text_font_family.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';



class chatpage extends StatefulWidget {
  String email;

  chatpage({required this.email});
  @override
  _chatpageState createState() => _chatpageState(email: email);
}

class _chatpageState extends State<chatpage> {
  String email;
  _chatpageState({required this.email});

  final fs = FirebaseFirestore.instance;
  CollectionReference msg = FirebaseFirestore.instance.collection('services');
  //final _auth = FirebaseAuth.instance;
  final TextEditingController message = new TextEditingController();
  late int ticket;
  max2() async {
    await FirebaseFirestore.instance.collection
      ("services").orderBy("ticket",descending: true).limit(1)
        .get()
        .then((event) {
      Map<String, dynamic> documentData =
      event.docs.single.data(); //if it


      if (event.docs.isNotEmpty) {


        User.ticket = documentData['ticket']+1;
        print( User.ticket);
      }

    }).catchError((e) => print("error fetching data: $e"));
  }
  max() async {
    await   FirebaseFirestore.instance.collection
      ("services").orderBy("ticket").limit(1)
        .where("sender", isEqualTo: User.name)
        .get()
        .then((event) {
      Map<String, dynamic> documentData =
      event.docs.single.data(); //if it


      if (event.docs.isNotEmpty) {
        print('ticket isNotEmpty');
        User.ticket= documentData['ticket'];


      }

    }).catchError((e){
      print("error fetching data: $e");
      max2();
    }
   );
  }


  Future<void> addChat(date,text,ticket) {
print('ticket');
print( User.ticket);
    return msg
        .add({
      'date': date,
      'received':'admin', // John Doe
      'sender': User.name, // Stokes and Sons
      'status': 0,
      'text': text,
      'ticket':  User.ticket,

    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
  @override
  Widget build(BuildContext context) {

    max();
    DateTime today = new DateTime.now();
    String dateSlug ="${today.year.toString()}-${today.month.toString().padLeft(2,'0')}-${today.day.toString().padLeft(2,'0')}";
    print('dateSlug=$dateSlug');

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.deepOrange,title:
          mediumText(
           'الدعم الفني',ColorResources.whiteF6F,22
        )),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.79,
                child: messages(
                  email: User.name,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        style: TextStyle(color: ColorResources.black4A4,fontFamily: TextFontFamily.KHALED_FONT),
                        controller: message,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor:Colors.black87.withAlpha(30),
                          hintText: 'محتوي الرسالة',
                          hintStyle: TextStyle(color: ColorResources.black4A4,fontFamily: TextFontFamily.KHALED_FONT),
                          enabled: true,
                          contentPadding: const EdgeInsets.only(
                              left: 14.0, bottom: 8.0, top: 8.0, right: 8),
                          focusedBorder: OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.deepOrange),
                            borderRadius: new BorderRadius.circular(10),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: new BorderSide(color: Colors.blue),
                            borderRadius: new BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {},
                        onSaved: (value) {
                          message.text = value!;
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {

                        if (message.text.isNotEmpty) {
                          addChat(DateTime.now(),message.text.trim(),5);
                          fs.collection('Messages').doc().set({
                            'message': message.text.trim(),
                            'time': DateTime.now(),
                            'email': email,
                          });

                          message.clear();
                        }
                      },
                      icon: Icon(Icons.send_sharp,color: Colors.deepOrange),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}