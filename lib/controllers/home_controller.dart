import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:movies_demo/services/db_helper.dart';

import '../models/home_model.dart';
import '../providers/get_home_data.dart';
import '../services/database_helper.dart';

class HomeController extends GetxController {
  var isDataLoad = false.obs;
  var sortList = [].obs;
  dynamic homeData;

  var title = ''.obs;
  var posterPath = ''.obs;
  var id = 0.obs;
  var overview = ''.obs;
  var releaseDate = ''.obs;

  dynamic dbRecord;
  var fav = false.obs;
  var currentId = 0.obs;
  var recordId = 0.obs;
  final dbHelper = DatabaseHelper();

  var favList = [].obs;
  @override
  void onInit() async {
    // language Prefernce
    isDataLoad.value = true;
    homeData = GetHomApiData().getHomeData();
    isDataLoad.value = false;
    await dbHelper.init();
    // getNotificationCount();
    super.onInit();
  }

  sortlist(var data) {
    var list = [];
    var newList = [];
    var mapdata = {};
    var newData = [];
    for (var item in data) {
      mapdata = {
        'title': item.title,
        'posterPath': item.posterPath,
        'id': item.id,
        'overview': item.overview,
        'releaseDate': item.releaseDate,
      };
      newList.add(mapdata);
    }
    for (var item in data) {
      list.add(item.title);
    }

    list.sort((a, b) {
      //sorting in ascending order
      return a.compareTo(b);
    });

    for (var i = 0; i < list.length; i++) {
      newData.add(
          newList.where((element) => element['title'] == list[i]).toList());
    }
    // print(newData);
    return newData;
  }

  addRecord(recordId, columnTitle, columnposterPath) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnRecordId: recordId,
      DatabaseHelper.columnTitle: columnTitle,
      DatabaseHelper.columnposterPath: columnposterPath,
    };
    final id = await dbHelper.insert(row);
    currentId.value = id;
    fav.value = true;
    debugPrint('inserted row id: $id');
  }

  readRecord() async {
    // // dbRecord = await DatabaseHelper.instance.queryDatabase();
    // print(dbRecord);
    // return dbRecord;
    favList.clear();
    final allRows = await dbHelper.queryAllRows();
    // debugPrint('query all rows:');
    for (final row in allRows) {
      favList.add(row);
      // debugPrint(row.toString());
    }
    // print('list');
    // print(favList);
    // print('id');
    // print(favList[0]['_id']);

    return null;
    // print(favList);
  }

  deleteRecord(id) async {
    // final id = await dbHelper.queryRowCount();
    final rowsDeleted = await dbHelper.delete(id);
    fav.value = false;
    debugPrint('deleted $rowsDeleted row(s): row $id');
  }

  getCurrentRowData(recordId) async {
    final data = await dbHelper.getRow(recordId);
    if (data.isEmpty) {
      fav.value = false;
    } else {
      currentId.value = data[0]['_id'];
      fav.value = true;
    }
  }
  // checkfavIdExist(id) async {
  //   var chckFav = await DatabaseHelper.instance.getqueryDatabase(id);
  //   print(chckFav);
  // }
}
