import 'package:flutter/material.dart';
import 'package:projeto_integrador/DTO/UsuarioDTO.dart';
import 'package:projeto_integrador/services/veiculoService.dart';
import 'package:projeto_integrador/shared/botaoCancelar.dart';

import '../DTO/SenhaAtualizarDTO.dart';
import '../DTO/VeiculoDTO.dart';
import '../services/usuarioService.dart';
import '../shared/appDrawer.dart';
import '../shared/topBarWidget.dart';
import '../theme/colors.dart';
import 'homeScreen.dart';

class AtualizarSenhaScreen extends StatefulWidget {
  final UsuarioDTO usuario;

  const AtualizarSenhaScreen({super.key, required this.usuario});

  @override
  State<AtualizarSenhaScreen> createState() => _AtualizarSenhaScreenState();
}

class _AtualizarSenhaScreenState extends State<AtualizarSenhaScreen> {


  final TextEditingController senhaController = TextEditingController();
  final TextEditingController confirmarSenhaController = TextEditingController();

  final _formKey = GlobalKey<FormState>();


  Widget buildInput(double width, String label, TextEditingController controller,
      {bool isPassword = true, validator}) {

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.15, vertical: 4),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        validator: validator,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),

            hintText: label,

            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.black),
            ),

            errorStyle: TextStyle(
              color: Colors.redAccent,
              fontSize: 12,
              height: 0.5,
            )

        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(

      drawer: AppDrawer(
        usuario: widget.usuario,),

      backgroundColor: Colors.black,

      body: SafeArea(
        child: Form(
          key: _formKey,

          child: Column(
            children: [



              TopBarWidget(usuario: widget.usuario),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text(
                      "Atualizar Senha",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: height * 0.03,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: height * 0.03),

                    buildInput(
                      width,
                      "Nova senha",
                      senhaController,

                      isPassword: true,

                      validator: (value) {

                        if(value == null || value.isEmpty){
                          return "Senha obrigatória";
                        }

                        if(value.length < 6){
                          return "Mínimo 6 caracteres";
                        }

                        return null;
                      },
                    ),

                    buildInput(
                      width,
                      "Confirmar senha",
                      confirmarSenhaController,

                      isPassword: true,

                      validator: (value){

                        if(value != senhaController.text){
                          return "Senhas não conferem";
                        }

                        return null;
                      },
                    ),

                    SizedBox(height: height * 0.06),

                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.15,
                      ),

                      child: SizedBox(
                        width: double.infinity,
                        height: height * 0.05,

                        child: ElevatedButton(

                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.principal,

                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(30),
                            ),
                          ),

                          onPressed: () async {

                            if(!_formKey.currentState!.validate()){
                              return;
                            }

                            final senhaDTO = SenhaAtualizarDTO(senha:senhaController.text);

                            await Usuarioservice().atualizarSenha(senhaDTO);

                            Navigator.pop(context);

                          },

                          child: Text(
                            "Atualizar",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: height * 0.02,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 10,),
                    BotaoCancelar(),

                  ],
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}