import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:murasoli_ios/model/NewsModel.dart';
import 'package:murasoli_ios/view/about/about.dart';
import 'package:murasoli_ios/view/bottombar/bottombar.dart';
import 'package:murasoli_ios/view/news/news_details.dart';
import 'package:murasoli_ios/view/splash/splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:go_router/go_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final GoRouter _router = GoRouter(
    initialLocation: "/",
    debugLogDiagnostics: true,
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const SplashScreen();
        },
        // routes: <RouteBase>[

        // ],
      ),
      GoRoute(
        path: '/home',
        builder: (BuildContext context, GoRouterState state) {
          return BottomBar(index: 0);
        },
      ),
      GoRoute(
        path: '/about',
        builder: (context, state) {
          //  final query = state.queryParams['storyid']!; // may be null
          return About();
        },
      ),
      // GoRoute(
      //   path: '/home/newscontent',
      //   name: "newscontent",
      //   builder: (context, state) {
      //     final query = state.uri.queryParameters['storyid']!; // may be null
      //     return NewsDetails(
      //       stroryid: int.parse(query),
      //     );
      //   },
      // ),
    ],
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 800),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp.router(
            title: 'முரசொலி',
            debugShowCheckedModeBanner: false,
            routerConfig: _router,
            theme: ThemeData(

                //   primarySwatch:  const Color.fromRGBO(255, 44, 23, 1),
                fontFamily: GoogleFonts.roboto().fontFamily,
                primaryColor: Color.fromRGBO(255, 44, 23, 1),
                appBarTheme: AppBarTheme(backgroundColor: Colors.white),
                //   useMaterial3: true,
                pageTransitionsTheme: PageTransitionsTheme(builders: {
                  TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                  TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                })),
            // home: const SplashScreen(),
          );
        });
  }
}
