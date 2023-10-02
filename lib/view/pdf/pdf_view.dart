import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:open_file/open_file.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../components/check_permission.dart';
import '../../components/directory_path.dart';
import 'package:path/path.dart' as Path;

import '../bottombar/bottombar.dart';

class PdfView extends StatefulWidget {
  const PdfView({super.key, required this.pdf});
  final String pdf;
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<PdfView> {
  late PdfViewerController _pdfViewerController;

  @override
  void initState() {
    _pdfViewerController = PdfViewerController();

    super.initState();
    checkPermission();
    setState(() {
      fileName = Path.basename(
           widget.pdf);
    });
  }

  bool isPermission = false;
  var checkAllPermissions = CheckPermission();

  checkPermission() async {
    var permission = await checkAllPermissions.isStoragePermission();
    if (permission) {
      setState(() {
        isPermission = true;
      });
    }
  }

  bool dowloading = false;
  bool fileExists = false;
  double progress = 0;
  String fileName = "";
  late String filePath;
  late CancelToken cancelToken;
  var getPathFile = DirectoryPath();
  startDownload() async {
    cancelToken = CancelToken();
    var storePath = await getPathFile.getPath();
    filePath = '$storePath/$fileName';
    setState(() {
      dowloading = true;
      progress = 0;
    });

    try {
      Response response = await Dio().download(
           widget.pdf,
          filePath, onReceiveProgress: (count, total) {
        setState(() {
          progress = (count / total);
        });
      }, cancelToken: cancelToken);
      setState(() {
        dowloading = false;
        fileExists = true;
      });
      // File file = File(filePath);
      // var raf = file.openSync(mode: FileMode.write);
      // // response.data is List<int> type
      // // U//int8List bytes = await file.readAsBytes();
      // raf.writeFromSync(response.data);

      // await raf.close();
      OpenFile.open(filePath);
    } catch (e) {
      print(e);
      setState(() {
        dowloading = false;
      });
    }
  }

  cancelDownload() {
    cancelToken.cancel();
    setState(() {
      dowloading = false;
    });
  }

  Future<bool> _onWillPop() async {
     context.pushReplacement("/home");
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          elevation: 1,
          leading: GestureDetector(
              onTap: () {
                _onWillPop();
              },
              child: Icon(Icons.arrow_back)),
          title:
              Image.asset('assets/splash.gif', height: 40.h, fit: BoxFit.cover),
        
        // actions: [
        //   Row(
        //     children: [
        //       InkWell(
        //         onTap: () {},
        //         child: IconButton(
        //             onPressed: () {
        //               fileExists && dowloading == false
        //                   ? OpenFile.open(filePath)
        //                   : startDownload();
        //             },
        //             icon: fileExists
        //                 ? const Icon(
        //                     Icons.save,
        //                     color: Colors.green,
        //                   )
        //                 : dowloading
        //                     ? Stack(
        //                         alignment: Alignment.center,
        //                         children: [
        //                           CircularProgressIndicator(
        //                             value: progress,
        //                             strokeWidth: 3,
        //                             backgroundColor: Colors.grey,
        //                             valueColor:
        //                                 const AlwaysStoppedAnimation<Color>(
        //                                     Colors.blue),
        //                           ),
        //                           Text(
        //                             "${(progress * 100).toStringAsFixed(2)}",
        //                             style: TextStyle(
        //                                 fontSize: 10.sp,
        //                                 color: Colors.blue),
        //                           )
        //                         ],
        //                       )
        //                     : Icon(
        //                         Icons.download,
        //                         size: 20.sp,
        //                       )),
        //       ),
        //     ],
        //   ),
        //],
        ),
        body: SfPdfViewer.network(
          widget.pdf,
          controller: _pdfViewerController,
          canShowPaginationDialog: true,
          onDocumentLoaded: (details) {
            print("onDocumentLoaded");
          },
          onPageChanged: (details) {},
        ),
      ),
    );
  }
}
