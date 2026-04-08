import 'package:flutter/material.dart';

import '../shared/TopBarWidget.dart';
import '../theme/colors.dart';

class Veiculocontent extends StatefulWidget {
  const Veiculocontent({super.key});

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

            TopBarWidget(),

            /// PARTE CENTRAL
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  /// MARCA
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: DropdownButtonFormField<String>(
                      value: marcaSelecionada,
                      dropdownColor: Colors.white,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        labelText: "Marca",
                      ),
                      items: ["Toyota", "Honda", "Tesla"]
                          .map((marca) => DropdownMenuItem(
                        value: marca,
                        child: Text(marca),
                      ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          marcaSelecionada = value;
                        });
                      },
                    ),
                  ),

                  /// MODELO
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: DropdownButtonFormField<String>(
                      value: modeloSelecionado,
                      dropdownColor: Colors.white,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        labelText: "Modelo",
                      ),
                      items: ["Modelo A", "Modelo B"]
                          .map((modelo) => DropdownMenuItem(
                        value: modelo,
                        child: Text(modelo),
                      ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          modeloSelecionado = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),

            /// BOTÃO EMBAIXO
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