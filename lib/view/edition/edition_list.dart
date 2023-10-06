import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:murasoli_ios/service/get_editions.dart';
import 'package:murasoli_ios/view/news/news_details.dart';
import 'package:share_plus/share_plus.dart';
import '../../components/appbar.dart';
import '../../components/news_card.dart';
import '../../model/NewsModel.dart';
import '../../service/check_internet.dart';
import '../bottombar/bottombar.dart';
import '../epaper/epaper.dart';

class EditionList extends StatefulWidget {
  const EditionList({super.key, required this.srNo, required this.title});
  final int srNo;
  final String title;

  @override
  State<EditionList> createState() => _nameState();
}

class _nameState extends State<EditionList> {
  late ScrollController _scrollController;
  bool _showBackToTopButton = false;
  bool isInternet = true;
  @override
  void initState() {
    super.initState();
    newsdate = DateFormat("yyyy-MM-dd").format(DateTime.now()).toString();
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
    CheckInternet.checkConnection().then((bool result) {
      print(result);
      if (result) {
        getEditionList();
      } else {
        isInternet = false;
        setState(() {});
      }
      /* check result here  */
    });
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
      editionList = null;
      getEditionList();
      setState(() {});
    } else {
      print("Date is not selected");
    }
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

  List<NewsModel>? editionList;
  void getEditionList() async {
    final service = ApiFetcheditionLists();
    service.apiFetchedition(widget.srNo, newsdate).then((value) {
      if (value != null) {
        editionList = value;
        if (mounted) setState(() {});
      }
    });
  }

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
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          elevation: 1,
          title: InkWell(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => BottomBar(
                            index: 0,
                          )),
                  (Route<dynamic> route) => false,
                );
              },
              child: Image.asset('assets/splash.gif',
                  height: 40.h, fit: BoxFit.cover)),
        ),
        body: isInternet
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            widget.title,
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
                  Expanded(
                      child: editionList != null
                          ? editionList!.first.table!.length != 0
                              ? ListView.builder(
                                  controller: _scrollController,
                                  itemCount: editionList!.first.table!.length,
                                  shrinkWrap: true,
                                  primary: false,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 12.h, horizontal: 14.w),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      NewsDetails(
                                                        newsData: editionList!
                                                            .first
                                                            .table![index],
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
                                                          BorderRadius.circular(
                                                              12),
                                                      child: Image.network(
                                                        "https://admin.murasoli.in/assets/layout/Documents/${editionList!.first.table![index].gImage.toString()}",
                                                        fit: BoxFit.cover,
                                                        color:
                                                            Color(0x66000000),
                                                        colorBlendMode:
                                                            BlendMode.darken,
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 12.h,
                                                                left: 16.w,
                                                                right: 16.w),
                                                        child: Text(
                                                          editionList!
                                                              .first
                                                              .table![index]
                                                              .gNewstitletamil
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14.sp),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            : NewsCard(
                                                onTap: () {
                                                  Share.share(
                                                      'www.murasoli.in/newscontent?storyid=${editionList!.first.table![index].gSlno}');
                                                },
                                                editionid:
                                                    "${editionList!.first.table![index].gEditionid.toString()}",
                                                image:
                                                    "${editionList!.first.table![index].gImage.toString()}",
                                                newsTitle: editionList!
                                                    .first
                                                    .table![index]
                                                    .gNewstitletamil
                                                    .toString(),
                                                date: editionList!.first
                                                    .table![index].gIncidentdate
                                                    .toString(),
                                                newsDis: editionList!
                                                    .first
                                                    .table![index]
                                                    .gNewsshorttamil
                                                    .toString(),
                                              ),
                                      ),
                                    );
                                  },
                                )
                              : Center(
                                  child: Container(
                                    child:
                                        Text("News not available on $newsdate"),
                                  ),
                                )
                          : Center(
                              child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                            ))),
                ],
              )
            : Column(
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
