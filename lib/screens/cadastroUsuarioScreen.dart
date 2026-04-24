import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../DTO/UsuarioDTO.dart';
import '../services/usuarioService.dart';
import '../theme/colors.dart';
import 'package:br_validators/br_validators.dart';

class CadastroUsuarioScreen extends StatelessWidget {
  const CadastroUsuarioScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final nomeController = TextEditingController();
    final cpfController  = TextEditingController();
    final telefoneController  = TextEditingController();
    final emailController  = TextEditingController();
    final senhaController  = TextEditingController();
    final confirmarSenhaController  = TextEditingController();

    final _formKey = GlobalKey<FormState>();


    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(

        child: Form(
          key: _formKey,

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
              buildInput(width, "Nome", nomeController,

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nome obrigatório";
                  }

                  return null;
                },
              ),
          
              buildInput(width, "CPF", cpfController,
          
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "CPF obrigatório";
                  }
                  if (!BRValidators.validateCPF(value)) {
                    return "CPF inválido";
                  }
                  return null;
                },
              ),
          
              buildInput(width, "Telefone", telefoneController,
          
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Telefone obrigatório";
                  }
                  if (!BRValidators.validateMobileNumber(value)) {
                    return "Telefone inválido";
                  }
                  return null;
                },),

              buildInput(width, "Email", emailController,

                validator: (value) {

                  if (value == null || value.isEmpty) {
                    return "Email obrigatório";
                  }
                  if (!value.contains("@")) {
                    return "Email inválido";
                  }
                  return null;
                },
              ),

              buildInput(width, "Senha", senhaController,
          
                isPassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Senha obrigatória";
                  }
                  if (value.length < 6) {
                    return "Mínimo 6 caracteres";
                  }
                  return null;
                },
              ),
          
              buildInput(width, "Confirmar senha", confirmarSenhaController,
          
                isPassword: true,
                validator: (value) {
                  if (value != senhaController.text) {
                    return "Senhas não conferem";
                  }
                  return null;
                },
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
                      backgroundColor: AppColors.principal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
          
                    onPressed: () async {
          
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
          
                      final usuario = UsuarioDTO(
                        nome: nomeController.text,
                        cpf: cpfController.text,
                        telefone: telefoneController.text,
                        email: emailController.text,
                        senha: senhaController.text,
                      );
          
                      bool sucesso = await Usuarioservice().cadastrar(usuario);
          
                     if(sucesso){
                       Navigator.pop(context);
                     }else {
                       print("Erro ao cadastrar");
                     }
          
          
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
      ),
    );
  }

  Widget buildInput(double width, String label, TextEditingController controller,
      {bool isPassword = false, String? Function(String?)? validator}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.1, vertical: 4),
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
}