import '../base/base_resp.dart';

class MainApi{

  /// 首页banner http://www.wanandroid.com/banner/json
  static const String BANNER = "banner";

  /// 首页文章列表 http://www.wanandroid.com/article/list/0/json
  /// 知识体系下的文章 http://www.wanandroid.com/article/list/0/json?cid=60
  static const String ARTICLE_LIST = "article/list";

  static String getPath({String path: '', int? page, String? resType: 'json'}) {
    StringBuffer sb = StringBuffer(path);
    if (page != null) {
      sb.write('/$page');
    }
    if (resType != null && resType.isNotEmpty) {
      sb.write('/$resType');
    }
    return sb.toString();
  }
}