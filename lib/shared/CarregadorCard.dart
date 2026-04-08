import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projeto_integrador/theme/colors.dart';

class CardCarregador extends StatelessWidget {

  final String carregador;
  final VoidCallback onPressed;




  const CardCarregador({super.key,
    required this.carregador,
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

          // height: altura * 0.3,

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

                  SvgPicture.asset(
                      'assets/icons/material-symbols_ev-charger-rounded.svg',
                      width: largura * 0.25,
                      colorFilter: ColorFilter.mode(
                          Colors.black,
                          BlendMode.srcIn)

                  ),
                  Text(
                    '${carregador}',
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
