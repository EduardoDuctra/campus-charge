import 'package:flutter/material.dart';
import 'package:projeto_integrador/DTO/UsuarioDTO.dart';
import 'package:projeto_integrador/services/veiculoService.dart';
import 'package:projeto_integrador/shared/botaoCancelar.dart';

import '../DTO/VeiculoDTO.dart';
import '../shared/topBarWidget.dart';
import '../theme/colors.dart';
import 'homeScreen.dart';

class CadastrarVeiculoScreen extends StatefulWidget {
  final UsuarioDTO usuario;

  const CadastrarVeiculoScreen({super.key, required this.usuario});

  @override
  State<CadastrarVeiculoScreen> createState() => _CadastrarVeiculoScreenState();
}

class _CadastrarVeiculoScreenState extends State<CadastrarVeiculoScreen> {


  final VeiculoService veiculoService = VeiculoService();
  final TextEditingController marcaController = TextEditingController();
  final TextEditingController modeloController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        child: Column(
          children: [

            TopBarWidget(),


            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [


                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: TextFormField(
                      controller: marcaController,
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
                        controller: modeloController,
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
                width: width * 0.7,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.principal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () async {

                    final veiculoDTO = VeiculoDTO(
                      nomeMarca: marcaController.text,
                      modeloCarro: modeloController.text,);

                    final veiculo = await veiculoService.cadastrarVeiculo(veiculoDTO);

                    if(veiculo != null){

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    }

                    },

                  child: const Text(
                    "Salvar",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
              ),
            ),

            BotaoCancelar(),
          ],
        ),
      ),
    );
  }
}