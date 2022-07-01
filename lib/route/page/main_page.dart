import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanandroid_flutter/route/page/project_page.dart';

import 'home_page.dart';
import 'knowledge_page.dart';
import 'navigation_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    //尺寸适配初始化
    initScreenUtil();


    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavBarItems,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        elevation: 10.w,
        selectedFontSize: 12.w,
        unselectedFontSize: 12.w,
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: pages[_currentIndex],
    );
  }

  final List<BottomNavigationBarItem> bottomNavBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      label: "首页",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.dashboard_customize_outlined),
      label: "知识体系",
    ),
    const BottomNavigationBarItem(icon: Icon(Icons.navigation_outlined), label: "导航"),
    const BottomNavigationBarItem(icon: SizedBox(width: 24,height: 24,child: Image(image: AssetImage("assets/images/mine.png"))),
        label: "我的",activeIcon: SizedBox(width: 24,height: 24,child: Image(image: AssetImage("assets/images/mine_selected.png")))),
  ];

  final pages = <Widget>[
    HomePage(),
    KnowledgePage(),
    NavigationPage(),
    ProjectPage()
  ];

  void initScreenUtil() {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: const Size(375, 812),
        context: context,
        minTextAdapt: true,
        orientation: Orientation.portrait);
  }
}