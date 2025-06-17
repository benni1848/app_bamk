import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_bamk/api/model/ticket_model.dart';
import 'package:app_bamk/domain/entities/ticket_entity.dart';

class TicketService {
  static const String baseUrl = 'http://192.168.2.216:3000/tickets';

  // Neues Ticket senden mit Validierung
  static Future<void> sendTicket(String user, String message) async {
    // Überprüfung: Falls eines der Felder leer ist, wird das Ticket nicht gesendet
    if (user.isEmpty || message.isEmpty) {
      throw Exception("Benutzername und Nachricht dürfen nicht leer sein!");
    }

    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"user": user, "message": message}),
      );

      if (response.statusCode == 200) {
        print("Ticket erfolgreich gesendet!");
      } else {
        throw Exception("Fehler beim Senden des Tickets: ${response.body}");
      }
    } catch (e) {
      print("Netzwerkfehler: $e");
    }
  }

  // **Tickets abrufen & zu `TicketEntity` konvertieren**
  static Future<List> fetchTickets() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);

        return jsonData
            .map((json) =>
                TicketModel.fromJson(json)) // JSON zu `TicketModel` umwandeln
            .map((model) => TicketEntity.fromModel(
                model)) // `TicketModel` zu `TicketEntity` umwandeln
            .toList();
      } else {
        throw Exception("Fehler beim Abrufen der Tickets: ${response.body}");
      }
    } catch (e) {
      print("Netzwerkfehler beim Abrufen der Tickets: $e");
      return []; // 🔹 Gibt eine **leere Liste** zurück, um `null`-Fehler zu vermeiden
    }
  }
}
