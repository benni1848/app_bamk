import 'package:app_bamk/application/bloc/bloc/auth_bloc.dart';
import 'package:app_bamk/presentation/login_page/login_page.dart';
import 'package:app_bamk/presentation/registration_page/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_bamk/api/services/auth_service.dart';
import 'package:app_bamk/root.dart' as app;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/.env");

  final authService = AuthService(); //Instanz anlegen

  runApp(
    BlocProvider(
      create: (_) => AuthBloc(authService: authService), //Bloc bereitstellen
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: app.RootWidget(), //BottomNavigationBar hinzufügen
      home: LoginPage(),
      // home: RegistrationPage(),
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
