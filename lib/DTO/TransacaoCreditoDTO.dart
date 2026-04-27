class TransacaoCreditoDTO {
  double valorRecarga;
  DateTime dataInicio;

  TransacaoCreditoDTO({
    required this.valorRecarga,
    required this.dataInicio
});

  factory TransacaoCreditoDTO.fromJson(Map<String, dynamic> json) {
    return TransacaoCreditoDTO(
      valorRecarga: json['valorRecarga'],
      dataInicio: DateTime.parse(json['dataInicio']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "valorRecarga": valorRecarga,
      "dataInicio": dataInicio
    };
  }
}