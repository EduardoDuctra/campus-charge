import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../theme/colors.dart';

class ConectorCard extends StatelessWidget {

  final String conector;
  final VoidCallback onPressed;

  const ConectorCard({super.key,
    required this.conector,
    required this.onPressed});

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

                height: altura * 0.2,

                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: AppColors.principal,
                    borderRadius: BorderRadius.circular(32)
                ),


                child: Row(

                  mainAxisAlignment: .spaceBetween,
                  crossAxisAlignment: .center,

                  children: [
                    Column(

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

                        Text(
                          '${conector}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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
    );
  }
}
