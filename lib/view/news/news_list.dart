import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:murasoli_ios/service/get_district.dart';
import 'package:murasoli_ios/service/get_news.dart';
import 'package:murasoli_ios/view/epaper/epaper.dart';

import 'package:murasoli_ios/view/news/news_details.dart';

import '../../components/news_card.dart';
import '../../model/DistrictMasterModel.dart';
import '../../model/NewsModel.dart';
import '../pdf/pdf_view.dart';

class NewsList extends StatefulWidget {
  const NewsList({super.key, required this.srno});
final int srno;
  @override
  State<NewsList> createState() => _nameState();
}

class _nameState extends State<NewsList> with SingleTickerProviderStateMixin {
  List<NewsTable>? newsList=[];
  void getNewsList(int id) async {
    final service = ApiFetcheNewsLists();
    service.apiFetcheNewsLists(id).then((value) {
      if (value!.isNotEmpty) {
        newsList = value.first.table;
        if (mounted) setState(() {});
        if (srno == 3) {
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

  late ScrollController _scrollController;
  late TabController tabController;
  bool _showBackToTopButton = false;
  int selectedIndex = 0;
    int srno = 0;
  @override
  void initState() {
    super.initState();
    getNewsList(1);
    getDistrict();

    tabController = TabController(length: newsCat.length, vsync: this);
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

  @override
  void dispose() {
    _scrollController.dispose(); // dispose the controller

    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.easeIn);
  }

  String? districtId = "1";

  List newsCat = [
    {"category": "உலக செய்திகள்", "srno": 4},
    {"category": "தேசிய செய்திகள்", "srno": 1},
    {"category": "மாநில செய்திகள்", "srno": 2},
    {"category": "மாவட்ட செய்திகள்", "srno": 3},
    {"category": "சிறப்பு மலர் 2023", "srno": 5}
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _showBackToTopButton == false
          ? null
          : FloatingActionButton.small(
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: _scrollToTop,
              child: const Icon(CupertinoIcons.arrow_up),
            ),
      body: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          // Container(
          //   width: double.infinity,
          //   child: SingleChildScrollView(
          //     physics: BouncingScrollPhysics(),
          //     scrollDirection: Axis.horizontal,
          //     child: Row(
          //       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: List.generate(
          //           newsCat.length,
          //           (index) => GestureDetector(
          //                 onTap: () {
          //                   selectedIndex = index;
          //                   setState(() {});
          //                   //isSelected(index);
          //                 },
          //                 child: AnimatedContainer(
          //                     duration: const Duration(milliseconds: 400),
          //                     curve: Curves.easeIn,
          //                     //height: getProportionateScreenHeight(29),
          //                     margin: EdgeInsets.only(left: 14.w),
          //                     decoration: BoxDecoration(
          //                       border: selectedIndex == index
          //                           ? Border(
          //                               bottom: BorderSide(
          //                                   width: 2.0,
          //                                   color:
          //                                       Theme.of(context).primaryColor),
          //                             )
          //                           : const Border(
          //                               bottom: BorderSide(
          //                                   width: 2.0, color: Colors.white)),
          //                     ),
          //                     child: Padding(
          //                         padding: EdgeInsets.only(bottom: 6.h),
          //                         child: Text(newsCat[index]["category"],
          //                             style: TextStyle(
          //                                 color: Theme.of(context).primaryColor,
          //                                 fontSize: 14.sp)))),
          //               )),
          //     ),
          //   ),
          // ),

          TabBar(
            onTap: (value) {
              // print(newsCat[value]["srno"].toString());
              if (value == 4) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PdfView(pdf:"http://murasoli.devtesting.in/files/Murasoli%20Malar.pdf")));
              }
              newsList = null;
              srno = newsCat[value]["srno"];
              getNewsList(newsCat[value]["srno"]);
              setState(() {});
            },
            isScrollable: true,
            physics: const BouncingScrollPhysics(),
            labelColor: Theme.of(context).primaryColor,
            // indicatorSize: TabBarIndicatorSize.tab,
            padding: EdgeInsets.zero,
            indicatorSize: TabBarIndicatorSize.label,
            //labelPadding: EdgeInsets.a,
            // indicatorPadding:EdgeInsets.symmetric(horizontal: 10.w, vertical: 0),
            indicatorColor: Theme.of(context).primaryColor,
            labelStyle: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 14.sp,
            ),
            unselectedLabelStyle: TextStyle(
                color: Theme.of(context).primaryColor, fontSize: 14.sp),
            controller: tabController,
            tabs: newsCat.map((newsCat) {
              return Tab(
                text: newsCat["category"],
              );
            }).toList(),
          ),
          SizedBox(
            height: 10.h,
          ),
          if (srno == 3)
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
                    srno = 3;
                    getNewsList(3);
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
                                    context.go("/newscontent");
                                    // Navigator.of(context)
                                    //     .push(MaterialPageRoute(
                                    //         builder: (context) => NewsDetails(
                                    //               newsData: newsList![index],
                                    //             )));
                                  },
                                  child: index == 0
                                      ?   AspectRatio(
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
                                                alignment: Alignment.bottomCenter,
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
                            child: const Text("No News"),
                          ),
                        )
                  : Center(
                      child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ))),
        ],
      ),
    );
  }
}
