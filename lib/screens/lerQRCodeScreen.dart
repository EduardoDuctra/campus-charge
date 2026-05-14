import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../DTO/UsuarioDTO.dart';

class LerQRCodeScreen extends StatefulWidget {
  final UsuarioDTO usuario;

  const LerQRCodeScreen({super.key,
    required this.usuario});

  @override
  State<LerQRCodeScreen> createState() => _LerQRCodeScreenState();
}

class _LerQRCodeScreenState extends State<LerQRCodeScreen> {

  bool leituraRealizada = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      
      body: Stack(

        children:[

          //leitor
          MobileScanner(
            controller: MobileScannerController(),

            onDetect: (capture){

              //evita múltiplas leituras do mesmo QR Code
              if(leituraRealizada){
                return;
              }

              //pegar todos os codigos capturados pela camera
              //lista de códigos encontrados pela câmera no frame capturado
              final List<Barcode> barcodes = capture.barcodes;

              //percorre todos os códigos detectados pela câmera
              for(final barcode in barcodes){

                //pega o valor lido no QR code
                final String? codigo = barcode.rawValue;

                //fez a leitura
                if(codigo != null ){
                  leituraRealizada = true;

                  print("QR CODE: $codigo");

                  //todo -> redirecionar tela carregadores
                  break;
                }


              }
            },

          ),

          Positioned(
            top: 80,
            left: 0,
            right: 0,

            child: Center(
              child: Text(
                "Leia o QR Code do carregador",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
            ),
          ),

        ]
      ),

    );
  }
}
