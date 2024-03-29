
import 'package:dawerf/Utiils/colors.dart';
import 'package:dawerf/Utiils/common_widgets.dart';
import 'package:flutter/material.dart';
class NewsPage extends StatelessWidget {
  const NewsPage(this.title, this.description,this.image, this.date);
   final String title;
   final String description;
  final String image;
  final String date;



  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
        ),
        body: Container(
          child:   Card(
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                
                  Container(
                    width: 400,
                    height: 255,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                          image: NetworkImage(
                             image.toString()),
                          fit: BoxFit.cover),
                    ),
                  ),
  ListTile(

                    title:  mediumText(title,ColorResources.black4A4,20),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      description,
                      style: Theme.of(context).textTheme.titleMedium
                    ),
                  ),



                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
