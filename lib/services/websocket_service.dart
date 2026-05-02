import 'package:projeto_integrador/services/apiService.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';


class WebSocketService {


  StompClient? stompClient;

  void conectar({
    required String userId,
    required Function(String) onMensagem,
  }) {

    stompClient = StompClient(
      config: StompConfig.SockJS(
          url: "${Apiservice.urlBase}/ws",

        onConnect: (frame) {
          print("Conectado WS");

          stompClient!.subscribe(
            destination: '/topic/usuario/$userId',
            callback: (frame) {
              if (frame.body != null) {
                onMensagem(frame.body!);
              }
            },
          );
        },

        onWebSocketError: (error) {
          print("Erro WS: $error");
        },
      ),
    );

    stompClient!.activate();
  }

  void conectarCarregador({
    required String idCarregador,
    required Function(String) onMensagem,
  }) {

    stompClient = StompClient(
      config: StompConfig.SockJS(
        url: "${Apiservice.urlBase}/ws",

        onConnect: (frame) {
          print("Conectado WS Carregador");

          stompClient!.subscribe(
            destination: '/topic/carregador/$idCarregador',
            callback: (frame) {
              if (frame.body != null) {
                onMensagem(frame.body!);
              }
            },
          );
        },

        onWebSocketError: (error) {
          print("Erro WS: $error");
        },
      ),
    );

    stompClient!.activate();
  }
  void desconectar() {
    stompClient?.deactivate();
  }
}