class ConectorDTO {
  int id;
  int connectorIdNoCarregador;
  String tipo;
  bool disponivelUso;
  double valorEnergia;
  String nomeConector;
  String idCarregador;

  ConectorDTO({
    required this.id,
    required this.connectorIdNoCarregador,
    required this.tipo,
    required this.disponivelUso,
    required this.valorEnergia,
    required this.nomeConector,
    required this.idCarregador,
  });

  factory ConectorDTO.fromJson(Map<String, dynamic> json) {
    return ConectorDTO(
      id: json['id'],
      connectorIdNoCarregador: json['connectorIdNoCarregador'],
      tipo: json['tipo'],
      disponivelUso: json['disponivelUso'],
      valorEnergia: json['valorEnergia'],
      nomeConector: json['nomeConector'],
      idCarregador: json['idCarregador'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "connectorIdNoCarregador": connectorIdNoCarregador,
      "tipo": tipo,
      "disponivelUso": disponivelUso,
      "valorEnergia": valorEnergia,
      "nomeConector": nomeConector,
      "idCarregador": idCarregador,

    };
  }
}