
import 'package:flutter/cupertino.dart';

class Global{

  static Future init(VoidCallback callback) async{
    WidgetsFlutterBinding.ensureInitialized();

  }
}