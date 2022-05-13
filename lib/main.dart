import 'package:blog_app/Provider/providerstate.dart';
import 'package:blog_app/constants/colors_constants.dart';
import 'package:blog_app/context/global_context.dart';
import 'package:blog_app/screens/article_screen.dart';
import 'package:blog_app/screens/logIn_screen.dart';
import 'package:blog_app/screens/register_screen.dart';
import 'package:blog_app/screens/tab_screen.dart';
import 'package:blog_app/services/app_service.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final GlobalKey<NavigatorState> _ctx = GlobalKey<NavigatorState>();
    final AppService _appService = AppService();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState(appService: _appService))
      ],
      child: MaterialApp(
        navigatorKey: NavigationService.navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.buttonWhiteBg,
          foregroundColor: AppColors.borderColor,
        )),
        routes: {
          '/': (ctx) => LoginScreen(
                appService: _appService,
              ),
          LoginScreen.routeName: (ctx) => LoginScreen(
                appService: _appService,
              ),
          RegisterScreen.routeName: (ctx) => RegisterScreen(
                appService: _appService,
              ),
          TabScreen.routename: (ctx) => const TabScreen(),
        },
      ),
    );
  }
}
