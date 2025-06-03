import 'package:app_bamk/presentation/login_page/login_page.dart';
import 'package:app_bamk/presentation/registration_page/registration_page.dart';
import 'package:app_bamk/presentation/search_page/search_page.dart';
import 'package:app_bamk/presentation/ticketView_page/ticketView_page.dart';
import 'package:app_bamk/presentation/userProfile_page/userProfile_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "BAMK Rating",
      initialRoute: "/search", //Anpassen, um direkt in die Ansicht zu starten
      routes: {
        "/": (context) => const LoginPage(),
        "/registration": (context) => const RegistrationPage(),
        "/ticket": (context) => const TicketView(),
        "/user": (context) => const UserProfile(),
        "/search":(context) => const SearchPage(),
      },
    );
  }
}
