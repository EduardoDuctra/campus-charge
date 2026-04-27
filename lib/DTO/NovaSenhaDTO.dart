class NovaSenhaDTO {
  final String email;
  final String codigo;
  final String novaSenha;

  NovaSenhaDTO({
    required this.email,
    required this.codigo,
    required this.novaSenha,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "codigo": codigo,
      "novaSenha": novaSenha,
    };
  }
}