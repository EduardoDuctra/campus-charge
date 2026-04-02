import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projeto_integrador/screens/CadastroUsuarioScreen.dart';
import 'package:projeto_integrador/theme/colors.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();

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
                      width: 150,
                    ),
          
                    SizedBox(width: 24),
          
                    Text(
                      'Campus Charge',
                      style: TextStyle(
                        color: AppColors.principal,
                        fontSize: 40,
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
                      onPressed: () {
                        bool valido = _formKey.currentState!.validate();
          
                        if (valido) {}
          
                        print("screen após login");
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
                      onPressed: () {
                        bool valido = _formKey.currentState!.validate();
          
                        if (valido) {}
          
                        print("screen após login");
                      },
                      child: Text(
                        "Login com google",
                        style: TextStyle(fontSize: 18, color: Colors.black),
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
