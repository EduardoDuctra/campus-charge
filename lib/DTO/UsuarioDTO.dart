
class UsuarioDTO {

  String nome;
  String cpf;
  String telefone;
  String email;
  String senha;

  UsuarioDTO({
    required this.nome,
    required this.cpf,
    required this.telefone,
    required this.email,
    required this.senha,
});

  Map<String, dynamic> toJson() {

    return {
      "nome": nome,
      "cpf": cpf,
      "telefone": telefone,
      "email": email,
      "senha": senha,
    };
  }

}