import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../DTO/ConectorDTO.dart';
import '../theme/colors.dart';

class ConectorCard extends StatelessWidget {


  final ConectorDTO dto;
  final VoidCallback onPressed;

  const ConectorCard({super.key,
    required this.dto,
    required this.onPressed});

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

                    height: altura * 0.12,
                    padding: const EdgeInsets.symmetric(),
                    decoration: BoxDecoration(
                        color: AppColors.principal,
                        borderRadius: BorderRadius.circular(32)
                    ),


                    child: Row(

                      mainAxisAlignment: .spaceBetween,
                      crossAxisAlignment: .center,

                      children: [
                        Expanded(
                          child: Row(

                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [

                              if(dto.tipo == "CC")

                                SvgPicture.asset(
                                    'assets/icons/rapido.svg',
                                    width: largura * 0.10,
                                    colorFilter: ColorFilter.mode(
                                        Colors.black,
                                        BlendMode.srcIn)

                                ),

                              if(dto.tipo == "CA")

                                SvgPicture.asset(
                                    'assets/icons/iconoir_ev-plug.svg',
                                    width: largura * 0.10,
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
                                      dto.tipo == "CC" ? "Corrente Contínua" : "Corrente Alternada",
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    Text(
                                      '${dto.nomeConector} - R\$ ${dto.valorEnergia}/kWh',
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
                          size: 60,
                          color: Colors.black,
                        ),
                      ],
                    ),

                  ),


                    ),

              ],
            ),
    );
  }
}
