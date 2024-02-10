

import 'package:flutter/material.dart';

class AppTheme  {

  ThemeData getTheme() {

    const seedColor = Colors.deepPurple;
    
    return ThemeData(
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Color(0xff201E28)
      ),
      scaffoldBackgroundColor: const Color(0xff201E28),
      colorSchemeSeed: seedColor,
      iconTheme: IconThemeData(
        color: Colors.white.withOpacity(0.4)
      ),
      listTileTheme: const ListTileThemeData( // color icons
        iconColor: seedColor
      ),

    );
  }
}