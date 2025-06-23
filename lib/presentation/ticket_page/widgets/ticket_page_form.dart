import 'package:flutter/material.dart';
import 'package:app_bamk/api/services/ticket_service.dart';
import 'package:app_bamk/domain/entities/ticket_entity.dart';

class TicketsPageForm extends StatefulWidget {
  const TicketsPageForm(
      {super.key, required String userName, required TicketEntity ticket});

  @override
  _TicketsPageFormState createState() => _TicketsPageFormState();
}

class _TicketsPageFormState extends State<TicketsPageForm> {
  final TextEditingController _messageController = TextEditingController();
  List<TicketEntity> tickets = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _loadTickets();
  }

  void _loadTickets() async {
    final List fetchedTickets = await TicketService.fetchTickets();

    setState(() {
      tickets = List<TicketEntity>.from(
          fetchedTickets); //Explizite Umwandlung zu `List<TicketEntity>`

      if (tickets.isEmpty) {
        print("Keine Tickets gefunden.");
        error = "Keine Tickets vorhanden";
      }

      isLoading = false;
    });
  }

  void sendTicket() async {
    final message = _messageController.text.trim();
    if (message.isNotEmpty) {
      await TicketService.sendTicket("Benutzer", message);
      _messageController.clear();
      _loadTickets(); // Tickets neu laden nach dem Absenden
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Ticket erfolgreich gesendet!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Meine Tickets")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _messageController,
              decoration: InputDecoration(
                labelText: "Nachricht eingeben",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: sendTicket,
              child: Text("Ticket senden"),
            ),
            SizedBox(height: 20),

            //  Tickets laden & anzeigen
            isLoading
                ? CircularProgressIndicator()
                : error != null
                    ? Text(error!)
                    : Expanded(
                        child: tickets.isEmpty
                            ? Text("Keine bisherigen Tickets")
                            : ListView.builder(
                                itemCount: tickets.length,
                                itemBuilder: (context, index) {
                                  final ticket = tickets[index];
                                  return Card(
                                    child: ListTile(
                                      title: Text(ticket.message),
                                      subtitle:
                                          Text("Status: ${ticket.status}"),
                                      trailing:
                                          Text(ticket.timestamp.toString()),
                                    ),
                                  );
                                },
                              ),
                      ),
          ],
        ),
      ),
    );
  }
}
