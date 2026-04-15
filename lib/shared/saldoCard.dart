import 'package:flutter/material.dart';

class SaldoCard extends StatelessWidget {

  final double saldo;
  final VoidCallback onPressed;



  const SaldoCard({
    super.key,
    required this.saldo,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    double largura = size.width;
    double altura = size.height;


    return

      Padding(
        padding: EdgeInsets.symmetric(horizontal: largura * 0.05),

        child: InkWell(
          onTap: onPressed,

          child:
              Container(

                  height: altura * 0.15,

                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32)
                  ),

                  child: Row(
                    mainAxisAlignment: .spaceBetween,
                    crossAxisAlignment: .center,
                    children: [
                      Column(
                        mainAxisAlignment: .center,
                        crossAxisAlignment: .start,


                        children: [
                          Text(
                            'R\$ ${saldo.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const Text('Saldo disponível',
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: .bold
                            ),),
                        ],
                      ),

                      const Icon(
                        Icons.add,
                        size: 120,
                        color: Colors.black,
                      ),
                    ],
                  )

              )

          ,
        ),
      );
  }
}
