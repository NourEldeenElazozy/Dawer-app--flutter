import 'package:dawerf/AuthScreens/WelcomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingPageSceen extends StatefulWidget {
  const OnBoardingPageSceen({Key? key}):super(key:key);

  @override
  State<OnBoardingPageSceen> createState() => _OnBoardingSceenState();
}

class _OnBoardingSceenState extends State<OnBoardingPageSceen> {
  late PageController _pageController;
  int _pageIndex = 0;
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }
  
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children:[ Expanded
            (
              child: PageView.builder(
                itemCount: demo_data.length,
                controller: _pageController,
                onPageChanged: (index){
                  setState(() {
                  _pageIndex = index;
                  });
                } ,
                itemBuilder: (context,index) => OnBoardingContent(
                image: demo_data[index].image,
                title: demo_data[index].title,
                desc: demo_data[index].desc,
              ),),
            ),
            Row(
              children: [
                ...List.generate(
                  demo_data.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: DotIndicator(isActive: index == _pageIndex ,),
                  )),
                const Spacer(),
                SizedBox(
                 height: 60,
                  width :60,
                  child: ElevatedButton(
                    onPressed: (){
                      if(_pageIndex == 2){
                        Get.to(WelcomeScreen());

                      }
                      _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.ease);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder()
                    ),
                    child:Icon(Icons.arrow_forward,color: Colors.white,)
                  )
                ),
              ],
            )
            ],
          ),
        )
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    Key? key,  this.isActive = false,
  }) : super(key: key);
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(height: isActive? 12 : 4,
    width: 4,
    padding: EdgeInsets.all(20),
    duration:Duration(microseconds: 300) ,
    decoration: BoxDecoration(
      color: isActive? Colors.orange : Colors.orange.withOpacity(0.4),
      borderRadius: BorderRadius.all(Radius.circular(12))
    ),);
  }
}
class OnBoard{
  final String image, title , desc;
  OnBoard({required this.image, required this.title, required this.desc});
}
final List<OnBoard> demo_data = [
OnBoard(image: "assets/images/illust1.png", 
title: "لنعمل معاً من أجل العيش في بيئة نظيفة.",
 desc: ""),

 OnBoard(image: "assets/images/illust2.png", 
title: "ساهم في الإبلاغ عن المخلفات في الشوارع.",
 desc: ""),

 OnBoard(image: "assets/images/illust3.png", 
title: "أعثر على أقرب حاوية قمامة لك لتساهم في الحفاظ على نظافة بلادك.",
 desc: "")


];

class OnBoardingContent extends StatelessWidget {
  const OnBoardingContent({
    Key? key, required this.image, required this.title, required this.desc,
  }) : super(key: key);
  final String image, title , desc;

  @override
  Widget build(BuildContext context) {
    double h = Get.height;
    double w = Get.width;
    return Column(children: [
      Image.asset(image
      , height: h/2, width: w,),
      Text(title, 
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight:FontWeight.w500 ),),
           const Spacer(),
    ]);
  }
}