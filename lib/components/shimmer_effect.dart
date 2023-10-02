import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      children: [
        SizedBox(
          height: 20.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: ShimmerBaseWidget.rectangular(
              height: 180.h,
              // AppConfig.responsiveHeight(
              //     mobile: fontSize15, tablet: fontSize20)
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
              5,
              (index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ShimmerBaseWidget.circular(
                      width: 10,
                      height: 10,
                    ),
                  )),
        ),
        SizedBox(
          height: 20.h,
        ),
        ListView.builder(
          itemCount: 5,
          primary: false,
          shrinkWrap: true,
          itemBuilder: (context, index) {
          return  Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: ShimmerBaseWidget.rectangular(
              height: 100.h,
              width: 100.w,
              // AppConfig.responsiveHeight(
              //     mobile: fontSize15, tablet: fontSize20)
            ),
          ),
        );
        },)
      ],
    );
    // return const ListTile(
    //   leading: ShimmerBaseWidget.circular(
    //     width: 50, //AppConfig.responsiveIconSize(10, 10),
    //     height: 50, //AppConfig.responsiveIconSize(10, 10),
    //   ),
    //   title: Padding(
    //     padding: EdgeInsets.only(left: 0, right: 0, top: 8, bottom: 8),
    //     child: ShimmerBaseWidget.rectangular(
    //       height: 15,

    //       // AppConfig.responsiveHeight(
    //       //     mobile: fontSize15, tablet: fontSize20)
    //     ),
    //   ),
    //   subtitle: Padding(
    //     padding: EdgeInsets.all(8.0),
    //     child: ShimmerBaseWidget.rectangular(
    //       height: 15,
    //       // AppConfig.responsiveHeight(
    //       //     mobile: fontSize15, tablet: fontSize20)
    //     ),
    //   ),
    // );
  }
}

class ShimmerBaseWidget extends StatelessWidget {
//  const ShimmerWidget();

  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const ShimmerBaseWidget.rectangular({
    this.width = double.infinity,
    required this.height,
  }) : this.shapeBorder = const RoundedRectangleBorder();

  const ShimmerBaseWidget.circular({
    this.width = double.infinity,
    required this.height,
    this.shapeBorder = const CircleBorder(),
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Color.fromRGBO(233, 236, 239, 1),
      highlightColor: Color.fromRGBO(216, 218, 221, 1),
      //enabled: true,
      child: Container(
        width: width,
        height: height,
        // color: Colors.grey,
        decoration: ShapeDecoration(
          color: Colors.grey[100],
          shape: shapeBorder,
        ),
      ),
    );
  }
}
