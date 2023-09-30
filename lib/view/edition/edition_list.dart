import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:murasoli_ios/service/get_editions.dart';
import 'package:murasoli_ios/view/news/news_details.dart';
import '../../components/appbar.dart';
import '../../components/news_card.dart';
import '../../model/NewsModel.dart';
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
  bool _showBackToTopButton=false;
  @override
  void initState() {
    super.initState();
    getEditionList();
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
  List<NewsModel>? editionList;
  void getEditionList() async {
    final service = ApiFetcheditionLists();
    service.apiFetchedition(widget.srNo).then((value) {
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
        title:
            Image.asset('assets/splash.gif', height: 40.h, fit: BoxFit.cover),
       
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: 16.h, left: 14.w, bottom: 6.h, right: 14.w),
            child: Text(
              widget.title,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                  fontSize: 16.sp),
            ),
          ),
          Expanded(
              child: editionList != null
                  ? editionList!.length != 0
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
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => NewsDetails(
                                            newsData: editionList!
                                                .first.table![index],
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
                                                "https://admin.murasoli.in/assets/layout/Documents/${editionList!.first.table![index].gImage.toString()}",
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
                                                  editionList!
                                                      .first
                                                      .table![index]
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
                                        image:
                                            "${editionList!.first.table![index].gImage.toString()}",
                                        newsTitle: editionList!
                                            .first.table![index].gNewstitletamil
                                            .toString(),
                                        date: editionList!
                                            .first.table![index].gCreateddate
                                            .toString(),
                                        newsDis: editionList!
                                            .first.table![index].gNewsshorttamil
                                            .toString(),
                                      ),
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Container(
                            child: Text("No News"),
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
