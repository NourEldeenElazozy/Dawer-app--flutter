import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class OnDemandCarouselDemo extends StatefulWidget {
  @override
  State<OnDemandCarouselDemo> createState() => _OnDemandCarouselDemoState();
}
final CollectionReference containers =
FirebaseFirestore.instance.collection('containers');

final CollectionReference ads =
FirebaseFirestore.instance.collection('ads');
class _OnDemandCarouselDemoState extends State<OnDemandCarouselDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('On-demand carousel demo')),
      body: Column(
        children: [
          StreamBuilder(
          stream: ads.snapshots(),

          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              return Container(
                  child: CarouselSlider.builder(
                    itemCount: 100,
                    options: CarouselOptions(
                      aspectRatio: 2.0,
                      enlargeCenterPage: true,
                      autoPlay: true,
                    ),
                    itemBuilder: (ctx, index, realIdx) {
                      return Container(
                        child: Text(index.toString()),
                      );
                    },
                  ));
            }
          ),
        ],
      ),
    );
  }
}