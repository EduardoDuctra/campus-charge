import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:projeto_integrador/DTO/TransacaoAtivaDTO.dart';

import '../theme/colors.dart';

class CarregandoAtivoCard extends StatelessWidget {
  final TransacaoAtivaDTO transacao;


  const CarregandoAtivoCard({super.key,
    required this.transacao});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    double largura = size.width;

    double porcentagemRecarga = transacao.socAtual/100;

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

                    ClipRRect(

                      borderRadius: BorderRadius.circular(20),

                      child: LinearProgressIndicator(
                        value: porcentagemRecarga,
                        color: Colors.black,
                        backgroundColor: Colors.white,
                        minHeight: 8,
                      ),
                    ),

                    Text(
                      'Seu veículo está ${transacao.socAtual}% carregado',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
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
