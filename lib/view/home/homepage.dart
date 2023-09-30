import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:murasoli_ios/model/ThirukuralModel.dart';
import 'package:murasoli_ios/service/get_flashnews.dart';
import 'package:murasoli_ios/view/news/news_details.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../components/news_card.dart';
import '../../components/shimmer_effect.dart';
import '../../model/NewsModel.dart';
import '../../service/get_homepage_news.dart';
import '../../service/get_news.dart';
import '../../service/get_thirukal.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _nameState();
}

class _nameState extends State<Homepage> {
  int _currentIndex = 0;
  bool showYoutube = true;
  bool _showBackToTopButton = false;

  List bannerImages = [
    {"images": "assets/image1.jpg"},
    {"images": "assets/image2.png"},
    {"images": "assets/image1.jpg"},
    {"images": "assets/image1.jpg"},
    {"images": "assets/image1.jpg"}
  ];
  @override
  void initState() {
    super.initState();
    getThirukuralList();
    getNewsList(1);
    getFlashNews();
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
    String videoId = YoutubePlayer.convertUrlToId(
        "https://www.youtube.com/watch?v=80k61iho8Gw&t=1s")!;
    controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(videoId)!,
      flags: const YoutubePlayerFlags(
          mute: false,
          autoPlay: false,
          disableDragSeek: false,
          loop: false,
          isLive: false,
          forceHD: false,
          enableCaption: true,
          showLiveFullscreenButton: true),
    )..addListener(() {
        if (mounted) setState(() {});
      });
  }

  // scroll controller
  late ScrollController _scrollController;

  List<NewsTable>? newsList;
  void getNewsList(int id) async {
    final service = ApiFetchHomePageLists();
    service.apiFetchHomePageLists().then((value) {
      if (value != null) {
        //  newsList = value.first.table;
        newsList = value.first.table!
            .where((element) => element.gPriority.toString() == "2")
            .toList();
        if (mounted) setState(() {});
      }
    });
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _scrollController.dispose(); // dispose the controller
    controller.dispose();

    super.dispose();
  }

  List flashNews = [];
  String flashNewsString = "";
  List<ThirukuralModel>? thirukalList;
  void getFlashNews() async {
    final service = ApiFetchFlashNewsLists();

    service.apiFetchFlashNewsLists().then((value) {
      if (value.isNotEmpty) {
        flashNews = value;
        flashNewsString = flashNews
            .map((val) {
              return val["g_newsdetailstamil"];
            })
            .join('  .  ')
            .toString();
        // String s = flashNews.join(', ');
        //print(result);
        if (mounted) setState(() {});
      }
    });
  }

  void getThirukuralList() async {
    final service = ApiGetThirukuralMaster();

    service.apiGetThirukuralMaster().then((value) {
      if (value != null) {
        thirukalList = value;

        if (mounted) setState(() {});
      }
    });
  }

  // This function is triggered when the user presses the back-to-top button
  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(seconds: 3), curve: Curves.linear);
  }

  late YoutubePlayerController controller;
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
        body: newsList == null
            ? ShimmerWidget()
            : SingleChildScrollView(
                controller: _scrollController,
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                        padding: EdgeInsets.only(top: 8.h),
                        color: Theme.of(context).primaryColor,
                        height: 35.h,
                        width: double.infinity,
                        child: Marquee(
                          text: flashNewsString,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 14.sp),
                          scrollAxis: Axis.horizontal,
                          crossAxisAlignment: CrossAxisAlignment.center,

                          blankSpace: 20.0,
                          velocity: 100.0,
                          //  pauseAfterRound: Duration(seconds: 1),
                          showFadingOnlyWhenScrolling: true,
                          fadingEdgeStartFraction: 0.1,
                          fadingEdgeEndFraction: 0.1,
                          //numberOfRounds: 3,
                          startPadding: 10.0,

                          accelerationDuration: Duration(seconds: 1),
                          accelerationCurve: Curves.linear,
                          decelerationDuration: Duration(milliseconds: 500),
                          decelerationCurve: Curves.easeOut,
                        )),
                    SizedBox(
                      height: 12.h,
                    ),
                    CarouselSlider.builder(
                        itemCount: 5,
                        itemBuilder: (context, index, realIndex) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: InkWell(
                              onTap: () {
                                // context.pushNamed(
                                //     "newscontent?storyid=${newsList![index].gSlno}");
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => NewsDetails(
                                          newsData: newsList![index],
                                        )));
                              },
                              child: Stack(
                                children: [
                                  AspectRatio(
                                    aspectRatio: 16 / 9,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.network(
                                        "https://admin.murasoli.in/assets/layout/Documents/${newsList![index].gImage.toString()}",
                                        fit: BoxFit.cover,
                                        color: Color(0x66000000),
                                        colorBlendMode: BlendMode.darken,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 20.h,
                                          left: 20.w,
                                          right: 26.w),
                                      child: Text(
                                        newsList![index]
                                            .gNewstitletamil
                                            .toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                            fontSize: 14.sp),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        options: CarouselOptions(
                          //  height: getProportionateScreenHeight(300),
                          aspectRatio: 16 / 8,
                          enlargeCenterPage: true,

                          viewportFraction: 0.85,
                          initialPage: 0,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },

                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          // autoPlayCurve: Curves.fastOutSlowIn,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          // onPageChanged: pageController,
                          enlargeStrategy: CenterPageEnlargeStrategy.zoom,

                          scrollDirection: Axis.horizontal,
                        )),
                    DotsIndicator(
                      dotsCount: 5,
                      position: _currentIndex,
                      decorator: DotsDecorator(
                        activeColor: Theme.of(context).primaryColor,
                        activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "இன்றைய செய்திகள்",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 16.sp),
                          ),
                          // Text(
                          //   "See all",
                          //   style: TextStyle(
                          //       fontWeight: FontWeight.w400,
                          //       color: Theme.of(context).primaryColor,
                          //       fontSize: 12.sp),
                          // )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    if (newsList != null)
                      if (newsList!.isNotEmpty)
                        ListView.builder(
                          itemCount:
                              newsList!.length > 10 ? 10 : newsList!.length,
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: (context, index) {
                            if (index < 5) return SizedBox();
                            return Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 12.h, horizontal: 12.w),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => NewsDetails(
                                                  newsData: newsList![index],
                                                )));
                                  },
                                  child: NewsCard(
                                    onTap: () {
                                      Share.share(
                                          'www.murasoli.in/newscontent?storyid=${newsList![index].gSlno}');
                                    },
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
                      else
                        Center(
                          child: Container(
                            child: const Text("No News"),
                          ),
                        )
                    else
                      Center(
                          child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      )),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "தினம் ஒரு திருக்குறள்",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.red,
                                fontSize: 16.sp),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.w, vertical: 10.h),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.asset(
                            "assets/thiruvalluvar.jpg",
                            fit: BoxFit.cover,
                            // color: Color(0x66000000),
                            // colorBlendMode: BlendMode.darken,
                          ),
                        ),
                      ),
                    ),
                    if (thirukalList != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 10.h),
                            child: Shimmer(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color.fromRGBO(85, 60, 152, 1),
                                    Color.fromRGBO(0, 194, 203, 1),
                                    Color.fromRGBO(238, 75, 43, 1),
                                  ],
                                  stops: [
                                    0.1,
                                    0.3,
                                    0.4,
                                  ],
                                  begin: Alignment(-1.0, -0.3),
                                  end: Alignment(1.0, 0.3),
                                  tileMode: TileMode.clamp,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.sp,
                                            ),
                                            '${thirukalList!.first.table![0].gKural}')),
                                    // Text(
                                    //   '${thirukalList!.first.table![0].gKural}',
                                    //   style: TextStyle(
                                    //       fontSize: 12.sp, fontWeight: FontWeight.w500),
                                    // ),
                                    SizedBox(
                                      height: 6.h,
                                    ),
                                    FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.sp,
                                            ),
                                            '${thirukalList!.first.table![0].gKural1}')),
                                    // Text(
                                    //   '${thirukalList!.first.table![0].gKural1}',
                                    //   style: TextStyle(
                                    //       fontSize: 12.sp, fontWeight: FontWeight.w500),
                                    // ),
                                  ],
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 4.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'குறள் : ',
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor),
                                ),
                                Text(
                                  '${thirukalList!.first.table![0].gKuralno}',
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                //Spacer(),
                                Text(
                                  'அதிகாரம் : ',
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor),
                                ),
                                Flexible(
                                  child: Text(
                                    '${thirukalList!.first.table![0].gAdhigaram}',
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 6.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'பிரிவு : ',
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor),
                                ),
                                Text(
                                  '${thirukalList!.first.table![0].gPirivu}',
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Text(
                                  'கிளை : ',
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor),
                                ),
                                Flexible(
                                  child: Text(
                                    '${thirukalList!.first.table![0].gKilai}',
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 10.h),
                            child: Text(
                              style: GoogleFonts.roboto(
                                  height: 1.4,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400),
                              '${thirukalList!.first.table![0].gMeaning}',
                            ),
                          )
                        ],
                      ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      "முரசொலியின் வரலாறு!",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.red,
                          fontSize: 16.sp),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: YoutubePlayerBuilder(
                          // onExitFullScreen: () {
                          //   // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
                          //   SystemChrome.setPreferredOrientations(
                          //       DeviceOrientation.values);
                          // },
                          player: YoutubePlayer(
                            controller: controller,
                            showVideoProgressIndicator: true,
                            progressIndicatorColor: Colors.red,
                            topActions: <Widget>[
                              const SizedBox(width: 8.0),
                              Expanded(
                                child: Text(
                                  controller.metadata.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.settings,
                                  color: Colors.white,
                                  size: 25.0,
                                ),
                                onPressed: () {
                                  //log('Settings Tapped!');
                                },
                              ),
                            ],
                          ),
                          builder: (context, player) {
                            return AspectRatio(
                              aspectRatio: 16 / 9,
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  // some widgets
                                  player,
                                  Align(
                                    alignment: Alignment.center,
                                    child: GestureDetector(
                                        onTap: () {
                                          controller.play();
                                          showYoutube = false;
                                          setState(() {});
                                        },
                                        child: showYoutube
                                            ? Image.asset(
                                                "assets/youtube2.png",
                                                height: 70.h,
                                                fit: BoxFit.cover,
                                              )
                                            : Container()),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    if (newsList != null)
                      if (newsList!.isNotEmpty)
                        ListView.builder(
                          itemCount:
                              newsList!.length > 10 && newsList!.length < 20
                                  ? newsList!.length
                                  : 20,
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: (context, index) {
                            if (index < 10) return SizedBox();
                            return Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 12.h, horizontal: 12.w),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => NewsDetails(
                                                  newsData: newsList![index],
                                                )));
                                  },
                                  child: NewsCard( onTap: () {
                                      Share.share(
                                          'www.murasoli.in/newscontent?storyid=${newsList![index].gSlno}');
                                    },
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
                      else
                        Center(
                          child: Container(
                            child: const Text("No News"),
                          ),
                        )
                    else
                      Center(
                          child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      )),
                  ],
                )));
  }
}
