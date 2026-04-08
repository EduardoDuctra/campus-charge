import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:projeto_integrador/shared/CarregadorCard.dart';
import 'package:projeto_integrador/shared/SaldoCard.dart';

import '../shared/ConectorCard.dart';
import '../theme/colors.dart';

class CadastroUsuarioScreen extends StatelessWidget {
  const CadastroUsuarioScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

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
                    padding: EdgeInsets.only(top: width * 0.12, bottom: width * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/material-symbols_ev-charger-rounded.svg',
                          width: width * 0.25,
                          colorFilter: ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn)

                        ),

                        SizedBox(width: width * 0.04),

                        Text(
                          'Campus Charge',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: width * 0.08,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                ),

                SizedBox(height: 40),

                Text("Cadastro de Usuário",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),



                Padding(

                  padding: EdgeInsets.symmetric( horizontal: width * 0.1, vertical: 15),

                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Center(child: Text("Foto")),
                        ),
                      ),


                      SizedBox(width: 10),



                      Expanded(
                        child: Column(
                          children: [

                            //nome
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 15),                              child: TextFormField(

                                  style: TextStyle(color: Colors.black),

                                  validator: (value) {
                                    if(value != null && value.isNotEmpty){
                                      return null;
                                    } else {
                                      return 'Nome de usuário obrigatório';
                                    }
                                  },

                                  decoration: InputDecoration(

                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30)
                                      ),
                                      labelText: "Nome",
                                      hintText: "Insira um nome válido"
                                  ),
                                )
                            ),


                            //cpf
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 15),                              child: TextFormField(

                                  style: TextStyle(color: Colors.black),

                                  validator: (value) {
                                    if(value != null && value.isNotEmpty){
                                      return null;
                                    } else {
                                      return 'CPF obrigatório';
                                    }
                                  },

                                  decoration: InputDecoration(

                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30)
                                      ),
                                      labelText: "CPF",
                                      hintText: "Insira um CPF válido"
                                  ),
                                )
                            ),



                          ],
                        ),
                      ),
                    ],
                  ),
                ),


                //fone
                Padding(
                    padding: EdgeInsets.symmetric( horizontal: width * 0.1, vertical: 15),
                    child: TextFormField(

                  style: TextStyle(color: Colors.black),

                  validator: (value) {
                    if(value != null && value.isNotEmpty){
                      return null;
                    } else {
                      return 'Telefone obrigatório';
                    }
                  },

                  decoration: InputDecoration(

                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)
                      ),
                      labelText: "Telefone",
                      hintText: "Insira um telefone válido"
                  ),
                )
                ),

                //email
                Padding(
                    padding: EdgeInsets.symmetric( horizontal: width * 0.1, vertical: 15),
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
                          labelText: "Email",
                          hintText: "Insira um email válido"
                      ),
                    )
                ),

                //senha
                Padding(
                    padding: EdgeInsets.symmetric( horizontal: width * 0.1, vertical: 15),
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
                          labelText: "Senha",
                          hintText: "Insira uma senha válida"
                      ),
                    )
                ),

                //senha
                Padding(
                    padding: EdgeInsets.symmetric( horizontal: width * 0.1, vertical: 15),
                    child: TextFormField(

                      style: TextStyle(color: Colors.black),

                      validator: (value) {
                        if(value != null && value.isNotEmpty){
                          return null;
                        } else {
                          return 'Confirme a senha';
                        }
                      },

                      decoration: InputDecoration(

                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)
                          ),
                          labelText: "Confirme a senha",
                          hintText: "As senhas não correspondem"
                      ),
                    )
                ),

                SizedBox(height: 40),

                Padding(
                  padding: EdgeInsets.symmetric( horizontal: width * 0.1, vertical: 15),
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

                      },
                      child: Text(
                        "Cadastrar",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ),


              ]









            ),
          ),
        ),
      ),
    );
  }
}
