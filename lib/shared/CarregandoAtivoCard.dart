import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../theme/colors.dart';

class CarregandoAtivoCard extends StatelessWidget {
  const CarregandoAtivoCard({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    double largura = size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: largura * 0.05),

        child: Container(



          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: AppColors.principal,
              borderRadius: BorderRadius.circular(32)
          ),

          child: Row(

            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: .center,

            children: [
              Expanded(
                child: Column(
                
                  mainAxisAlignment: MainAxisAlignment.center,
                
                  children: [
                
                    SvgPicture.asset(
                        'assets/icons/material-symbols_ev-charger-rounded.svg',
                        width: largura * 0.25,
                        colorFilter: ColorFilter.mode(
                            Colors.black,
                            BlendMode.srcIn)
                
                    ),
                    Text(
                      'Seu veículo está 50% carregado',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
      ),
    );
  }
}
