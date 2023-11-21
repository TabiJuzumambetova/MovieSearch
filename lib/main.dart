import 'package:flutter/material.dart';
import 'package:movie_search/screen/main_page.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      
      debugShowCheckedModeBanner: false,
      home: MainPage(
        
      ),
    );
  }
}