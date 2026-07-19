import 'package:flutter/material.dart';
import 'gridList.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const MaterialApp(
      home: Scaffold(body: SafeArea(child: MainScrollPage())),
    ),
  );
}
