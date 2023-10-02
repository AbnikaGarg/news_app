import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/NewsModel.dart';
import '../utils/app_urls.dart';

class ApiFetcheNewsLists {
  List<NewsModel>? newsList = [];
  Future<List<NewsModel>?> apiFetcheNewsLists(int srno) async {
    var ur = Uri.parse(AppUrls.getNews + "?slno=$srno&incidentdate=2023-09-29");
   try {
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
   } catch (e) {
     print(e); 
   }
  }
}
