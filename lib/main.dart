import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/route/page/home_page.dart';
import 'package:wanandroid_flutter/route/page/knowledge_page.dart';
import 'package:wanandroid_flutter/route/page/navigation_page.dart';
import 'package:wanandroid_flutter/route/page/project_page.dart';
import 'package:wanandroid_flutter/route/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      routes: routeTable,
    );
  }
}

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
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavBarItems,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        elevation: 10,
        selectedFontSize: 12,
        unselectedFontSize: 12,
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
    const BottomNavigationBarItem(icon: Icon(Icons.folder_outlined), label: "项目"),
  ];

  final pages = <Widget>[
    HomePage(),
    KnowledgePage(),
    NavigationPage(),
    ProjectPage()
  ];
}
