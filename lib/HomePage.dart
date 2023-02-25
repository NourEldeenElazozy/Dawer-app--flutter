import 'package:dawerf/HomeScreen/dawer_home.dart';
import 'package:dawerf/Notification/notification_screen.dart';
import 'package:dawerf/Profile/Profile.dart';
import 'package:dawerf/Utiils/User.dart';

import 'package:dawerf/Utiils/colors.dart';
import 'package:dawerf/Utiils/common_widgets.dart';
import 'package:dawerf/menu.dart';
import 'package:dawerf/report.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _tab1navigatorKey = GlobalKey<NavigatorState>();

  final _tab2navigatorKey = GlobalKey<NavigatorState>();

  final _tab3navigatorKey = GlobalKey<NavigatorState>();

  final _tab4navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    items='';

    return Directionality(


      textDirection: TextDirection.rtl,
      child: Scaffold(
       appBar: AppBar(backgroundColor: ColorResources.custom,),
        body: Container(
          child: PersistentBottomBarScaffold(
            items: [
              PersistentTabItem(
                tab: DawerHome(),
                icon: Icons.home,
                title: 'الرئيسية',
                navigatorkey: _tab1navigatorKey,
              ),
              PersistentTabItem(
                tab: ReportScreen(),
                icon: Icons.camera_alt,
                title: 'بلاغ',
                navigatorkey: _tab2navigatorKey,
              ),
              PersistentTabItem(
                tab: NotificationScreen(),
                icon: Icons.notifications,
                title: 'الإشعارات',
                navigatorkey: _tab3navigatorKey,
              ),


            ],
          ),

        ),
      ),
    );
  }
}

class TabPage1 extends StatelessWidget {
  const TabPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('TabPage1 build');
    return Scaffold(

      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Tab 1'),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Page1('Tab1')));
                },
                child: Text('Go to page1'))
          ],
        ),
      ),
    );
  }
}

class TabPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('TabPage2 build');
    return Scaffold(
      appBar: AppBar(title: Text('Tab 2')),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Tab 2'),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Page2('tab2')));
                },
                child: Text('Go to page2'))
          ],
        ),
      ),
    );
  }
}

class TabPage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('TabPage3 build');
    return Scaffold(
      appBar: AppBar(title: Text('Tab 3')),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Tab 3'),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Page2('tab3')));
                },
                child: Text('Go to page2'))
          ],
        ),
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  final String inTab;

  const Page1(this.inTab);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Page 1')),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('in $inTab Page 1'),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Page2(inTab)));
                },
                child: Text('Go to page2'))
          ],
        ),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  final String inTab;

  const Page2(this.inTab);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Page 2')),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('in $inTab Page 2'),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Page3(inTab)));
                },
                child: Text('Go to page3'))
          ],
        ),
      ),
    );
  }
}

class Page3 extends StatelessWidget {
  final String inTab;

  const Page3(this.inTab);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Page 3')),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('in $inTab Page 3'),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Go back'))
          ],
        ),
      ),
    );
  }
}