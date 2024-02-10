import 'package:flutter/material.dart';
import 'package:music_player/config/router/app_router.dart';
import 'package:music_player/config/theme/app_theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: AppTheme().getTheme(),
      routerConfig: appRouter,

    );
  }
}