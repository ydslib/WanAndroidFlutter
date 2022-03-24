import 'package:dio/dio.dart';
import 'package:sp_util/sp_util.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/route/page/main_page.dart';
import 'package:wanandroid_flutter/route/router.dart';
import 'package:wanandroid_flutter/route/util/net/dio_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo  Home Page'),
      routes: routeTable,
    );
  }

  @override
  void initState() {
    super.initState();
    initDio();
  }

  void initDio() {
    BaseOptions? options = DioUtil.getDefOptions();
    options.baseUrl = "https://www.wanandroid.com/";
    String? cookie = SpUtil.getString("app_token");
    if (ObjectUtil.isNotEmpty(cookie)) {
      Map<String, dynamic> _headers = {};
      _headers["cookie"] = cookie;
      options.headers = _headers;
    }
    HttpConfig config = HttpConfig(options: options);
    DioUtil().setConfig(config);
  }
}
