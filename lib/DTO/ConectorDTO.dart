class ConectorDTO {
  int id;
  int connectorIdNoCarregador;
  String tipo;
  bool disponivelUso;
  String nomeConector;
  String idCarregador;

  ConectorDTO({
    required this.id,
    required this.connectorIdNoCarregador,
    required this.tipo,
    required this.disponivelUso,
    required this.nomeConector,
    required this.idCarregador,
  });

  factory ConectorDTO.fromJson(Map<String, dynamic> json) {
    return ConectorDTO(
      id: json['id'],
      connectorIdNoCarregador: json['connectorIdNoCarregador'],
      tipo: json['tipo'],
      disponivelUso: json['disponivelUso'],
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
      "nomeConector": nomeConector,
      "idCarregador": idCarregador,

    };
  }
}