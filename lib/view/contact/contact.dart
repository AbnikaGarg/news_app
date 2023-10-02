import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import 'maps.dart';

class Contactus extends StatelessWidget {
  const Contactus({super.key});

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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(
              height: 16.h,
            ),
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: Theme.of(context).primaryColor,
                ),
                Text(
                  " முரசொலியின் வரலாறு!",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor,
                      fontSize: 16.sp),
                ),
              ],
            ),
            SizedBox(
              height: 16.h,
            ),
            GestureDetector(
              onTap: () {
                launchUrl(
                    Uri.parse('https://maps.app.goo.gl/WPYbMCU3SVZQyjFL6'));
              },
              child: Text(
                "180, கோடம்பாக்கம் நெடுஞ்சாலை, சென்னை - 600034. தமிழ்நாடு, இந்தியா.",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                    height: 1.6,
                    decoration: TextDecoration.underline),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
             Row(
              children: [
                Icon(
                  CupertinoIcons.phone,
                  size: 20.h,
                ),
                Text(
                  " 044-28179191",
                  style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
                ),
              ],
            ),
            SizedBox(
              height: 16.h,
            ),
            GestureDetector(
                  onTap: () {
                    launchUrl(
                        Uri.parse('mailto:murasolidaily@gmail.com'));
                  },
              child: Row(
                children: [
                  Icon(
                    Icons.mail_outline,
                    size: 20.h,
                  ),
                  Text(
                    "  murasolidaily@gmail.com",
                    style:
                        TextStyle(fontWeight: FontWeight.w500,color: Colors.blue, fontSize: 16.sp),
                  ),
                ],
              ),
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
                        height: 25.h,
                        fit: BoxFit.cover,
                      )),
                ),
                SizedBox(
                  width: 8.w,
                ),
                GestureDetector(
                  onTap: () {
                    launchUrl(
                        Uri.parse('https://www.instagram.com/murasoli180/'));
                  },
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        "assets/insta.png",
                        height: 25.h,
                        fit: BoxFit.cover,
                      )),
                ),
                SizedBox(
                  width: 8.w,
                ),
                GestureDetector(
                  onTap: () {
                    launchUrl(Uri.parse('https://twitter.com/murasoli180'));
                  },
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        "assets/twiter.png",
                        height: 25.h,
                        fit: BoxFit.cover,
                      )),
                ),
                SizedBox(
                  width: 8.w,
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
                        height: 25.h,
                        fit: BoxFit.cover,
                      )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
