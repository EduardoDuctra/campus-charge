import 'package:flutter/material.dart';
import 'package:projeto_integrador/DTO/UsuarioDTO.dart';

import '../shared/topBarWidget.dart';
import '../theme/colors.dart';

class Veiculocontent extends StatefulWidget {
  final UsuarioDTO usuario;

  const Veiculocontent({super.key, required this.usuario});

  @override
  State<Veiculocontent> createState() => _VeiculocontentState();
}

class _VeiculocontentState extends State<Veiculocontent> {

  String? marcaSelecionada;
  String? modeloSelecionado;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,

      child: SafeArea(
        child: Column(
          children: [

            TopBarWidget(usuario: widget.usuario),


            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [


                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        labelText: "Marca",
                      ),
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        labelText: "Modelo",
                      )
                    ),
                  ),
                ],
              ),
            ),


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.principal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Salvar",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}