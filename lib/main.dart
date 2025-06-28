import 'package:dothi/colors/tema.dart';
import 'package:dothi/pages/cart.dart';
import 'package:dothi/pages/favorites.dart';
import 'package:dothi/pages/home.dart';
import 'package:dothi/pages/page_sushis.dart';
import 'package:dothi/pages/profile.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dothi Sushi',
      debugShowCheckedModeBanner: false,
      theme: dothiSushi,
      routes: {
        '/': (context) => const HomePage(),
        '/sushis': (context) => SushiListScreen(),
        '/favorites': (context) => const Favorites(),
        '/cart': (context) => const Cart(),
        '/profile': (context) => const Profile(),
      },
    );
  }
}
