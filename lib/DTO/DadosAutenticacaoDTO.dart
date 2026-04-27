class DadosAutenticacaoDTO {
  String email;
  String senha;

  DadosAutenticacaoDTO({
    required this.email,
    required this.senha,
  });


  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "senha": senha,
    };
  }
}