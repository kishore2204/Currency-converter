import 'package:flutter/material.dart';
import 'package:practice_app/selection_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Currency converter',
    theme: ThemeData(
      textSelectionTheme: const TextSelectionThemeData(
        selectionHandleColor: Colors.teal,
      ),
    ),
    //this calls selection page
    home: const SelectionPage(),
  ));
}
