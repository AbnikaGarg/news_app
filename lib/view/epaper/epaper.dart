import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../bottombar/bottombar.dart';

class Epaper extends StatefulWidget {
  const Epaper({Key? key, required this.url}) : super(key: key);
  final String url;
  @override
  State<Epaper> createState() => _MainPageState();
}

class _MainPageState extends State<Epaper> {
  late WebViewController _controller; // Declare the WebViewController
  bool _isLoading = true; // To track loading state

  bool showFloat = false;
  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    loadurl();
    // Initialize the WebViewController and load the URL
  }

  loadurl() {
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
      WebKitWebViewController(params)
          .setAllowsBackForwardNavigationGestures(true);
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }
    WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);

    controller
      ..enableZoom(true)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            const LoadingPage();
            // Update loading bar.
          },
          onPageStarted: (String url) {
            if (this.mounted) {
              setState(() {
                if (widget.url.toString() == "https://mstamilnews.in") {
                  _isLoading = true; // Show loader when page starts loading
                }
              });
            }
          },
          onPageFinished: (String url) {
            if (this.mounted) {
              setState(() {
                _isLoading = false; // Hide loader when page finishes loading
              });
            }
          },
          onNavigationRequest: (NavigationRequest request) async {
            print("launchaa" + request.url);
            if (request.url.contains("mailto:") ||
                request.url.contains("t.me") ||
                request.url.contains("www.youtube.com/@murasoli180") ||
                request.url.contains("www.facebook.com") ||
                request.url.contains("www.instagram.com") ||
                request.url.contains("whatsapp") ||
                request.url.contains("twitter.com")) {
              launch(request.url);
              // canLaunchUrl(Uri(scheme: 'mailto', path: 'murasolidaily@gmail.com'))
              //     .then((bool result) {
              //   launchUrl(
              //     Uri(scheme: 'mailto', path: 'murasolidaily@gmail.com'),
              //     mode: LaunchMode.platformDefault,
              //   );
              // });
              return NavigationDecision.prevent;
            } else if (request.url.contains("epaper.murasoli.in") ||
            
                request.url.contains("malar")|| request.url.contains("risingsun")) {
              if (this.mounted) {
                setState(() {
                  showFloat = true;
                });
              }
              return NavigationDecision.navigate;
            } else if (request.url.startsWith('tel:') ||
                request.url.startsWith('whatsapp:') ||
                request.url.startsWith('fb:') ||
                request.url.startsWith('tg:')) {
              if (await canLaunch(request.url)) {
                await launch(request.url);
              }
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url.toString()));
    _controller = controller;
  }

  DateTime? lastBackPressedTime;

  @override
  Widget build(BuildContext context) {
    return buildWillPopScope();
  }

  int index = 0;
  bool onWillPop = false;
  late DateTime currentBackPressTime;
  buildWillPopScope() {
    return WillPopScope(
      onWillPop: () async {
        if (await _controller.canGoBack()) {
          _controller.goBack();

          return false;
        }
        // Stay App
        else {
          return true;
        }

        // if (await controller.canGoBack()) {
        //   print("onwill goback");
        //   controller.goBack();
        //   return Future.value(true);
        // } else {
        //   print("onwill not");

        //   return Future.value(false);
        // }
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
        floatingActionButton: FloatingActionButton.small(
          shape: const CircleBorder(),
          // isExtended: true,
          child: Icon(
            Icons.home,
            color: Colors.white,
          ),
          backgroundColor: Colors.red,
          onPressed: () {
            if (this.mounted) {
              setState(() {
                showFloat = false;
                context.pushReplacement("/home");
                // Navigator.pushAndRemoveUntil(
                //     context,
                //     MaterialPageRoute(
                //         builder: (BuildContext context) => BottomBar(index: 0)),
                //     ModalRoute.withName(
                //         '/') // Replace this with your root screen's route name (usually '/')
                //     );
              });
            }
          },
        ),
        body: Stack(
          children: [
            SafeArea(
              child: WebViewWidget(
                controller: _controller,
              ),
            ),
            if (_isLoading)
              const Center(
                child: LoadingPage(), // Loader widget
              ),
          ],
        ),
      ),
    );
  }
}

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          alignment: Alignment.center,
          'assets/splash.gif',
          height: 50,
        ),
      ),
      body: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          color: Colors.white,
        ),
      ),
    );
  }
}

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.red,
        ),
      ),
    );
  }
}
