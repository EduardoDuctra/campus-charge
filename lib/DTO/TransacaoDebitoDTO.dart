class TransacaoDebitoDTO {
  double valorRecarga;
  double recargaKwh;
  DateTime dataInicio;
  String modelo;

  TransacaoDebitoDTO({
    required this.valorRecarga,
    required this.recargaKwh,
    required this.dataInicio,
    required this.modelo
});

  factory TransacaoDebitoDTO.fromJson(Map<String, dynamic> json) {
    return TransacaoDebitoDTO(
      valorRecarga: (json['valorRecarga'] as num).toDouble(),
      recargaKwh: (json['recargaKwh'] as num).toDouble(),
      dataInicio: DateTime.parse(json['dataInicio']),
      modelo: json['modelo'],
    );
  }
}

