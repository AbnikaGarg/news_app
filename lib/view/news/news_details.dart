import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import '../../model/NewsModel.dart';

class NewsDetails extends StatefulWidget {
  NewsDetails({
    super.key,
    required this.newsData,
  });
  final NewsTable newsData;

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  double fontSize = 14;
  late ScrollController _scrollController;
  bool _showBackToTopButton = false;
  @override
  void initState() {
    super.initState();
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
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
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
        backgroundColor: Colors.white,
        body: CustomScrollView(controller: _scrollController, slivers: [
          SliverAppBar(
            expandedHeight: 400.h,

            elevation: 0,
            backgroundColor: Theme.of(context).primaryColor,
            actions: [
              GestureDetector(
                onTap: () {
                  Share.share(
                      'www.murasoli.in/newscontent?storyid=${widget.newsData.gSlno}');
                },
                child: Container(
                  margin: EdgeInsets.only(right: 10.w),
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xB2000000)),
                  child: Icon(
                    CupertinoIcons.share,
                    color: Colors.white,
                    size: 20.h,
                  ),
                ),
              ),
            ],
            leading: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 10.w),
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xB2000000)),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            floating: false,
            pinned: true,
            //snap: false,
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(90.h),
                child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(22),
                          topRight: Radius.circular(22))),
                )),
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              centerTitle: true,
              title: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.newsData.gNewstitletamil.toString(),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'முரசொலி | ${widget.newsData.gIncidentdate!}',
                            style: GoogleFonts.roboto(
                                fontSize: 8.sp, fontWeight: FontWeight.w400),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              fontSize++;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFF1F2F6),
                            ),
                            child: Text(
                              " A+ ",
                              style: TextStyle(
                                  fontSize: 10.sp, color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (fontSize > 0) {
                                fontSize--;
                              }
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFF1F2F6),
                            ),
                            child: Text(
                              " A- ",
                              style: TextStyle(
                                  fontSize: 10.sp, color: Colors.black),
                            ),
                          ),
                        ),
                        // ClipRRect(
                        //     borderRadius: BorderRadius.circular(50),
                        //     child: Image.asset(
                        //       "assets/facebook.png",
                        //       height: 10.h,
                        //       fit: BoxFit.cover,
                        //     )),
                        // SizedBox(
                        //   width: 3.w,
                        // ),
                        // ClipRRect(
                        //     borderRadius: BorderRadius.circular(50),
                        //     child: Image.asset(
                        //       "assets/insta.png",
                        //       height: 10.h,
                        //       fit: BoxFit.cover,
                        //     )),
                        // SizedBox(
                        //   width: 3.w,
                        // ),
                        // ClipRRect(
                        //     borderRadius: BorderRadius.circular(50),
                        //     child: Image.asset(
                        //       "assets/linkedin.png",
                        //       height: 10.h,
                        //       fit: BoxFit.cover,
                        //     )),
                        // SizedBox(
                        //   width: 3.w,
                        // ),
                        // ClipRRect(
                        //     borderRadius: BorderRadius.circular(50),
                        //     child: Image.asset(
                        //       "assets/twiter.png",
                        //       height: 10.h,
                        //       fit: BoxFit.cover,
                        //     )),
                        // SizedBox(
                        //   width: 3.w,
                        // ),
                        // ClipRRect(
                        //     borderRadius: BorderRadius.circular(50),
                        //     child: Image.asset(
                        //       "assets/youtube.png",
                        //       height: 10.h,
                        //       fit: BoxFit.cover,
                        //     ))
                      ],
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                  ],
                ),
              ),
              background: Image.network(
                "https://admin.murasoli.in/assets/layout/Documents/${widget.newsData.gImage.toString()}",
                fit: BoxFit.cover,
                color: Color.fromARGB(102, 48, 47, 47),
                colorBlendMode: BlendMode.darken,
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(left: 12.w, right: 12.w),
                  child: HtmlWidget(
                    textStyle: TextStyle(
                          height: 1.4,
                          fontSize: fontSize,
                          wordSpacing: 2), """
              ${widget.newsData.gNewsdetailstamil}
                """,
                  )))
        ]));
  }
}
