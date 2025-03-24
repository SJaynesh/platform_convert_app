import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_convert_app/controllers/homepage_controller.dart';
import 'package:platform_convert_app/controllers/switch_controller.dart';
import 'package:platform_convert_app/views/screens/home_page.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // log("Android Platform : ${Platform.isAndroid}");
    // log("iOS Platform : ${Platform.isIOS}");
    // log("MacOS Platform : ${Platform.isMacOS}");
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SwitchController(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomePageController(),
        ),
      ],
      builder: (context, _) =>
          (!Provider.of<SwitchController>(context, listen: true).isIOS)
              ? MaterialApp(
                  debugShowCheckedModeBanner: false,
                  routes: {
                    '/': (context) => const HomePage(),
                  },
                )
              : CupertinoApp(
                  debugShowCheckedModeBanner: false,
                  routes: {
                    '/': (context) => const HomePage(),
                  },
                ),
    );
  }
}
