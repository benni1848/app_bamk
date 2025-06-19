import 'package:app_bamk/application/bloc/bloc/auth_bloc.dart';
import 'package:app_bamk/presentation/auth_gate/auth_gate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_bamk/api/services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env"); //.env im Projekt-Root abgelegt //  <------------- Emulator testing
  final apiUrl = dotenv.env['API_URL'] ?? 'http://localhost:3000';
  print("Geladene API-URL aus .env: $apiUrl");
  final authService = AuthService(); //Instanz anlegen

/*void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/.env"); // <--------------Physical Testing
  print("API aus assets/.env: ${dotenv.env['API_BASE_URL']}");
  final apiUrl = dotenv.env['API_URL'] ?? '192.168.2.216:3000';
  print("Geladene API-URL aus assets/.env: $apiUrl");
  final authService = AuthService(); //Instanz anlegen
*/
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
      home: const AuthGate(),
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
