import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:murasoli_ios/service/get_district.dart';
import 'package:murasoli_ios/service/get_news.dart';
import 'package:murasoli_ios/view/epaper/epaper.dart';

import 'package:murasoli_ios/view/news/news_details.dart';
import 'package:share_plus/share_plus.dart';

import '../../components/news_card.dart';
import '../../model/DistrictMasterModel.dart';
import '../../model/NewsModel.dart';
import '../../service/check_internet.dart';
import '../pdf/pdf_view.dart';

class NewsList extends StatefulWidget {
  const NewsList({super.key, required this.srno, required this.news});
  final int srno;
  final String news;
  @override
  State<NewsList> createState() => _nameState();
}

class _nameState extends State<NewsList> with SingleTickerProviderStateMixin {
  List<NewsTable>? newsList;
  late ScrollController _scrollController;
  bool isInternet = true;
  bool _showBackToTopButton = false;
  String? districtId = "1";
  @override
  void initState() {
    super.initState();
    newsdate = DateFormat("yyyy-MM-dd").format(DateTime.now()).toString();
    CheckInternet.checkConnection().then((bool result) {
      print(result);
      if (result) {
        getNewsList();
        getDistrict();
      } else {
        isInternet = false;
        setState(() {});
      }
      /* check result here  */
    });

    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          if (_scrollController.offset >= 400) {
            _showBackToTopButton = true; // show the back-to-top button
          } else {
            _showBackToTopButton = false; // hide the back-to-top button
          }
        });
      });
  }

  void getNewsList() async {
    final service = ApiFetcheNewsLists();
    service.apiFetcheNewsLists(widget.srno, newsdate).then((value) {
      if (value!.isNotEmpty) {
        newsList = value.first.table;
        if (mounted) setState(() {});
        if (widget.srno == 3) {
          newsList = value.first.table!
              .where((element) => element.gDistrict.toString() == districtId)
              .toList();
          if (mounted) setState(() {});
        }
      }
    });
  }

  List<DistrictMasterModel>? districtList;
  void getDistrict() async {
    final service = ApiFetchDistrictLists();
    service.apiFetchDistrictLists().then((value) {
      if (value != null) {
        districtList = value;

        if (mounted) setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose(); // dispose the controller

    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.easeIn);
  }

  String newsdate = "";
  selectDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData(
                primarySwatch: Colors.red,
                splashColor: Theme.of(context).primaryColor,
                textTheme: TextTheme(
                  subtitle1: TextStyle(color: Colors.black),
                  button: TextStyle(color: Colors.black),
                )),
            child: child ?? Text(""),
          );
        },
        initialDate: DateTime.now(),
        firstDate: DateTime(
            2000), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      print(
          formattedDate); //formatted date output using intl package =>  2021-03-16
      //you can implement different kind of Date Format here according to your requirement

      newsdate = formattedDate;
      newsList = null;
      getNewsList();
      setState(() {});
    } else {
      print("Date is not selected");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        elevation: 1,
        title:
            Image.asset('assets/splash.gif', height: 40.h, fit: BoxFit.cover),
      ),
      floatingActionButton: _showBackToTopButton == false
          ? null
          : FloatingActionButton.small(
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: _scrollToTop,
              child: const Icon(CupertinoIcons.arrow_up),
            ),
      body:isInternet?  Column(
        children: [
          SizedBox(
            height: 16.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    widget.news,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.red,
                        fontSize: 16.sp),
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                GestureDetector(
                  onTap: () {
                    selectDate();
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Color(0xFFF1F2F6),
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      children: [
                        Text(
                          "$newsdate ",
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        Icon(
                          Icons.calendar_month_sharp,
                          size: 16.sp,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (widget.srno == 3)
            if (districtList != null)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelStyle: GoogleFonts.outfit(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                    ),
                    fillColor: Color.fromARGB(255, 245, 244, 244),
                    counterText: '',
                    errorStyle: GoogleFonts.outfit(fontSize: 12.sp),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFD9D9D9)),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFD9D9D9)),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFD9D9D9)),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(225, 30, 61, 1),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    hintStyle: GoogleFonts.outfit(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                    ),
                    filled: true,
                    isDense: true,
                    contentPadding:
                        const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                    hintText: "hintText",
                    floatingLabelStyle:
                        Theme.of(context).textTheme.displaySmall,
                  ),
                  dropdownColor: const Color.fromARGB(255, 245, 241, 241),
                  style: const TextStyle(
                      color: Colors.black, //<-- SEE HERE
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  value: districtId, // guard it with null if empty
                  items: districtList!.first.table!
                      .map<DropdownMenuItem<String>>((productList) {
                    return DropdownMenuItem<String>(
                      value: productList.gDistrictid.toString(),
                      child: Text(
                        productList.gDistrictnametamil.toString(),
                      ),
                    );
                  }).toList(),
                  hint: Text(
                    "Select District",
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                    ),
                  ),
                  onChanged: (String? newValue) {
                    districtId = newValue.toString();
                    newsList = null;

                    getNewsList();
                    setState(() {});
                  },
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'District is Required';
                    }
                  },
                ),
              ),
          Expanded(
              child: newsList != null
                  ? newsList!.isNotEmpty
                      ? ListView.builder(
                          controller: _scrollController,
                          physics: const BouncingScrollPhysics(),
                          itemCount: newsList!.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.h, horizontal: 12.w),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => NewsDetails(
                                                  newsData: newsList![index],
                                                )));
                                  },
                                  child: index == 0
                                      ? AspectRatio(
                                          aspectRatio: 16 / 6,
                                          child: Stack(
                                            fit: StackFit.expand,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                child: Image.network(
                                                  "https://admin.murasoli.in/assets/layout/Documents/${newsList![index].gImage.toString()}",
                                                  fit: BoxFit.cover,
                                                  color: Color(0x66000000),
                                                  colorBlendMode:
                                                      BlendMode.darken,
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 12.h,
                                                      left: 16.w,
                                                      right: 16.w),
                                                  child: Text(
                                                    newsList![index]
                                                        .gNewstitletamil
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.white,
                                                        fontSize: 14.sp),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      : NewsCard(
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
                                              .gIncidentdate
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
                            child: Text("News not available on $newsdate"),
                          ),
                        )
                  : Center(
                      child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ))),
        ],
      ): Column(
                children: [
                  Expanded(
                      child: Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/nointernet.png",
                          height: 110.h,
                        ),
                        Text(
                          "   No Internet",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              // color: Theme.of(context).primaryColor,
                              fontSize: 14.sp),
                        )
                      ],
                    ),
                  )),
                ],
              ));
  }
}
