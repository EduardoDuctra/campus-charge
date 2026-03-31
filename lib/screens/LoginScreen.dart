import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projeto_integrador/theme/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
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


          ],
        ),
      ),
    );
  }
}
