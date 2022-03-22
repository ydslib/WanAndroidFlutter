import 'dart:collection';

class Config{
  static final Config _instance = Config._init();

  String? buildType;
  String? host = "https://www.wanandroid.com/";
  String? buyEv;
  bool? isDebug;
  String? webHost;
  String? token;
  Map<String,String>headers = HashMap();

  Config._init(){

  }

  factory Config()=>_instance;

  Config getInstance() => _instance;
}