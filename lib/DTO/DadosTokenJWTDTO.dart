class DadosTokenJWTDTO{
  String token;

  DadosTokenJWTDTO({
    required this.token
});

  factory DadosTokenJWTDTO.fromJson(Map<String, dynamic> json) {
    return DadosTokenJWTDTO(
      token: json['token'],
    );
  }
}