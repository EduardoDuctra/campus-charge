class CarregadorDTO {
  String idCarregador;
  String statusCarregador;
  String? cidade;


  CarregadorDTO({
    required this.idCarregador,
    required this.statusCarregador,
    this.cidade,
  });


  factory CarregadorDTO.fromJson(Map<String, dynamic> json) {
    return CarregadorDTO(
      idCarregador: json['idCarregador'],
      statusCarregador: json['statusCarregador'],
      cidade: json['cidade']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "idCarregador": idCarregador,
      "statusCarregador": statusCarregador,
      "cidade": cidade

    };
  }
}