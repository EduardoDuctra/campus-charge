import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../theme/colors.dart';

class CadastroUsuarioScreen extends StatelessWidget {
  const CadastroUsuarioScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Padding(
              padding: EdgeInsets.only(
                top: height * 0.05,
                bottom: height * 0.01,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SvgPicture.asset(
                    'assets/icons/material-symbols_ev-charger-rounded.svg',
                    width: width * 0.18,
                    colorFilter: ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),

                  SizedBox(width: width * 0.03),

                  Text(
                    'Campus Charge',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: width * 0.06,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: height * 0.02),

            Text(
              "Dados de Usuário",
              style: TextStyle(
                color: Colors.white,
                fontSize: height * 0.025,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: height * 0.02),

            // FOTO
            InkWell(
              onTap: () {
                print("clicou na foto");
              },
              borderRadius: BorderRadius.circular(100),
              child: Container(
                width: height * 0.15,
                height: height * 0.15,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(child: Text("Foto")),
              ),
            ),

            SizedBox(height: height * 0.015),

            // CAMPOS
            buildInput(width, "Nome"),
            buildInput(width, "CPF"),
            buildInput(width, "Telefone"),
            buildInput(width, "Email"),
            buildInput(width, "Senha"),
            buildInput(width, "Confirmar senha"),

            SizedBox(height: height * 0.02),

            // BOTÃO
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.1),
              child: SizedBox(
                width: double.infinity,
                height: height * 0.05,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.principal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cadastrar",
                    style: TextStyle(
                      fontSize: height * 0.02,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: height * 0.02),

            // BOTÃO
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.1),
              child: SizedBox(
                width: double.infinity,
                height: height * 0.05,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancelar",
                    style: TextStyle(
                      fontSize: height * 0.02,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInput(double width, String label) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.1, vertical: 4),
      child: TextFormField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          labelText: label,
        ),
      ),
    );
  }
}