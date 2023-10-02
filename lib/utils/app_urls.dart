class AppUrls {
  static const String baseUrl = 'https://api.murasoli.in';

  static const String getEditions =
      baseUrl + '/api/MainNewsEntryEdition/GetMainNewsEntrybyeditionId';
  static const String getEditorial =
      baseUrl + '/api/EditorialByDate/GetEditorialByDate';
  static const String getThirukal =
      baseUrl + '/api/ThirukuralMaster/GetThirukuralMaster';
        static const String getNews =
      baseUrl + '/api/MainNewsEntryWorld/GetMainNewsEntrybyworldId';
          static const String getDistrict =
      baseUrl + '/api/DistrictMaster/GetDistrictMaster';
          static const String getSearch =
      baseUrl + '/api/SearchData/GetSearchDataByName';
         static const String getFlashNews =
      baseUrl + '/api/FlashNewsEntry/GetFlashNewsEntrybyid';
}
