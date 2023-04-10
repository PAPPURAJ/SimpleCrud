import 'package:hive/hive.dart';

getData(String boxName,String key)async{
    var myBox = Hive.box(boxName);
    return myBox.get(key);
}

