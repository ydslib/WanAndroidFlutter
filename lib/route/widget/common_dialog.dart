import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonDialog extends Dialog {
  static const String MODULE_ONE = "module_one";
  static const String MODULE_TWO = "module_two";
  static const String MODULE_THREE = "module_three";
  static const String MODULE_FOUR = "module_four";

  String? content;
  GestureTapCallback? confirm;
  GestureTapCancelCallback? cancel;
  String type = MODULE_ONE;
  String? subContent;
  String? imageUrl;

  CommonDialog({
    this.content,
    this.confirm,
    this.cancel,
    this.subContent,
    this.imageUrl,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Container(
          width: 0.8.sw,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8.w))),
          child: _getModuleByType(type, context),
        ),
      ),
      type: MaterialType.transparency,
    );
  }

  Widget _getModuleByType(String type, BuildContext context) {
    switch (type) {
      case MODULE_ONE:
        return _dialogModuleOne(context);
      case MODULE_TWO:
        return _dialogModuleTwo(context);
      case MODULE_THREE:
        return _dialogModuleThree(context);
      case MODULE_FOUR:
        return _dialogModuleFour(context);
    }
    return _dialogModuleOne(context);
  }

  ///   -------------------------------
  ///  ｜                      关闭按钮 ｜
  ///  ｜                              ｜
  ///  ｜     文本：编程猫需要权限         ｜
  ///  ｜                              ｜
  ///  ｜        按钮：去打开            ｜
  ///   --------------------------------
  Widget _dialogModuleOne(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            iconSize: 24.w,
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
              this.cancel?.call();
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 24.w, right: 24.w),
          child: Text(
            "$content",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.w),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(32.w),
          child: Container(
              height: 40.h,
              width: 160.w,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  this.confirm?.call();
                },
                child: Text(
                  "去打开",
                  style: TextStyle(color: Colors.white, fontSize: 14.w),
                ),
              ),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 218, 81, 63),
                  borderRadius: BorderRadius.all(Radius.circular(28.w)))),
        )
      ],
    );
  }

  ///   -------------------------------
  ///  ｜      主文本：编程猫需要权限      ｜
  ///  ｜                              ｜
  ///  ｜       副文本:xxxxxx           ｜
  ///  ｜                              ｜
  ///  ｜     不同意按钮     同意按钮     ｜
  ///   --------------------------------
  Widget _dialogModuleTwo(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 32.w, left: 24.w, right: 24.w),
          child: Text(
            "$content",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.w),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 24.w, left: 24.w, right: 24.w),
          child: Text(
            "$subContent",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14.w, color: const Color.fromARGB(255, 128, 128, 128)),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(24.w),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                  height: 40.h,
                  width: 112.w,
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      this.cancel?.call();
                    },
                    child: Text(
                      "不同意",
                      style: TextStyle(
                          color: const Color.fromARGB(255, 178, 178, 178), fontSize: 14.w),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 242, 242, 242),
                      borderRadius: BorderRadius.all(Radius.circular(28.w)))),
              Container(
                  height: 40.h,
                  width: 112.w,
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      this.confirm?.call();
                    },
                    child: Text(
                      "同意",
                      style: TextStyle(color: Colors.white, fontSize: 14.w),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 218, 81, 23),
                      borderRadius: BorderRadius.all(Radius.circular(28.w))))
            ],
          ),
        )
      ],
    );
  }

  ///   -------------------------------
  ///  ｜                              ｜
  ///  ｜     主文本：编程猫需要权限
  ///  ｜       副文本：xxx             ｜
  ///  ｜                              ｜
  ///  ｜        按钮：去打开            ｜
  ///  ｜        按钮：稍后在看          ｜
  ///   --------------------------------
  Widget _dialogModuleThree(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 24.w, top: 32.w, right: 24.w),
          child: Text(
            "$content",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.w,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 24.w, left: 24.w, right: 24.w),
          child: Text(
            "$subContent",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14.w, color: Color.fromARGB(255, 128, 128, 128)),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 24.w, left: 24.w, right: 24.w),
          child: Container(
              height: 40.h,
              width: 160.w,
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  this.confirm?.call();
                },
                child: Text(
                  "同意",
                  style: TextStyle(color: Colors.white, fontSize: 14.w),
                ),
              ),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 218, 81, 63),
                  borderRadius: BorderRadius.all(Radius.circular(28.w)))),
        ),
        Padding(
            padding: EdgeInsets.only(
                top: 8.w, left: 24.w, right: 24.w, bottom: 16.w),
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
                this.cancel?.call();
              },
              child: Text(
                "稍后再看",
                style: TextStyle(
                    fontSize: 14.w,
                    color: const Color.fromARGB(255, 235,69,52),
                    decoration: TextDecoration.underline),
              ),
            ))
      ],
    );
  }

  ///   -------------------------------
  ///  ｜                      关闭按钮 ｜
  ///  ｜                              ｜
  ///  ｜     主文本：关注公众号/添加微信   ｜
  ///  ｜       副文本：xxx             ｜
  ///  ｜                              ｜
  ///  ｜       图片：二维码
  ///  ｜
  ///  ｜
  ///  ｜     文本：步骤提示文本          ｜
  ///   --------------------------------
  Widget _dialogModuleFour(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
            bottom: 0.w,
            left: 0.w,
            child: Image.asset(
              "assets/dialog_qrcode_bg.webp",
              width: 178.w,
              height: 178.w,
            )),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              //关闭按钮
              alignment: Alignment.topRight,
              child: IconButton(
                iconSize: 24.w,
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                  this.cancel?.call();
                },
              ),
            ),
            Padding(
              //主标题
              padding: EdgeInsets.only(left: 24.w, right: 24.w),
              child: Text(
                "$content",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.w, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              //副文本
              padding: EdgeInsets.only(left: 24.w, right: 24.w),
              child: Text(
                "$subContent",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.w, color: const Color.fromARGB(255, 128, 128, 128)),
              ),
            ),
            Padding(
              //二维码区
              padding: EdgeInsets.only(top: 24.w, left: 24.w, right: 24.w),
              child: Container(
                height: 200.w,
                width: 200.w,
                alignment: Alignment.center,
                child: Image.network(
                  "$imageUrl",
                  width: 168.w,
                  height: 168.w,
                  fit: BoxFit.cover,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(24.w)),
                    boxShadow: [
                      BoxShadow(
                          color: const Color.fromARGB(128, 215, 218, 224), blurRadius: 15.w)
                    ]),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 24.w, top: 16.w, right: 24.w, bottom: 24.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "第一步：截图二维码，保存到相册",
                    style: TextStyle(
                      color: const Color.fromARGB(255, 235,69,52),
                      fontSize: 14.w,
                    ),
                  ),
                  Text(
                    "第二步：打开微信“扫一扫”",
                    style: TextStyle(
                      color: const Color.fromARGB(255, 235,69,52),
                      fontSize: 14.w,
                    ),
                  )
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
