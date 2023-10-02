import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:murasoli_ios/view/contact/contact.dart';
import 'package:murasoli_ios/view/epaper/epaper.dart';
import 'package:murasoli_ios/view/terms&conditions/terms&conditions.dart';
import 'package:url_launcher/url_launcher.dart';
import '../about/about.dart';
import '../bottombar/bottombar.dart';
import '../edition/edition_list.dart';
import '../pdf/pdf_view.dart';
import '../terms&conditions/privacypolicy.dart';

class NavBar extends StatelessWidget {
  NavBar({super.key, required this.index2});
  final int index2;
  List listview = [
    {"title": "மு­கப்­பு", "logo": "home", "page": BottomBar(index: 0)},
    {"title": "தலையங்­கம்", "logo": "edit", "page": BottomBar(index: 1)},
    {
      "title": "செய்திகள்",
      "logo": "earth",
      "page": BottomBar(index: 2),
      "category": [
        {"category": "உலக செய்திகள்", "srno": 4},
        {"category": "தேசிய செய்திகள்", "srno": 1},
        {"category": "மாநில செய்திகள்", "srno": 2},
        {"category": "மாவட்ட செய்திகள்", "srno": 3},
        {"category": "சிறப்பு மலர் 2023", "srno": 5}
      ]
    },
    {
      "title": "பதிப்­பு",
      "logo": "print",
      "page": BottomBar(index: 3),
      "category": [
        {"category": "சென்னை பதிப்பு", "image": "assets/news1.png", "srno": 1},
        {"category": "மதுரை பதிப்பு", "image": "assets/news2.png", "srno": 2},
        {
          "category": "ஒருங்கிணைந்த திருச்சி",
          "image": "assets/news3.png",
          "srno": 3
        },
        {
          "category": "ஒருங்கிணைந்த கோயம்புத்தூர்",
          "image": "assets/news4.png",
          "srno": 4
        },
        {
          "category": "ஒருங்கிணைந்த வேலூர்",
          "image": "assets/news5.png",
          "srno": 5
        }
      ]
    },
    {"title": "முரசொலி பற்றி", "logo": "about", "page": About()},
    {"title": "தொடர்பு கொள்க", "logo": "call", "page": const Contactus()},
    {
      "title": "இ – பேப்பர்",
      "logo": "epaper",
      "page": const Epaper(
        url: "https://epaper.murasoli.in/",
      )
    },
    {
      "title": "The Rising Sun",
      "logo": "sun",
      "page":
          PdfView(pdf: "http://murasoli.devtesting.in/files/Rising%20Sun.pdf")
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      width: MediaQuery.of(context).size.width / 1.2,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
            child: Column(
              // Remove padding
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Center(
                  child: Image.asset(
                    "assets/splash.gif",
                    height: 50.h,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Divider(
                  height: 0,
                  //  color: Colors.grey[300],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Column(
                  children: List.generate(
                      listview.length,
                      (index) => listview[index]["logo"].toString() ==
                                  "earth" ||
                              listview[index]["logo"].toString() == "print"
                          ? Padding(
                              padding: EdgeInsets.only(
                                  bottom: listview[index]["logo"].toString() ==
                                          "earth"
                                      ? 6.h
                                      : 20.h),
                              child: ListTileTheme(
                                contentPadding: EdgeInsets.zero,
                                minVerticalPadding: 0,
                                dense: true,
                                minLeadingWidth: 0,
                                horizontalTitleGap: 10.w,
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                      dividerColor: Colors.transparent),
                                  child: ExpansionTile(
                                      childrenPadding:
                                          EdgeInsets.only(left: 29.w),
                                      tilePadding: EdgeInsets.zero,
                                      leading: SvgPicture.asset(
                                        "assets/svg/${listview[index]["logo"]}.svg",
                                        color: index2 == index
                                            ? Theme.of(context).primaryColor
                                            : Theme.of(context).iconTheme.color,
                                      ),
                                      title: Text(
                                        listview[index]["title"],
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              fontSize: 14.sp,
                                              color: index2 == index
                                                  ? Theme.of(context)
                                                      .primaryColor
                                                  : Theme.of(context)
                                                      .iconTheme
                                                      .color,
                                            ),
                                      ),
                                      children: List.generate(
                                        int.parse(listview[index]["category"]
                                            .length
                                            .toString()),
                                        (index3) => GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                            if (listview[index]["logo"]
                                                    .toString() ==
                                                "print") {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditionList(
                                                            srNo: listview[
                                                                        index]
                                                                    ["category"]
                                                                [
                                                                index3]["srno"],
                                                            title: listview[
                                                                        index]
                                                                    ["category"]
                                                                [
                                                                index3]["category"],
                                                          )));
                                            } else {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          listview[index]
                                                              ["page"]));
                                            }
                                          },
                                          child: ListTile(
                                              contentPadding: EdgeInsets.zero,
                                              dense: true,
                                              title: Text(
                                                listview[index]["category"]
                                                    [index3]["category"],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      fontSize: 14.sp,
                                                      color: Theme.of(context)
                                                          .iconTheme
                                                          .color,
                                                    ),
                                              )),
                                        ),
                                      )),
                                ),
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.only(
                                  bottom: listview[index]["logo"].toString() ==
                                          "edit"
                                      ? 20.h
                                      : 30.h),
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  Navigator.pop(context);
                                  if (listview[index]["logo"].toString() ==
                                      "about") {
                                    context.push("/about", );
                                  } else {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                listview[index]["page"]));
                                  }
                                },
                                child: _buildIconwithText(
                                    listview[index]["title"],
                                    listview[index]["logo"],
                                    context,
                                    index),
                              ),
                            )),
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => TermsandConditions()));
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit_document,
                        size: 20.sp,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        "Terms and Conditions",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 14.sp,
                              color: Theme.of(context).iconTheme.color,
                            ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PrivacyPolicy()));
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.security_rounded,
                        size: 20.sp,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        "Privacy policy ",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 14.sp,
                              color: Theme.of(context).iconTheme.color,
                            ),
                      )
                    ],
                  ),
                ),
                // GestureDetector(
                //   behavior: HitTestBehavior.opaque,
                //   onTap: () {
                //     Navigator.pop(context);
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => const contactus(),
                //       ),
                //     );
                //   },
                //   child: _buildIconwithText("தொடர்பு கொள்க", "call", context),
                // ),
                // GestureDetector(
                //   behavior: HitTestBehavior.opaque,
                //   onTap: () {
                //     Navigator.pop(context);
                //     //  Navigator.push(
                //     //     context,
                //     //     MaterialPageRoute(
                //     //       builder: (context) => const Awards(),
                //     //     ),
                //     //   );
                //   },
                //   child: _buildIconwithText("இ – பேப்பர்", "epaper", context),
                // ),
                SizedBox(
                  height: 60.h,
                ),
                Text(
                  "Follow us",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 16.sp,
                      color: Theme.of(context).iconTheme.color,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        launchUrl(
                            Uri.parse('https://www.facebook.com/murasoli180'));
                      },
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            "assets/facebook.png",
                            height: 20.h,
                            fit: BoxFit.cover,
                          )),
                    ),
                    SizedBox(
                      width: 14.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        launchUrl(Uri.parse(
                            'https://www.instagram.com/murasoli180/'));
                      },
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            "assets/insta.png",
                            height: 20.h,
                            fit: BoxFit.cover,
                          )),
                    ),
                    SizedBox(
                      width: 14.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        launchUrl(Uri.parse('https://twitter.com/murasoli180'));
                      },
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            "assets/twiter.png",
                            height: 20.h,
                            fit: BoxFit.cover,
                          )),
                    ),
                    SizedBox(
                      width: 14.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        launchUrl(
                            Uri.parse('https://www.youtube.com/@murasoli180'));
                      },
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            "assets/youtube.png",
                            height: 20.h,
                            fit: BoxFit.cover,
                          )),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildIconwithText(String text, String svg, context, int selected) {
    return Row(
      children: [
        if (svg == "sun")
          Icon(
            Icons.wb_sunny_outlined,
            size: 20.sp,
          )
        else
          SvgPicture.asset(
            "assets/svg/$svg.svg",
            color: selected == index2
                ? Theme.of(context).primaryColor
                : Theme.of(context).iconTheme.color,
          ),
        SizedBox(
          width: 10.w,
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 14.sp,
                color: selected == index2
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).iconTheme.color,
              ),
        )
      ],
    );
  }
}
