
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Cardveiculo extends StatelessWidget {

  final VoidCallback onPressed;
  final VoidCallback onDelete;

  final String nomeVeiculo;
  final String modeloVeiculo;
  final Color cor;


  const Cardveiculo({super.key,
    required this.onPressed,
    required this.nomeVeiculo,
    required this.modeloVeiculo,
    required this.cor,
    required this.onDelete});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    double largura = size.width;
    double altura = size.height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: largura * 0.05),
      child: InkWell(

        onTap: onPressed,

        child: Container(
          height: altura * 0.3,
          width: largura * 0.7,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cor,
            borderRadius: BorderRadius.circular(32),
          ),
          child:

              Stack(
                children: [

                  Positioned(

                    top: 0,
                    right: 0,

                    child: InkWell(

                    onTap: onDelete,

                    child: Container(

                      child: const Icon(
                        Icons.delete,
                        size: 40,
                        color: Colors.black,
                      ),
                    ),

                  ),
                  ),

                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        SvgPicture.asset(
                            'assets/icons/carro.svg',
                            width: largura * 0.15,
                            colorFilter: ColorFilter.mode(
                                Colors.black,
                                BlendMode.srcIn)

                        ),

                        SizedBox(height: 10,),

                        Text(
                          nomeVeiculo,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          modeloVeiculo,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),



                ],
              )


        ),
      ),
    );;
  }
}
