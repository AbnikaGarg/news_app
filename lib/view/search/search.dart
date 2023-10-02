import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:murasoli_ios/service/get_searchData.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../components/news_card.dart';
import '../../model/NewsModel.dart';
import '../news/news_details.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final searchText = TextEditingController();
  bool isSearch = false;
  @override
  void initState() {
    super.initState();
  }

  bool startSearch = false;
  List<NewsTable>? newsList;
  void getSearchData(text) async {
    // ignore: unnecessary_null_comparison
    if (searchText.text == null && searchText.text == "") return;
    startSearch = true;
    newsList = null;
    setState(() {});
    final service = ApiFetcheSearchLists();
    service.apiFetchSearchList(text).then((value) {
      if (value != null) {
        newsList = value.first.table;
        if (mounted) setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(66.h),
        child: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          elevation: 1,
          titleSpacing: 0,
          title: Container(
            margin: EdgeInsets.only(right: 16.w, top: 5.h),
            height: 40.h,
            child: SearchTextbox(
                searchText: searchText,
                ontap: () {
                  getSearchData(searchText.text);
                },
                hintText: "Search..",
                onChanged: (val) {
                  if(val!=""){
                    setState(() {
                      isSearch=true;
                    });
                  }
                  else{
                      setState(() {
                      isSearch=false;
                    });
                  }
                },
                iconSuf: Icon(
                  Icons.search,
                  size: 22.h,
                  color:
                      isSearch ? Theme.of(context).primaryColor : Colors.grey,
                )),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: startSearch
                  ? newsList != null
                      ? newsList!.isNotEmpty
                          ? ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: newsList!.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.h, horizontal: 14.w),
                                    child: GestureDetector(
                                      onTap: () {
                                      Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => NewsDetails(
                                                  newsData: newsList![index],
                                                )));
                                      },
                                      child: NewsCard(
                                        newsTitle: newsList![index]
                                            .gNewstitletamil
                                            .toString(),
                                              onTap: () {
                                      Share.share(
                                          'www.murasoli.in/newscontent?storyid=${newsList![index].gSlno}');
                                    },
                                        image:
                                            "${newsList![index].gImage.toString()}",
                                        date: newsList![index]
                                            .gCreateddate
                                            .toString(),
                                        newsDis: newsList![index]
                                            .gNewsshorttamil
                                            .toString(),
                                      ),
                                    ));
                              },
                            )
                          : Center(
                              child: Container(
                                child: const Text("No Search found"),
                              ),
                            )
                      : Center(
                          child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ))
                  : Container()),
        ],
      ),
    );
  }
}

class SearchTextbox extends StatelessWidget {
  final String hintText;

  var iconSuf;
  var ontap;
  var iconPref;
 Function(String) onChanged;
  TextEditingController searchText;
  SearchTextbox(
      {Key? key,
      required this.hintText,
      required this.searchText,
      this.iconSuf,
     required this.onChanged,
      this.iconPref,
      this.ontap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: searchText,
      textInputAction: TextInputAction.search,
      onEditingComplete: ontap,
      onChanged: (val){
        onChanged(val);
      },
      // autofocus: true,
      cursorColor: Theme.of(context).primaryColor,
      textAlignVertical: TextAlignVertical.center,
      style: TextStyle(
        fontSize: 16.sp,
      ),
      decoration: InputDecoration(
        prefixIcon: iconPref,
        contentPadding: EdgeInsets.all(8),
        isDense: true,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).hoverColor,
            width: 0,
          ),
          borderRadius: BorderRadius.circular(5.r),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).hoverColor,
            width: 0,
          ),
          borderRadius: BorderRadius.circular(5.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: BorderSide(
            color: Theme.of(context).hoverColor,
            width: 0,
          ),
        ),
        hintStyle:
            Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 16.sp),
        suffixIcon: InkWell(
          onTap: ontap,
          child: iconSuf,
        ),
        prefixIconColor: Theme.of(context).textTheme.displaySmall!.color,
        suffixIconColor: Theme.of(context).textTheme.displaySmall!.color,
        filled: true,
        fillColor: Theme.of(context).hoverColor,
        hintText: hintText,
      ),
    );
  }
}
