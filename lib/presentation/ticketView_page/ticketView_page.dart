import 'package:app_bamk/presentation/ticketView_page/widgets/ticketView_page_form.dart';
import 'package:flutter/material.dart';

class TicketView extends StatelessWidget {
  const TicketView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(backgroundColor: Color(0xff1a1a1a),body: TicketViewForm());
  }
}