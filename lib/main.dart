import 'package:flutter/material.dart';
import 'package:semifinal/homepage.dart';

void main() {
     runApp(MaterialApp(
       debugShowCheckedModeBanner: false,
       theme: ThemeData(
         primarySwatch: Colors.lightGreen
       ),
       title: 'Semi Finals',
       home: const HomePage(),
     )
     );
}