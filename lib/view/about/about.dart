import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../epaper/epaper.dart';
import '../search/search.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _nameState();
}

class _nameState extends State<About> {
  String newsdate = "";
  @override
  void initState() {
    super.initState();
    newsdate = DateFormat("dd-MM-yyyy").format(DateTime.now()).toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        elevation: 1,
        title:
            Image.asset('assets/splash.gif', height: 40.h, fit: BoxFit.cover),
      
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20.h,
            ),
            Text(
              "முரசொலி",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColor,
                  fontSize: 20.sp),
            ),
            SizedBox(
              height: 20.h,
            ),
            Image.asset(
              "assets/logo5.jpg",
              fit: BoxFit.contain,
              height: 200.h,
              width: double.infinity,
              //  color: Color.fromARGB(102, 48, 47, 47),
              // colorBlendMode: BlendMode.darken,
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 14.w,
              ),
              child: Text(
                  style: GoogleFonts.roboto(
                      wordSpacing: 2,
                      height: 1.4,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400),
                  "கலைஞர் பெற்ற முதற்குழந்தை முரசொலி. அதற்கு அவர் தந்தையும் தாயுமானார். கலைஞரின் அத்தனை போர்க்குணங்களும் முரசொலிக்கு உண்டு. ஏனெனில் கலைஞரின் மற்றொரு வடிவமே முரசொலி. அவரின் எல்லா மெய்ப்பாடுகளையும் முரசொலி காலந்தோறும் எதிரொலித்தே வந்து கொண்டிருக்கிறது"),
            ),
          ],
        ),
      ),
    );
  }
}
