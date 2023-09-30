import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/NewsModel.dart';
import '../utils/app_urls.dart';

class ApiFetchFlashNewsLists {
  List flashNews = [];
  Future<List> apiFetchFlashNewsLists() async {
    var ur = Uri.parse("https://api.murasoli.in/api/FlashNewsEntry/GetFlashNewsEntrybyid?incidentdate=2023-09-02");
    final response2 = await http.get(ur, headers: {
      "content-type": "application/json",
    });
    print(response2.statusCode);
    switch (response2.statusCode) {
      case 200:
      final data=jsonDecode(response2.body);
        flashNews=data["Table"];
        return flashNews;

      default:
        return flashNews;
    }
  }
}
