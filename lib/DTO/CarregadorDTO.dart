class CarregadorDTO {
  String idCarregador;
  String statusCarregador;
  String? cidade;
  String? descricao;


  CarregadorDTO({
    required this.idCarregador,
    required this.statusCarregador,
    this.cidade,
    this.descricao
  });


  factory CarregadorDTO.fromJson(Map<String, dynamic> json) {
    return CarregadorDTO(
      idCarregador: json['idCarregador'],
      statusCarregador: json['statusCarregador'],
      cidade: json['cidade'],
      descricao:json['descricao'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "idCarregador": idCarregador,
      "statusCarregador": statusCarregador,
      "cidade": cidade,
      "descricao": descricao

    };
  }
}