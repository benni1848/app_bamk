import 'package:app_bamk/domain/entities/ticket_entity.dart';
import 'package:app_bamk/presentation/ticket_page/widgets/ticket_page_form.dart';
import 'package:flutter/material.dart';

class TicketPage extends StatelessWidget {
  final TicketEntity ticket;
  const TicketPage({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1a1a1a),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF80B5E9),
        title: Text("Ticketübersicht"),
      ),
      body: TicketsPageForm(
        ticket: ticket,
        userName: '',
      ),
    );
  }
}
