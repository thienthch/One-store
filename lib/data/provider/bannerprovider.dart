import '../model/banner.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class ReadData {
  Future<List<Banner>> loadData() async {
    var data = await rootBundle.loadString("assets/files/bannerlist.json");
    var dataJson = jsonDecode(data);

    return (dataJson['data'] as List).map((e) => Banner.fromJson(e)).toList();
  }
}
