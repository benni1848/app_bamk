
import 'package:app_bamk/presentation/film_page/film_page.dart';
import 'package:app_bamk/presentation/login_page/login_page.dart';
import 'package:app_bamk/presentation/registration_page/registration_page.dart';
import 'package:app_bamk/presentation/search_page/search_page.dart';
import 'package:app_bamk/presentation/ticketView_page/ticketView_page.dart';
import 'package:app_bamk/presentation/userProfile_page/userProfile_page.dart';
import 'package:flutter/material.dart';
import 'package:app_bamk/root.dart' as app;


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: app.RootWidget(), //BottomNavigationBar hinzufügen
      title: "BAMK Rating",
      
      /*initialRoute: "/", //Anpassen, um direkt in die Ansicht zu starten
      routes: {
        "/": (context) => const LoginPage(),
        "/registration": (context) => const RegistrationPage(),
        "/ticket": (context) => const TicketView(),
        "/user": (context) => const UserProfile(),
        "/search": (context) => const SearchPage(),
        "/film": (context) => const FilmPage(),
      },*/
    );
  }
}
