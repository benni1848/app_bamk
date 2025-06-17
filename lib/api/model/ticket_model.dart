class TicketModel {
  final String id;
  final String user;
  final String message;
  final String status;
  final DateTime timestamp;

  TicketModel({
    required this.id,
    required this.user,
    required this.message,
    required this.status,
    required this.timestamp,
  });

  factory TicketModel.fromModel(TicketModel? model) {
    if (model == null) {
      print("Fehler: TicketModel ist null");
      return TicketModel(
        id: '',
        user: 'Unbekannt',
        message: 'Keine Nachricht verfügbar',
        status: 'offen',
        timestamp: DateTime.now(),
      );
    }

    return TicketModel(
      id: model.id,
      user: model.user,
      message: model.message,
      status: model.status,
      timestamp: model.timestamp,
    );
  }

  static fromJson(json) {}
}
