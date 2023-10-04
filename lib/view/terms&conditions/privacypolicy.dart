import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../epaper/epaper.dart';
import '../search/search.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        elevation: 1,
        title:
            Image.asset('assets/splash.gif', height: 40.h, fit: BoxFit.cover),
        actions: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Search()));
                },
                child: Container(
                  margin: EdgeInsets.only(right: 12.w),
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: Color(0xFFF1F2F6),
                      borderRadius: BorderRadius.circular(12)),
                  child: Icon(
                    Icons.search,
                    size: 18.sp,
                    color: Colors.black,
                  ),
                ),
              ),
              
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.only(top: 16.h, left: 10.w, bottom: 6.h, right: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Privacy policy",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.red,
                    fontSize: 16.sp),
              ),
            
              // Text(
              //   "1. Introduction",
              //   style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
              // ),
              // SizedBox(
              //   height: 10.h,
              // ),
              const HtmlWidget(
                textStyle:TextStyle(
                      height: 1.4,
                      // margin: Margins.zero,
                      fontSize: 14,
                      wordSpacing: 2),
                """
                <p _ngcontent-dwv-c135="" class="policy">This Privacy Policy outlines how Murasoli News. ("Murasoli," "we," "us," or "our") collects, uses, discloses, and protects the personal information of users ("you" or "your") of the News reading website, www.murasoli.in ("Website"). By accessing or using the Website, you consent to the practices described in this Privacy Policy.</p><h4 _ngcontent-dwv-c135="" class="policy" style="font-weight: bold;">Information we collect as you use our services</h4><p _ngcontent-dwv-c135="" class="policy">Protecting your privacy is important to us. So, we do not collect any PII from you when you download our Android Applications / iOS Applications. To be specific, we do not require the consumers to get registered before downloading the application and we don’t track of the consumer’s visits of our app, we don’t have a Server to store such personal identifiable information (PII).</p><h4 _ngcontent-dwv-c135="" class="policy" style="font-weight: bold;">Protection (Safety and Security)</h4><p _ngcontent-dwv-c135="" class="policy">Protecting your privacy is important to us. We are very concerned about safeguarding the confidentially of your information and We make every attempt to protect your location information by using HTTPS protocol, TLS and by using technical and administrative security to reduce the risk of unauthorized data access, data loss , misuse and alteration of the information under our control. We offer the use of a secure server. Once your information is in our possession we adhere to strict security guidelines, protecting it against unauthorized access. Use it safely and securely.</p><h4 _ngcontent-dwv-c135="" class="policy" style="font-weight: bold;">Cookies and Tracking Technologies</h4><p _ngcontent-dwv-c135="" class="policy">The Website may use cookies and similar tracking technologies to enhance your browsing experience, analyze website usage, and improve our services. You can manage your cookie preferences through your browser settings.</p><p _ngcontent-dwv-c135="" class="policy">We may also use third-party analytics services that employ cookies to collect information about your use of the Websites.</p><h4 _ngcontent-dwv-c135="" class="policy" style="font-weight: bold;">Updates to the Privacy Policy</h4><p _ngcontent-dwv-c135="" class="policy">We may update this Privacy Policy from time to time to reflect changes in our practices or for other operational, legal, or regulatory reasons. The updated Privacy Policy will be posted on the Website with the "Last updated" date.</p><h4 _ngcontent-dwv-c135="" class="policy" style="font-weight: bold;">Withdrawal of consent and Permission</h4><p _ngcontent-dwv-c135="" class="policy">You may withdraw your consent to submit any or decline to provide any permission; we might not able to provide the services to you. You may withdraw your consent by sending an email to us via our official email ID</p>
                  """,
              )
            ],
          ),
        ),
      ),
    );
  }
}
