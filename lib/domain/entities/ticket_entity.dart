import 'package:app_bamk/api/model/ticket_model.dart';

class TicketEntity {
  final String id;
  final String user;
  final String message;
  final String status;
  final DateTime timestamp;

  const TicketEntity({
    required this.id,
    required this.user,
    required this.message,
    required this.status,
    required this.timestamp,
  });

  static fromModel(TicketModel model) {}
}
