import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardHistoricoRecargas extends StatelessWidget {
  final String tipo;
  final double valor;
  final DateTime data;

  const CardHistoricoRecargas({
    super.key,
    required this.tipo,
    required this.valor,
    required this.data,
  });

  String formatarData(DateTime data) {
    return "${data.day.toString().padLeft(2, '0')}/"
        "${data.month.toString().padLeft(2, '0')}/"
        "${data.year}";
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double largura = size.width;
    double altura = size.height;



    return Padding(
      padding: EdgeInsets.symmetric(horizontal: largura * 0.05),
      child: InkWell(
        child: Container(
          height: altura * 0.15,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'R\$ ${valor.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    tipo,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                formatarData(data),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}