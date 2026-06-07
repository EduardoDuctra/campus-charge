class RemoteStartResponseDTO {
  String response;
  bool aceito;

  RemoteStartResponseDTO({
    required this.response,
    required this.aceito,
  });

  factory RemoteStartResponseDTO.fromJson(
      Map<String, dynamic> json) {

    return RemoteStartResponseDTO(
      response: json["erro"] ?? "",
      aceito: false,
    );
  }

}