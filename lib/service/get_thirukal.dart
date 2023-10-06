import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:murasoli_ios/model/ThirukuralModel.dart';
import 'dart:convert';
import '../utils/app_urls.dart';

class ApiGetThirukuralMaster {
  List<ThirukuralModel>? thirukalList = [];
  Future<List<ThirukuralModel>?> apiGetThirukuralMaster() async {
    try{
    var ur = Uri.parse(AppUrls.getThirukal);
    final response2 = await http.get(ur, headers: {
      "content-type": "application/json",
    });
    print(response2.statusCode);
    switch (response2.statusCode) {
      case 200:
        thirukalList!.add(ThirukuralModel.fromJson(jsonDecode(response2.body)));
        return thirukalList;

      default:
        return thirukalList;
    }
     } on SocketException catch (_) {
      print('not connected');
    }
  }
}
