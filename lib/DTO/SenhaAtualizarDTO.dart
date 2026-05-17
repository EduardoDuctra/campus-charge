class SenhaAtualizarDTO{
  final String senha;

  SenhaAtualizarDTO({
    required this.senha,
  });

  Map<String, dynamic> toJson() {
    return {
      "senha": senha
    };
  }

}