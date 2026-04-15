import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:projeto_integrador/theme/colors.dart';

class Valorrecargacard extends StatelessWidget {

  final double valor;
  final VoidCallback onPressed;




  const Valorrecargacard({super.key,
    required this.valor,
    required this.onPressed});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    double largura = size.width;
    double altura = size.height;


    return

      Padding(
        padding: EdgeInsets.symmetric(horizontal: largura * 0.05),

        child: Column(
          children: [
            InkWell(
              onTap: onPressed,

              child:
              Container(

                  height: altura * 0.12,

                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32)
                      )
                  ),

                  child: Row(
                    mainAxisAlignment: .spaceBetween,
                    crossAxisAlignment: .center,
                    children: [
                      Column(
                        mainAxisAlignment: .center,
                        crossAxisAlignment: .start,


                        children: [
                          Text(
                            'R\$ ${valor.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const Text('Custo estimado',
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: .bold
                            ),),
                        ],
                      ),


                      Padding(
                        padding: EdgeInsets.only(right: 16),
                        child: SvgPicture.asset(
                            'assets/icons/item_valor.svg',
                            width: 60,
                            colorFilter: ColorFilter.mode(
                                Colors.black,
                                BlendMode.srcIn)

                        ),
                      ),

                    ],
                  )

              )

              ,
            ),

            InkWell(

                onTap: onPressed,

                child: Container(

                  height: altura * 0.05,
                  width: double.infinity,


                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(32),
                        bottomRight: Radius.circular(32),

                      )
                  ),

                  child: Center(
                    child: Text(
                      "Informe o valor desejado para a recarga",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),

                )

            )

          ],
        ),
      );
  }
}