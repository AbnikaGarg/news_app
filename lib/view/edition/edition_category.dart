import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:murasoli_ios/view/edition/edition_list.dart';

// ignore: must_be_immutable
class EditionCat extends StatelessWidget {
  EditionCat({super.key});
  List editionCat = [
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
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView( physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(
            height: 16.h,
          ),
          ListView.builder(
            itemCount: editionCat.length,
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 20.w),
                child: GestureDetector(
                  onTap: () {
                     Navigator.of(context).push(
                         MaterialPageRoute(builder: (context) => EditionList(srNo: editionCat[index]["srno"],title:editionCat[index]["category"], )));
                  },
                  child: Container(
                    height: 100.h,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.4), BlendMode.darken),
                        image: AssetImage(editionCat[index]["image"]),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Text(
                      editionCat[index]["category"],
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
