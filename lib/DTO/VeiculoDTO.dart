class VeiculoDTO {

  int? idVeiculo;
  String modeloCarro;
  String nomeMarca;

  VeiculoDTO({
    this.idVeiculo,
    required this.modeloCarro,
    required this.nomeMarca
  });

  factory VeiculoDTO.fromJson(Map<String, dynamic> json) {
    return VeiculoDTO(
        idVeiculo: json['idVeiculo'],
        modeloCarro: json['modeloCarro'],
        nomeMarca: json['nomeMarca']
    );

  }

  Map<String, dynamic> toJson() {
    return {
      "modeloCarro": modeloCarro,
      "nomeMarca": nomeMarca,
    };
  }
}