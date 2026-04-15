import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../theme/colors.dart';

class ConectorCard extends StatelessWidget {

  final String conector;
  final String nome;
  final VoidCallback onPressed;

  const ConectorCard({super.key,
    required this.conector,
    required this.onPressed,
    required this.nome});

  @override
  Widget build(BuildContext context) {


    final size = MediaQuery.of(context).size;
    double largura = size.width;
    double altura = size.height;


    return Padding(

        padding: EdgeInsets.symmetric(horizontal: largura * 0.05),

            child: Column(
              children: [
                InkWell(

                  onTap: onPressed,

                  child: Container(

                    height: altura * 0.1,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: AppColors.principal,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32),

                        )
                    ),


                    child: Row(

                      mainAxisAlignment: .spaceBetween,
                      crossAxisAlignment: .center,

                      children: [
                        Expanded(
                          child: Row(

                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [

                              if(conector == "Conector Rápido")

                                SvgPicture.asset(
                                    'assets/icons/rapido.svg',
                                    width: largura * 0.1,
                                    colorFilter: ColorFilter.mode(
                                        Colors.black,
                                        BlendMode.srcIn)

                                ),

                              if(conector == "Conector Alternado")

                                SvgPicture.asset(
                                    'assets/icons/iconoir_ev-plug.svg',
                                    width: largura * 0.1,
                                    colorFilter: ColorFilter.mode(
                                        Colors.black,
                                        BlendMode.srcIn)

                                ),


                              Padding(


                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(

                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: .start,

                                  children: [
                                    Text(
                                      '${conector}',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    Text(
                                      '${nome}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),

                                  ],
                                ),
                              ),


                            ],
                          ),
                        ),

                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 80,
                          color: Colors.black,
                        ),
                      ],
                    ),

                  ),


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
                        "Remover conector",
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
