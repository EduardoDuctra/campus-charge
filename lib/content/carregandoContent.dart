import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_integrador/shared/cardFinalizar.dart';
import 'package:projeto_integrador/shared/carregandoAtivoCard.dart';
import 'package:projeto_integrador/shared/valorRecargaCard.dart';
import 'package:projeto_integrador/theme/colors.dart';

import '../DTO/UsuarioDTO.dart';
import '../shared/conectorCard.dart';
import '../shared/saldoCard.dart';
import '../shared/topBarWidget.dart';

class Carregandocontent extends StatefulWidget {

  final UsuarioDTO usuario;

  const Carregandocontent({super.key, required this.usuario});

  @override
  State<Carregandocontent> createState() => _CarregandocontentState();
}

class _CarregandocontentState extends State<Carregandocontent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,

      child: SafeArea(
        child: Column(
          children: [


            TopBarWidget(),

            SaldoCard(
              saldo: 20,
              onPressed: () {
                print("Carregar");
              },
            ),

            SizedBox(height: 20,),

            Valorrecargacard(
              valor: 10,




              //modal valor
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {

                    TextEditingController controller = TextEditingController();

                    return AlertDialog(
                      title: Text("Informe o valor da recarga"),

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
                          onPressed: () {
                            print("Valor digitado: ${controller.text}");
                            Navigator.pop(context);
                          },
                          child: Text("Confirmar",
                              style: TextStyle(color: Colors.black)),
                        ),
                      ],
                    );
                  },
                );
              },



            ),

            Expanded(
              child: Container(

                child: Column(
                  children: [


                    SizedBox(height: 20),

                    Expanded(
                        child: CarregandoAtivoCard()
                    ),

                    SizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(
                          child: CardFinalizar(
                            onPressed: () {
                            print("Finalizar");
                          },
                          ),
                        ),

                      ],
                    )



                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
