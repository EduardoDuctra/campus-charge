
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_integrador/services/transacaoService.dart';

import '../theme/colors.dart';

final TransacaoService transacaoService = TransacaoService();

void abrirModalRecarga(BuildContext context){


  //modal valor
    showDialog(
      context: context,
      builder: (context) {

        TextEditingController controller = TextEditingController();

        return AlertDialog(

          backgroundColor: AppColors.principal,

          title: Text("Informe o valor a ser adicionado na carteira",
              textAlign: .center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w500)
          ),

          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            autofocus: true,
            decoration: InputDecoration(
                hintText: "Ex: 20",

              enabledBorder: OutlineInputBorder(

                borderRadius: BorderRadius.circular(20),

                borderSide: BorderSide(
                  color: Colors.black,
                  width: 2,
                ),
              ),


              focusedBorder: OutlineInputBorder(

                borderRadius: BorderRadius.circular(20),

                borderSide: BorderSide(
                  color: Colors.black,
                  width: 2,
                ),
              ),
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancelar",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                ),
              ),

            ),

            TextButton(
              onPressed: () async {

                double valor = double.tryParse(controller.text) ?? 0;

                print("Valor digitado: $valor");
                String? link = await transacaoService.criarTransacao(valor);

                if(link!=null){

                  await transacaoService.abrirMercadoPago(context, link);

                }

                Navigator.pop(context);
              },
              child: Text("Confirmar",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                  )
              ),
            ),
          ],
        );
      },
    );
  }
