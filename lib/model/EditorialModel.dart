class EditorialModel {
  EditorialModel({
      this.table,});

  EditorialModel.fromJson(dynamic json) {
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
      this.gSlno, 
      this.gImage, 
      this.gCreateddate, 
      this.gFlag, 
      this.gNewstitle, 
      this.gNewsdetails, 
      this.gDate, 
      this.gApprovalstatus,});

  Table.fromJson(dynamic json) {
    gSlno = json['g_slno'];
    gImage = json['g_image'];
    gCreateddate = json['g_createddate'];
    gFlag = json['g_flag'];
    gNewstitle = json['g_newstitle'];
    gNewsdetails = json['g_newsdetails'];
    gDate = json['g_date'];
    gApprovalstatus = json['g_approvalstatus'];
  }
  int? gSlno;
  String? gImage;
  String? gCreateddate;
  bool? gFlag;
  String? gNewstitle;
  String? gNewsdetails;
  String? gDate;
  int? gApprovalstatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['g_slno'] = gSlno;
    map['g_image'] = gImage;
    map['g_createddate'] = gCreateddate;
    map['g_flag'] = gFlag;
    map['g_newstitle'] = gNewstitle;
    map['g_newsdetails'] = gNewsdetails;
    map['g_date'] = gDate;
    map['g_approvalstatus'] = gApprovalstatus;
    return map;
  }

}