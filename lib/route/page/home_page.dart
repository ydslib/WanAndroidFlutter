
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState() {
    return _HomePage();
  }

}

class _HomePage extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("首页"),
      ),
      body: Column(
        children: [
          _getBanner()
        ],
      )
    );
  }
  
  Widget _getBanner(){
    return Banner(message: "testtest", location: BannerLocation.topStart);
  }
  
}