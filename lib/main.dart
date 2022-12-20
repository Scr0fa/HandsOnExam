import 'package:flutter/material.dart';
import 'homepage.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark(),
    title: "Hands On Exam",
    home: const Homepage(),
  ));
}