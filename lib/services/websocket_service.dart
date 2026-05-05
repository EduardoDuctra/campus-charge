import 'package:projeto_integrador/services/apiService.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';

class WebSocketService {
  static final WebSocketService _instance = WebSocketService._internal();

  factory WebSocketService() => _instance;

  WebSocketService._internal();

  StompClient? stompClient;
  bool _isConnected = false;

  // ========================= CONEXÃO =========================

  void _connectIfNeeded() {
    if (stompClient != null && _isConnected) return;

    stompClient = StompClient(
      config: StompConfig.SockJS(
        url: "${Apiservice.urlBase}/ws",

        onConnect: (frame) {
          print("✅ WS conectado");
          _isConnected = true;

          // 🔥 executa subscriptions pendentes
          _runPendingSubscriptions();
        },

        onWebSocketError: (error) {
          print("❌ Erro WS: $error");
          _isConnected = false;
        },

        onDisconnect: (frame) {
          print("⚠️ WS desconectado");
          _isConnected = false;
        },
      ),
    );

    stompClient!.activate();
  }

  // ========================= FILA DE SUBSCRIPTIONS =========================

  final List<Function()> _pendingSubscriptions = [];

  void _runPendingSubscriptions() {
    for (var fn in _pendingSubscriptions) {
      fn();
    }
    _pendingSubscriptions.clear();
  }

  void _subscribe(Function() action) {
    if (_isConnected) {
      action();
    } else {
      _pendingSubscriptions.add(action);
    }
  }

  // ========================= USUÁRIO =========================

  void conectarUsuario({
    required String userId,
    required Function(String) onMensagem,
  }) {
    _connectIfNeeded();

    _subscribe(() {
      print("👤 Subscribing usuário");

      stompClient!.subscribe(
        destination: '/topic/usuario/$userId',
        callback: (frame) {
          if (frame.body != null) {
            onMensagem(frame.body!);
          }
        },
      );

      stompClient!.subscribe(
        destination: '/topic/usuario/saldo/$userId',
        callback: (frame) {
          print("💰 SALDO: ${frame.body}");

          if (frame.body != null) {
            onMensagem(frame.body!);
          }
        },
      );
    });
  }

  // ========================= CARREGADORES =========================

  void conectarTodosCarregadores({
    required Function(String) onMensagem,
  }) {
    _connectIfNeeded();

    _subscribe(() {
      print("⚡ Subscribing carregadores");

      stompClient!.subscribe(
        destination: '/topic/carregadores',
        callback: (frame) {
          if (frame.body != null) {
            onMensagem(frame.body!);
          }
        },
      );
    });
  }

  // ========================= CONECTORES =========================

  void conectarCarregador({
    required String idCarregador,
    required Function(String) onMensagem,
  }) {
    _connectIfNeeded();

    _subscribe(() {
      print("🔌 Subscribing conectores: $idCarregador");

      stompClient!.subscribe(
        destination: '/topic/carregador/$idCarregador',
        callback: (frame) {
          print("🔥 MSG CONECTOR: ${frame.body}");

          if (frame.body != null) {
            onMensagem(frame.body!);
          }
        },
      );
    });
  }

  // ========================= DESCONEXÃO =========================

  void desconectar() {
    stompClient?.deactivate();
    _isConnected = false;
  }
}

// import 'package:projeto_integrador/services/apiService.dart';
// import 'package:stomp_dart_client/stomp.dart';
// import 'package:stomp_dart_client/stomp_config.dart';
//
// /**
//  * conexão websocket com o backend -> preciso de dados em tempo real
//  * observer no backend
//  */
// class WebSocketService {
//
//   static final WebSocketService _instance = WebSocketService._internal();
//
//   factory WebSocketService() => _instance;
//
//   WebSocketService._internal();
//
//   StompClient? stompClientUsuario;
//   StompClient? stompClientCarregador;
//
//
//   void conectar({
//     required String userId,
//     required Function(String) onMensagem,
//   }) {
//
//     if (stompClientUsuario != null && stompClientUsuario!.connected) {
//       print("WS usuário já conectado");
//       return;
//     }
//
//     stompClientUsuario = StompClient(
//       config: StompConfig.SockJS(
//         url: "${Apiservice.urlBase}/ws",
//
//         onConnect: (frame) {
//           print("Conectado WS USUÁRIO");
//
//           stompClientUsuario!.subscribe(
//             destination: '/topic/usuario/$userId',
//             callback: (frame) {
//               if (frame.body != null) {
//                 onMensagem(frame.body!);
//               }
//             },
//           );
//
//           stompClientUsuario!.subscribe(
//             destination: '/topic/usuario/saldo/$userId',
//             callback: (frame) {
//               print("SALDO RECEBIDO: ${frame.body}");
//
//               if (frame.body != null) {
//                 onMensagem(frame.body!);
//               }
//             },
//           );
//         },
//
//         onWebSocketError: (error) {
//           print("Erro WS usuário: $error");
//         },
//       ),
//     );
//
//     stompClientUsuario!.activate();
//   }
//
//   //atualizar os conectores do carregador
//   void conectarCarregador({
//     required String idCarregador,
//     required Function(String) onMensagem,
//   }) {
//
//     if (stompClientCarregador != null && stompClientCarregador!.connected) {
//       print("WS carregador já conectado");
//       return;
//     }
//
//     stompClientCarregador = StompClient(
//       config: StompConfig.SockJS(
//         url: "${Apiservice.urlBase}/ws",
//
//         onConnect: (frame) {
//           print("Conectado WS CARREGADOR");
//
//           stompClientCarregador!.subscribe(
//             destination: '/topic/carregador/$idCarregador',
//             callback: (frame) {
//               if (frame.body != null) {
//                 onMensagem(frame.body!);
//               }
//             },
//           );
//         },
//
//         onWebSocketError: (error) {
//           print("Erro WS carregador: $error");
//         },
//       ),
//     );
//
//     stompClientCarregador!.activate();
//   }
//
//   //atualizar os carregadores
//   void conectarTodosCarregadores({
//     required Function(String) onMensagem,
//   }) {
//
//     if (stompClientCarregador != null && stompClientCarregador!.connected) {
//       print("WS carregadores já conectado");
//       return;
//     }
//
//     stompClientCarregador = StompClient(
//       config: StompConfig.SockJS(
//         url: "${Apiservice.urlBase}/ws",
//
//         onConnect: (frame) {
//           print("Conectado WS CARREGADORES");
//
//           stompClientCarregador!.subscribe(
//             destination: '/topic/carregadores',
//             callback: (frame) {
//               if (frame.body != null) {
//                 onMensagem(frame.body!);
//               }
//             },
//           );
//         },
//
//         onWebSocketError: (error) {
//           print("Erro WS carregadores: $error");
//         },
//       ),
//     );
//
//     stompClientCarregador!.activate();
//   }
//
//   void desconectar() {
//     stompClientUsuario?.deactivate();
//     stompClientCarregador?.deactivate();
//   }
// }