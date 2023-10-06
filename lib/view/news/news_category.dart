import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:murasoli_ios/view/edition/edition_list.dart';

import '../pdf/pdf_view.dart';
import 'news_list.dart';

// ignore: must_be_immutable
class NewsCat extends StatelessWidget {
  NewsCat({super.key});

  List newsCat = [
    {"category": "உலக செய்திகள்", "image": "assets/worldnews.jpeg", "srno": 4},
    {
      "category": "தேசிய செய்திகள்",
      "image": "assets/nationalnews.jpeg",
      "srno": 1
    },
    {"category": "மாநில செய்திகள்", "image": "assets/state.jpeg", "srno": 3},
    {"category": "சிறப்பு மலர்", "image": "assets/flower.jpeg", "srno": 2}
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(
            height: 16.h,
          ),
          ListView.builder(
            itemCount: newsCat.length,
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 20.w),
                child: GestureDetector(
                  onTap: () {
                    if (newsCat[index]["srno"] == 2) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PdfView(
                              pdf:
                                  "http://murasoli.devtesting.in/files/Murasoli%20Malar.pdf")));
                                  return;
                    }
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => NewsList(
                              srno: newsCat[index]["srno"],
                              news: newsCat[index]["category"],
                            )));
                  },
                  child: Container(
                    height: 120.h,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.4), BlendMode.darken),
                        image: AssetImage(newsCat[index]["image"]),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Text(
                      newsCat[index]["category"],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
