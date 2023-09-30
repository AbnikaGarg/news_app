class ThirukuralModel {
  ThirukuralModel({
    this.table,
  });

  ThirukuralModel.fromJson(dynamic json) {
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
    this.gId,
    this.gDate,
    this.gKural,
    this.gKuralno,
    this.gAdhigaram,
    this.gPirivu,
    this.gKilai,
    this.gMeaning,
    this.gKural1,
    this.gCreateddate,
    this.gFlag,
  });

  Table.fromJson(dynamic json) {
    gId = json['g_id'];
    gDate = json['g_date'];
    gKural = json['g_kural'];
    gKuralno = json['g_kuralno'];
    gAdhigaram = json['g_adhigaram'];
    gPirivu = json['g_pirivu'];
    gKilai = json['g_kilai'];
    gMeaning = json['g_meaning'];
    gKural1 = json['g_kural1'];
    gCreateddate = json['g_createddate'];
    gFlag = json['g_flag'];
  }
  int? gId;
  String? gDate;
  String? gKural;
  int? gKuralno;
  String? gAdhigaram;
  String? gPirivu;
  String? gKilai;
  String? gMeaning;
  String? gKural1;
  String? gCreateddate;
  bool? gFlag;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['g_id'] = gId;
    map['g_date'] = gDate;
    map['g_kural'] = gKural;
    map['g_kuralno'] = gKuralno;
    map['g_adhigaram'] = gAdhigaram;
    map['g_pirivu'] = gPirivu;
    map['g_kilai'] = gKilai;
    map['g_meaning'] = gMeaning;
    map['g_kural1'] = gKural1;
    map['g_createddate'] = gCreateddate;
    map['g_flag'] = gFlag;
    return map;
  }
}
