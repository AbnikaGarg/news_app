import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import '../model/NewsModel.dart';
import '../utils/app_urls.dart';

class ApiFetchHomePageLists {
  List<NewsModel>? editionList = [];
  Future<List<NewsModel>?> apiFetchHomePageLists() async {
    var ur = Uri.parse(AppUrls.getEditions +
        "?slno=1&incidentdate=${DateFormat("yyyy-MM-dd").format(DateTime.now()).toString()}");
    final response2 = await http.get(ur, headers: {
      "content-type": "application/json",
    });
    print(response2.statusCode);
    switch (response2.statusCode) {
      case 200:
        editionList!.add(NewsModel.fromJson(jsonDecode(response2.body)));
        return editionList;

      default:
        return editionList;
    }
  }
}
