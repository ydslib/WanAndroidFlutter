import '../base/base_resp.dart';

class MainApi{

  /// 首页banner http://www.wanandroid.com/banner/json
  static const String BANNER = "banner";

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