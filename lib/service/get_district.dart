import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/DistrictMasterModel.dart';
import '../utils/app_urls.dart';

class ApiFetchDistrictLists {
  List<DistrictMasterModel>? districtList = [];
  Future<List<DistrictMasterModel>?> apiFetchDistrictLists() async {
    var ur = Uri.parse(AppUrls.getDistrict);
    try {
      final response2 = await http.get(ur, headers: {
        "content-type": "application/json",
      });
      print(response2.statusCode);
      switch (response2.statusCode) {
        case 200:
          districtList!
              .add(DistrictMasterModel.fromJson(jsonDecode(response2.body)));
          return districtList;
        default:
          return districtList;
      }
    } catch (e) {
      print(e);
    }
  }
}
