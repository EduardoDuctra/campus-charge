import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projeto_integrador/screens/cadastroUsuarioScreen.dart';
import 'package:projeto_integrador/screens/esqueciSenhaScreen.dart';
import 'package:projeto_integrador/theme/colors.dart';

import '../DTO/DadosAutenticacaoDTO.dart';
import '../services/loginService.dart';
import 'homeScreen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
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
                          labelText: "Informe seu email",
                          hintText: "Insira um email válido"
                      ),
                    )
                ),
          
          
                // senha
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: TextFormField(
                      controller: senhaController,
                      style: TextStyle(color: Colors.black),
          
                      validator: (value) {
                        if(value != null && value.isNotEmpty){
                          return null;
                        } else {
                          return 'Senha obrigatória';
                        }
                      },
          
                      decoration: InputDecoration(
          
                          filled: true,
                          fillColor: Colors.white,
          
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)
                          ),
                          labelText: "Informe sua senha",
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

                        final resultado = await loginService.efetuarLogin(

                          DadosAutenticacaoDTO(
                            email: emailController.text,
                            senha: senhaController.text,
                          ),
                        );

          
                        if (resultado != null) {
                          Navigator.pushReplacement(
                            context, 
                            MaterialPageRoute(
                                builder: (context) => HomeScreen())
                          );
                        }

                      },
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ),
          
          
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: ()  async {

                        final resultado = await loginService.loginGoogle();


                        if (resultado != null) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen())
                          );
                        }

                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          SvgPicture.asset(
                            'assets/icons/icon_google.svg',
                            width: 20,
                          ),

                          SizedBox(width: 10),

                          Text(
                            "Login com google",
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
          
                SizedBox(height: 20),
          
                TextButton(
                  onPressed: () {

                    Navigator.push(context, MaterialPageRoute(
                      // rota
                        builder: (context) => CadastroUsuarioScreen())
                    );

                  },
                  child: const Text(
                    "Novo usuário",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
          
                SizedBox(height: 20),
          
                TextButton(
                  onPressed: () {

                    Navigator.push(context, MaterialPageRoute(

                        builder: (context) => EsqueciSenhaScreen())
                    );
          
                  },
                  child: const Text(
                    "Esqueci minha senha",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
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
