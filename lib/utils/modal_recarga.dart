
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
          title: Text("Informe o valor a ser adicionado na carteira"),

          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            autofocus: true,
            decoration: InputDecoration(
                hintText: "Ex: 20",

                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.principal),
                ),

                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: AppColors.principal,
                        width: 2
                    )
                )
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancelar",
                style: TextStyle(color: Colors.black),
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
                  style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }
