import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/NewsModel.dart';
import '../utils/app_urls.dart';

class ApiFetcheSearchLists {
  List<NewsModel>? newsList = [];
  Future<List<NewsModel>?> apiFetchSearchList(String data) async {
    var ur = Uri.parse(AppUrls.getSearch + "?searchtext=$data");
    final response2 = await http.get(ur, headers: {
      "content-type": "application/json",
    });
    print(response2.statusCode);
    switch (response2.statusCode) {
      case 200:
        newsList!.add(NewsModel.fromJson(jsonDecode(response2.body)));
        return newsList;

      default:
        return newsList;
    }
  }
}
