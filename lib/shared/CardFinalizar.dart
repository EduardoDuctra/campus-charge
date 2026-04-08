import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../theme/colors.dart';

class CardFinalizar extends StatelessWidget {

  final VoidCallback onPressed;

  const CardFinalizar({super.key,
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

          height: altura * 0.2,
          width: largura * 0.425,

          padding: const EdgeInsets.all(0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32)
          ),

          child: Row(

            mainAxisAlignment: .center,
            crossAxisAlignment: .center,

            children: [
              Column(

                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  const Icon(
                    Icons.close_rounded,
                    size: 120,
                    color: Colors.black,
                  ),
                  Text(
                    'Finalizar recarga',
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
