import 'package:flitter/repositories/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flitter/pages/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getDatabase();

  runApp(const MaterialApp(home: MainPage()));
}
