import 'package:ayushman_bhava/utils/theme_data.dart';
import 'package:ayushman_bhava/view/ui/splash/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controller/service/provider/provideroperation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderOperation(),
      child: MaterialApp(
        title: 'Ayushman Bhava',
        debugShowCheckedModeBanner: false,
        theme: MyTheme.theme,
        home: const SplashScreen(),
      ),
    );
  }
}

