import 'package:wanandroid_flutter/route/api/apis.dart';
import 'package:wanandroid_flutter/route/model/model.dart';
import 'package:wanandroid_flutter/route/util/net/dio_util.dart';

import '../base/base_resp.dart';

class WanRepository {
  Future<List<BannerModel>?> getBanner() async {
    BaseResp<List> baseResp = await DioUtil().request<List>(
        Method.get, MainApi.getPath(path: MainApi.BANNER));
    List<BannerModel>? bannerList = [];
    if (baseResp.code != 0) {
      return Future.error(baseResp.msg ?? "");
    }
    if (baseResp.data != null) {
      bannerList = baseResp.data!.map((e) {
        return BannerModel.fromJson(e);
      }).toList();
    }

    return bannerList;
  }

  Future<List<ArticleModel>?> getArticleList({int? page, data}) async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil().request<
        Map<String, dynamic>>(Method.get, MainApi.getPath(path: MainApi.ARTICLE_LIST,page: page),data: data);
    
    List<ArticleModel>? list;
    if(baseResp.code!=0){
      return Future.error(baseResp.msg ?? "");
    }
    
    if(baseResp.data!=null){
      PageModel pageModel = PageModel.fromJson(baseResp.data!);
      list = pageModel.datas.map((e){
        return ArticleModel.fromJson(e);
      }).toList();
    }
    return list;
  }
}
