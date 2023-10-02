import 'package:http/http.dart' as http;
import 'package:murasoli_ios/model/EditorialModel.dart';
import 'dart:convert';
import '../utils/app_urls.dart';

class ApiFetchEditorial {
  List<EditorialModel>? editorialList = [];
  Future<List<EditorialModel>?> apiFetchEditorial(String date) async {
    var ur = Uri.parse(AppUrls.getEditorial+"?date=$date");
    final response2 = await http.get(ur, headers: {
      "content-type": "application/json",
    });
    print(response2.statusCode);
    switch (response2.statusCode) {
      case 200:
        editorialList!.add(EditorialModel.fromJson(jsonDecode(response2.body)));
        return editorialList;

      default:
        return editorialList;
    }
  }
}
