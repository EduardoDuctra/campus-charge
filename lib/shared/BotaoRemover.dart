import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../theme/colors.dart';

class BotaoRemover extends StatelessWidget {

  final VoidCallback onPressed;

  const BotaoRemover({super.key,
    required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    double largura = size.width;
    double altura = size.height;

    return Padding(

      padding: EdgeInsets.symmetric(horizontal: largura * 0.05),


      child: InkWell(

        onTap: onPressed,

        child: Container(

          height: altura * 0.2,
          width: largura *0.75,

          padding: const EdgeInsets.all(0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24)
          ),

          child: Row(

            mainAxisAlignment: .center,
            crossAxisAlignment: .center,

            children: [
              Row(

                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  Icon(
                    Icons.car_crash,
                    size: 80,
                    color: Colors.black,
                  ),

                  Text(
                    'Forçar retirada',
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
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
