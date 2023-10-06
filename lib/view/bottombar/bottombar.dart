import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:murasoli_ios/view/about/about.dart';
import 'package:murasoli_ios/view/drawer/drawer.dart';
import 'package:murasoli_ios/view/search/search.dart';

import '../edition/edition_category.dart';
import '../editorial/editorial.dart';
import '../epaper/epaper.dart';
import '../home/homepage.dart';
import '../news/news_category.dart';
import '../news/news_list.dart';
import 'component/bottomWidget.dart';

class BottomBar extends StatefulWidget {
  BottomBar({super.key, required this.index});
  int index;
  @override
  State<BottomBar> createState() => _nameState();
}

class _nameState extends State<BottomBar> {
  List<Widget> pages = [
    const Homepage(),
    const Editorial(),
    NewsCat(),
   // NewsList(srno: 0),
    EditionCat(),
    Text("data")
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(index2: widget.index),
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        elevation: 1,
        title:
            InkWell(
              onTap: () {
                if(widget.index!=0){
                   Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>  BottomBar(index: 0,)),
            (Route<dynamic> route) => false,
          );
                }
              },
              child: Image.asset('assets/splash.gif', height: 40.h, fit: BoxFit.cover)),
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
              InkWell(
                onTap: () {
                Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>  About()),
          
          );
                },
                child: Container(
                  margin: EdgeInsets.only(
                    right: 10.w,
                  ),
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: Color(0xFFF1F2F6),
                      borderRadius: BorderRadius.circular(12)),
                  child: Icon(
                    Icons.info_outline,
                    size: 18.sp,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          )
        ],
      ),

      body: pages[widget.index],
      // body: IndexedStack(
      //   index: index,
      //   children: pages,
      // ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.3),
              blurRadius: 1,
            ),
          ],
        ),
        child: _buildBottomBar(),
      ),
    );
  }

  final _inactiveColor = Colors.grey;
  Widget _buildBottomBar() {
    return CustomAnimatedBottomBar(
      containerHeight: 50.h,
      backgroundColor: Colors.white,
      selectedIndex: widget.index,
      showElevation: true,
      itemCornerRadius: 50,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() {
        if (index == 4) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Epaper(
              url: "https://epaper.murasoli.in/",
            ),
          ));
          return;
        }

        widget.index = index;
      }),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: const Icon(Icons.home),
          title: const Text('முகப்பு'),
          activeColor: Color.fromRGBO(255, 44, 23, 1),
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.start,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.edit),
          title: const Text('தலையங்கம்'),
          activeColor: Color.fromRGBO(255, 44, 23, 1),
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.start,
        ),
        BottomNavyBarItem(
          icon: const Icon(CupertinoIcons.globe),
          title: const Text(
            'செய்திகள் ',
          ),
          activeColor: Color.fromRGBO(255, 44, 23, 1),
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.start,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.print),
          title: const Text('பதிப்பு'),
          activeColor: Color.fromRGBO(255, 44, 23, 1),
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.start,
        ),
        BottomNavyBarItem(
          icon: SvgPicture.asset(
            "assets/svg/epaper.svg",
            color: _inactiveColor,
          ),
          title: const Text('இ–பேப்பர்'),
          activeColor: Color.fromRGBO(255, 44, 23, 1),
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.start,
        ),
      ],
    );
  }
}
