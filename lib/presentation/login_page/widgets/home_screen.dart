import 'package:flutter/material.dart';
import 'package:app_bamk/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<dynamic>> filmData;
  String? token;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        token = ModalRoute.of(context)!.settings.arguments as String?;
      });

      if (token == null) {
        Navigator.pushReplacementNamed(context, "/login");
      } else {
        filmData = ApiService.fetchData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (token == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: Text("Gesicherte Seite")),
      body: FutureBuilder<List<dynamic>>(
        future: filmData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Fehler: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Keine Filme gefunden!"));
          } else {
            var filme = snapshot.data!;
            return ListView.builder(
              itemCount: filme.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filme[index]["titel"]),
                  subtitle: Text("Genre: ${filme[index]["genre"].join(", ")}"),
                );
              },
            );
          }
        },
      ),
    );
  }
}
