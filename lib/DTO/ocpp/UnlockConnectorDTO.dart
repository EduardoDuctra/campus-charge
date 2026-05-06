class UnlockConnectorDTO {
  String charger_id;
  int connector_id;

  UnlockConnectorDTO({
    required this.charger_id,
    required this.connector_id,
  });

  Map<String, dynamic> toJson() {
    return {
      "charger_id": charger_id,
      "connector_id": connector_id
    };
  }
}