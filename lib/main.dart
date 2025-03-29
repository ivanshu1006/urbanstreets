import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frappe_flutter_app/providers/category_provider.dart';
import 'package:frappe_flutter_app/providers/location_provider.dart';
import 'package:frappe_flutter_app/providers/photo_provider.dart';
import 'package:frappe_flutter_app/providers/post_provider.dart';
import 'package:frappe_flutter_app/providers/profile_provider.dart';
import 'package:frappe_flutter_app/providers/stories_archieve_provider.dart';
import 'package:frappe_flutter_app/providers/story_provider.dart';
import 'package:frappe_flutter_app/providers/theme_provider.dart';
import 'package:frappe_flutter_app/theme/theme.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'router.dart';
import 'services/connectivity_service.dart';
import 'widgets/snack_bar.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ConnectivityService()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => StoryProvider()),
        ChangeNotifierProvider(create: (_) => PostProvider()),
        ChangeNotifierProvider(create: (_) => PhotoProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => StoriesArchiveProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: SnackbarGlobal.key,
        theme: appTheme,
        routerConfig: router,
      ),
    );
  }
}
