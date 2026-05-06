class RemoteStopDTO {
  String charger_id;
  int transaction_id;

  RemoteStopDTO({
    required this.charger_id,
    required this.transaction_id,
  });

  Map<String, dynamic> toJson() {
    return {
      "charger_id": charger_id,
      "transaction_id": transaction_id
    };
  }
}