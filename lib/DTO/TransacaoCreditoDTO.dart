
class TransacaoCreditoDTO {
  double valorRecarga;
  DateTime dataInicio;
  int? id;

  TransacaoCreditoDTO({
    required this.valorRecarga,
    required this.dataInicio,
    this.id
});

  factory TransacaoCreditoDTO.fromJson(Map<String, dynamic> json) {
    return TransacaoCreditoDTO(
      valorRecarga: (json["valorRecarga"] as num).toDouble(),
      dataInicio: DateTime.parse(json['dataInicio']),
      id: json["id"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "valorRecarga": valorRecarga,
      "dataInicio": dataInicio.toIso8601String(),
      "id": id
    };
  }
}