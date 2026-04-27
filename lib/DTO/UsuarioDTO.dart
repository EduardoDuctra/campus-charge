class UsuarioDTO {

  String? nome;
  String? cpf;
  String? telefone;
  String? email;
  String? fotoUrl;
  String? senha;


  UsuarioDTO({
    this.nome,
    this.cpf,
    this.telefone,
    this.email,
    this.fotoUrl,
    this.senha,
  });

  factory UsuarioDTO.fromJson(Map<String, dynamic> json) {
    return UsuarioDTO(
      nome: json['nome'],
      cpf: json['cpf'],
      telefone: json['telefone'],
      email: json['email'],
      fotoUrl: json['fotoUrl'],
      senha: json['senha'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "nome": nome,
      "cpf": cpf,
      "telefone": telefone,
      "email": email,
      "fotoUrl": fotoUrl,
      "senha": senha,
    };
  }
}