import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanandroid_flutter/route/model/model.dart';

import '../../../res/colors.dart';
import '../../widget/favorite_widget.dart';

class ArticleItem extends StatefulWidget {

  ArticleModel? item;

  ArticleItem({Key? key, required this.item}) : super(key: key);

  @override
  State<ArticleItem> createState() {
    return _ArticleItem();
  }
}

class _ArticleItem extends State<ArticleItem> {
  @override
  Widget build(BuildContext context) {
    ArticleModel? item = widget.item;
    return Container(
      padding: EdgeInsets.only(left: 16.w, right: 16.w),
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                  child: Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: Container(
                        width: 20.w,
                        height: 20.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4.w)),
                            border: Border.all(
                                width: 1, color: WColors.color_ffEB4534)),
                        child: Text(
                          "新",
                          style: TextStyle(
                            color: WColors.color_ffEB4534,
                            fontSize: 12.w,
                          ),
                        ),
                      )),
                  visible: item?.fresh == true,
                ),
                Text(
                  "${item?.shareUser?.isNotEmpty == true ? item?.shareUser : item?.author}",
                  style: const TextStyle(color: Colors.black54),
                ),
                const Expanded(child: Text("")),
                Text(
                  "${item?.niceShareDate}",
                  style: TextStyle(color: Colors.black54, fontSize: 12.w),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.w, bottom: 12.w),
            child: Text(
              "${item?.title}",
              style: TextStyle(fontSize: 16.w, color: Colors.black),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.w, bottom: 8.w),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "${item?.superChapterName}/${item?.chapterName}",
                    style: TextStyle(color: Colors.black54, fontSize: 12.w),
                  ),
                ),
                Expanded(child: Text('')),
                FavoriteWidget(
                  onChanged: (v) {
                    print("FavoriteWidget:$v");
                  },
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            color: WColors.color_fff3f6f9,
          )
        ],
      ),
    );
  }
}
