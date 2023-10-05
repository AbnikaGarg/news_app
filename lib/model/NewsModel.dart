class NewsModel {
  NewsModel({
      this.table,});

  NewsModel.fromJson(dynamic json) {
    if (json['Table'] != null) {
      table = [];
      json['Table'].forEach((v) {
        table?.add(NewsTable.fromJson(v));
      });
    }
  }
  List<NewsTable>? table;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (table != null) {
      map['Table'] = table?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class NewsTable {
  NewsTable({
      this.gSlno, 
      this.gNewstitle, 
      this.gDetails, 
      this.gImage, 
      this.gLocation, 
      this.gDistrict, 
      this.gState, 
      this.gCountry, 
      this.gDisplayside, 
      this.gPriority, 
      this.gCreateddate, 
      this.gFlag, 
      this.gNewstitletamil, 
      this.gNewsdetailstamil, 
      this.gCountryname, 
      this.gStatename, 
      this.gDistrictname, 
      this.gIncidentdate, 
      this.gNewsshort, 
      this.gNewsshorttamil, 
      this.gEditionid, 
      this.gPublishingdate, 
      this.gEditionname,});

  NewsTable.fromJson(dynamic json) {
    gSlno = json['g_slno'];
    gNewstitle = json['g_newstitle'];
    gDetails = json['g_details'];
    gImage = json['g_image'];
    gLocation = json['g_location'];
    gDistrict = json['g_district'];
    gState = json['g_state'];
    gCountry = json['g_country'];
    gDisplayside = json['g_displayside'];
    gPriority = json['g_priority'];
    gCreateddate = json['g_createddate'];
    gFlag = json['g_flag'];
    gNewstitletamil = json['g_newstitletamil'];
    gNewsdetailstamil = json['g_newsdetailstamil'];
    gCountryname = json['g_countryname'];
    gStatename = json['g_statename'];
    gDistrictname = json['g_districtname'];
    gIncidentdate = json['g_incidentdate'];
    gNewsshort = json['g_newsshort'];
    gNewsshorttamil = json['g_newsshorttamil'];
    gEditionid = json['g_editionid'];
    gPublishingdate = json['g_publishingdate'];
    gEditionname = json['g_editionname'];
  }
  int? gSlno;
  String? gNewstitle;
  String? gDetails;
  String? gImage;
  String? gLocation;
  int? gDistrict;
  int? gState;
  int? gCountry;
  int? gDisplayside;
  int? gPriority;
  String? gCreateddate;
  bool? gFlag;
  String? gNewstitletamil;
  String? gNewsdetailstamil;
  String? gCountryname;
  String? gStatename;
  String? gDistrictname;
  String? gIncidentdate;
  String? gNewsshort;
  String? gNewsshorttamil;
  int? gEditionid;
  String? gPublishingdate;
  String? gEditionname;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['g_slno'] = gSlno;
    map['g_newstitle'] = gNewstitle;
    map['g_details'] = gDetails;
    map['g_image'] = gImage;
    map['g_location'] = gLocation;
    map['g_district'] = gDistrict;
    map['g_state'] = gState;
    map['g_country'] = gCountry;
    map['g_displayside'] = gDisplayside;
    map['g_priority'] = gPriority;
    map['g_createddate'] = gCreateddate;
    map['g_flag'] = gFlag;
    map['g_newstitletamil'] = gNewstitletamil;
    map['g_newsdetailstamil'] = gNewsdetailstamil;
    map['g_countryname'] = gCountryname;
    map['g_statename'] = gStatename;
    map['g_districtname'] = gDistrictname;
    map['g_incidentdate'] = gIncidentdate;
    map['g_newsshort'] = gNewsshort;
    map['g_newsshorttamil'] = gNewsshorttamil;
    map['g_editionid'] = gEditionid;
    map['g_publishingdate'] = gPublishingdate;
    map['g_editionname'] = gEditionname;
    return map;
  }

}