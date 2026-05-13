import 'package:flutter/material.dart';
import 'package:projeto_integrador/DTO/UsuarioDTO.dart';
import 'package:projeto_integrador/screens/cadastrarVeiculoScreen.dart';

class BotaoAdicionar extends StatelessWidget {
  final UsuarioDTO usuarioDTO;

  const BotaoAdicionar({super.key,
    required this.usuarioDTO});

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.1),

      child: SizedBox(
        width: width * 0.7,
        height: height * 0.05,

        child: ElevatedButton(

          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),

          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CadastrarVeiculoScreen(
                    usuario: usuarioDTO),
              ),
            );
          },

          child: Text(
            "Adicionar veículo",

            style: TextStyle(
              fontSize: height * 0.02,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}