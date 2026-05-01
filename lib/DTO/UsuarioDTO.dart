

class UsuarioDTO {

  int? idUsuario;
  String? nome;
  String? cpf;
  String? telefone;
  String? email;
  String? fotoUrl;
  double? saldo;
  String? senha;
  int? idVeiculoPrincipal;
  String? modeloVeiculoPrincipal;


  UsuarioDTO({
    this.idUsuario,
    this.nome,
    this.cpf,
    this.telefone,
    this.email,
    this.fotoUrl,
    this.saldo,
    this.senha,
    this.idVeiculoPrincipal,
    this.modeloVeiculoPrincipal
  });

  factory UsuarioDTO.fromJson(Map<String, dynamic> json) {
    return UsuarioDTO(
      idUsuario: json['idUsuario'],
      nome: json['nome'],
      cpf: json['cpf'],
      telefone: json['telefone'],
      email: json['email'],
      fotoUrl: json['fotoUrl'],
      saldo: json['saldo'],
      senha: json['senha'],
      idVeiculoPrincipal: json['idVeiculoPrincipal'],
      modeloVeiculoPrincipal: json['modeloVeiculoPrincipal'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "idUsuario": idUsuario,
      "nome": nome,
      "cpf": cpf,
      "telefone": telefone,
      "email": email,
      "fotoUrl": fotoUrl,
      "saldo": saldo,
      "senha": senha,
    };
  }
}