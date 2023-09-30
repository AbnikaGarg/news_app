class DistrictMasterModel {
  DistrictMasterModel({
      this.table,});

  DistrictMasterModel.fromJson(dynamic json) {
    if (json['Table'] != null) {
      table = [];
      json['Table'].forEach((v) {
        table?.add(Table.fromJson(v));
      });
    }
  }
  List<Table>? table;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (table != null) {
      map['Table'] = table?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Table {
  Table({
      this.gDistrictid, 
      this.gDistrictname, 
      this.gDistrictnametamil, 
      this.gCreateddate, 
      this.gFlag,});

  Table.fromJson(dynamic json) {
    gDistrictid = json['g_districtid'];
    gDistrictname = json['g_districtname'];
    gDistrictnametamil = json['g_districtnametamil'];
    gCreateddate = json['g_createddate'];
    gFlag = json['g_flag'];
  }
  int? gDistrictid;
  String? gDistrictname;
  String? gDistrictnametamil;
  String? gCreateddate;
  bool? gFlag;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['g_districtid'] = gDistrictid;
    map['g_districtname'] = gDistrictname;
    map['g_districtnametamil'] = gDistrictnametamil;
    map['g_createddate'] = gCreateddate;
    map['g_flag'] = gFlag;
    return map;
  }

}