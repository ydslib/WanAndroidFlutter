class BannerModel {
  String title;
  int id;
  String url;
  String imagePath;

  BannerModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        id = json['id'],
        url = json['url'],
        imagePath = json['imagePath'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'id': id,
        'url': url,
        'imagePath': imagePath,
      };

  @override
  String toString() {
    StringBuffer sb = StringBuffer('{');
    sb.write("\"title\":\"$title\"");
    sb.write(",\"id\":$id");
    sb.write(",\"url\":\"$url\"");
    sb.write(",\"imagePath\":\"$imagePath\"");
    sb.write('}');
    return sb.toString();
  }
}

class ArticleModel {
  String? apkLink;
  int? audit;
  String? author;
  bool? canEdit;
  int? chapterId;
  String? chapterName;
  bool? collect;
  int? courseId;
  String? desc;
  String? descMd;
  String? envelopePic;
  bool? fresh;
  String? host;
  int? id;
  String? link;
  String? niceDate;
  String? niceShareDate;
  String? origin;
  String? prefix;
  String? projectLink;
  int? publishTime;
  int? realSuperChapterId;
  int? selfVisible;
  int? shareDate;
  String? shareUser;
  int? superChapterId;
  String? superChapterName;
  List? tags;
  String? title;
  int? type;
  int? userId;
  int? visible;
  int? zan;

  ArticleModel.fromJson(Map<String,dynamic> json):
        apkLink = json['apkLink'],
        audit = json['audit'],
        author = json['author'],
        canEdit = json['canEdit'],
        chapterId = json['chapterId'],
        chapterName = json['chapterName'],
        collect = json['collect'],
        courseId = json['courseId'],
        desc = json['desc'],
        descMd = json['descMd'],
        envelopePic = json['envelopePic'],
        fresh = json['fresh'],
        host = json['host'],
        id = json['id'],
        link = json['link'],
        niceDate = json['niceDate'],
        niceShareDate = json['niceShareDate'],
        origin = json['origin'],
        prefix = json['prefix'],
        projectLink = json['projectLink'],
        publishTime = json['publishTime'],
        realSuperChapterId = json['realSuperChapterId'],
        selfVisible = json['selfVisible'],
        shareDate = json['shareDate'],
        shareUser = json['shareUser'],
        superChapterId = json['superChapterId'],
        superChapterName = json['superChapterName'],
        tags = json['tags'],
        title = json['title'],
        type = json['type'],
        userId = json['userId'],
        visible = json['visible'],
        zan = json['zan'];

}

class PageModel {
  int? curPage;
  int? offset;
  bool? over;
  int? pageCount;
  int? size;
  int? total;
  List datas;

  PageModel.fromJson(Map<String, dynamic> json)
      : curPage = json['curPage'],
        offset = json['offset'],
        over = json['over'],
        pageCount = json['pageCount'],
        size = json['size'],
        total = json['total'],
        datas = json['datas'];

  // Map<String, dynamic> toJson() => {
  //       'curPage': curPage,
  //       'offset': offset,
  //       'over': over,
  //       'pageCount': pageCount,
  //       'size': size,
  //       'total': total
  //     };

  @override
  String toString() {
    StringBuffer sb = StringBuffer('{');
    sb.write("\"curPage\":\"$curPage\"");
    sb.write(",\"offset\":$offset");
    sb.write(",\"over\":\"$over\"");
    sb.write(",\"pageCount\":\"$pageCount\"");
    sb.write(",\"size\":\"$size\"");
    sb.write(",\"total\":\"$total\"");
    sb.write('}');
    return sb.toString();
  }
}
