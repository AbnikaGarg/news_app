import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:murasoli_ios/model/EditorialModel.dart';
import 'package:murasoli_ios/service/get_editorial.dart';
import 'package:flutter_html/flutter_html.dart';

class Editorial extends StatefulWidget {
  const Editorial({super.key});

  @override
  State<Editorial> createState() => _nameState();
}

class _nameState extends State<Editorial> {
  String newsdate = "";
  @override
  void initState() {
    super.initState();
    newsdate = DateFormat("yyyy-MM-dd").format(DateTime.now()).toString();
    getEditorialList();
    setState(() {});
  }

  selectDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData(
                primarySwatch: Colors.red,
                splashColor: Theme.of(context).primaryColor,
                textTheme: TextTheme(
                  subtitle1: TextStyle(color: Colors.black),
                  button: TextStyle(color: Colors.black),
                )),
            child: child ?? Text(""),
          );
        },
        initialDate: DateTime.now(),
        firstDate: DateTime(
            2000), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      print(
          formattedDate); //formatted date output using intl package =>  2021-03-16
      //you can implement different kind of Date Format here according to your requirement

      newsdate = formattedDate;
      editorialdata = null;
      setState(() {});
      getEditorialList();
    } else {
      print("Date is not selected");
    }
  }

  List<EditorialModel>? editorialdata;
  void getEditorialList() async {
    final service = ApiFetchEditorial();

    service.apiFetchEditorial(newsdate).then((value) {
      if (value != null) {
        editorialdata = value;
        if (mounted) setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  selectDate();
                },
                child: Container(
                  margin: EdgeInsets.only(right: 12.w),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Color(0xFFF1F2F6),
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      Text(
                        "$newsdate ",
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      Icon(
                        Icons.calendar_month_sharp,
                        size: 16.sp,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Image.asset(
            "assets/editorial.png",
            fit: BoxFit.contain,
            height: 350.h,
            width: double.infinity,
            //  color: Color.fromARGB(102, 48, 47, 47),
            // colorBlendMode: BlendMode.darken,
          ),
          SizedBox(
            height: 20.h,
          ),
          if (editorialdata != null)
            if (editorialdata!.first.table!.length != 0)
              Column(
                children: [
                  Text(
                    "${editorialdata!.first.table![0].gNewstitle}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 16.sp),
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 6.w, right: 6.w),
                      child: Html(
                        style: {
                          "body": Style(
                              lineHeight: const LineHeight(1.4), wordSpacing: 2)
                        },
                        data: """
              ${editorialdata!.first.table![0].gNewsdetails}
                """,
                      ))
                ],
              )
            else
              Text(
                "",
              )
          else
            Padding(
              padding: const EdgeInsets.all(40),
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            )
        ],
      ),
    );
  }
}
