class TransacaoAtivaDTO {
  int id;
  int idTransacao;
  String statusTransacao;
  double valorRecarga;
  double valorMaximo;
  DateTime dataInicio;
  double socAtual;
  int connectorId;
  String idCarregador;

  TransacaoAtivaDTO({
    required this.id,
    required this.idTransacao,
    required this.statusTransacao,
    required this.valorRecarga,
    required this.valorMaximo,
    required this.dataInicio,
    required this.socAtual,
    required this.connectorId,
    required this.idCarregador,
  });

  factory TransacaoAtivaDTO.fromJson(Map<String, dynamic> json) {
    return TransacaoAtivaDTO(
      id: json["id"],
      idTransacao: int.parse(json["idTransacao"].toString()),
      statusTransacao: json["statusTransacao"],
      valorRecarga: (json["valorRecarga"] as num).toDouble(),
      valorMaximo: json["valorMaximo"] != null ? (json["valorMaximo"] as num).toDouble() : 0.0,
      dataInicio: DateTime.parse(json["dataInicio"]),
      socAtual: (json["socAtual"] as num).toDouble(),
      connectorId: json["connectorId"],
      idCarregador: json["idCarregador"],
    );
  }
}