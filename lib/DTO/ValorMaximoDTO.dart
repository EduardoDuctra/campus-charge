class ValorMaximoDTO {
  double valorMaximo;

  ValorMaximoDTO({
    required this.valorMaximo,
  });

  Map<String, dynamic> toJson() {
    return {
      "valorMaximo": valorMaximo
    };
  }

}