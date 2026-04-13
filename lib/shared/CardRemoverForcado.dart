import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:projeto_integrador/theme/colors.dart';

class CardRemoverForcado extends StatelessWidget {

  final VoidCallback onPressed;

  const CardRemoverForcado({super.key,
    required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    double largura = size.width;
    double altura = size.height;

    return Padding(
      padding: EdgeInsets.only(left: largura * 0.05),

      child: InkWell(

        onTap: onPressed,

        child: Container(

          height: altura * 0.15,
          width: largura * 0.425,

          padding: const EdgeInsets.all(0),
          decoration: BoxDecoration(
              color: AppColors.cinza,
              borderRadius: BorderRadius.circular(32)
          ),

          child: Row(

            mainAxisAlignment: .center,
            crossAxisAlignment: .center,

            children: [
              Column(

                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  SvgPicture.asset(
                      'assets/icons/remover_icon.svg',
                      width: 100,
                      colorFilter: ColorFilter.mode(
                          Colors.black,
                          BlendMode.srcIn)

                  ),
                  Text(
                    'Remover conector',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),

        ),
      ),
    );
  }
}
