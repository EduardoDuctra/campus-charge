import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projeto_integrador/DTO/EsqueciSenhaDTO.dart';
import 'package:projeto_integrador/screens/cadastroUsuarioScreen.dart';
import 'package:projeto_integrador/screens/redefinirSenhaScreen.dart';
import 'package:projeto_integrador/theme/colors.dart';

import '../DTO/DadosAutenticacaoDTO.dart';
import '../services/loginService.dart';
import 'homeScreen.dart';

class EsqueciSenhaScreen extends StatelessWidget {
  EsqueciSenhaScreen({super.key});

  final emailController = TextEditingController();

  final loginService = LoginService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        

        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),

          child: Center(
            child: Column(
              mainAxisAlignment: .center,
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 60, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/material-symbols_ev-charger-rounded.svg',
                      width: 80,
                    ),
          
                    SizedBox(width: 12),
          
                    Text(
                      'Campus Charge',
                      style: TextStyle(
                        color: AppColors.principal,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
                ),
          
                // email
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                    child: TextFormField(
                      controller: emailController,
                      style: TextStyle(color: Colors.black),
          
                      validator: (value) {
                        if(value != null && value.isNotEmpty){
                          return null;
                        } else {
                          return 'Email obrigatório';
                        }
                      },
          
                      decoration: InputDecoration(
          
                        filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)
                          ),
                          hintText: "Insira um email válido"
                      ),
                    )
                ),
          

          
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.principal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () async {

                        final email = emailController.text;

                        final mensagem = await loginService.esqueciSenha(
                          EsqueciSenhaDTO(email: email)
                        );

                        if(mensagem != null){

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RedefinirSenhaScreen(
                                      email: email))
                          );

                        }

                      },
                      child: Text(
                        "Enviar",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
