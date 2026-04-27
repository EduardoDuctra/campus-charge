import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import '../DTO/UsuarioDTO.dart';
import '../services/usuarioService.dart';
import '../theme/colors.dart';
import 'package:br_validators/br_validators.dart';

class CadastroUsuarioScreen extends StatefulWidget {
  final UsuarioDTO? usuario;

  const CadastroUsuarioScreen({super.key, this.usuario});

  @override
  State<CadastroUsuarioScreen> createState() => _CadastroUsuarioScreenState();
}

class _CadastroUsuarioScreenState extends State<CadastroUsuarioScreen> {

  @override
  Widget build(BuildContext context) {

    final nomeController = TextEditingController(text: widget.usuario?.nome ?? "");
    final cpfController  = TextEditingController(text: widget.usuario?.cpf ?? "");
    final telefoneController  = TextEditingController(text: widget.usuario?.telefone ?? "");
    final emailController  = TextEditingController(text: widget.usuario?.email ?? "");
    final senhaController  = TextEditingController();
    final confirmarSenhaController  = TextEditingController();

    final _formKey = GlobalKey<FormState>();

    bool modoEdicao;

    if(widget.usuario != null){
      modoEdicao = true;
    } else{
      modoEdicao = false;
    }


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

              if(modoEdicao)...[

                // FOTO
                InkWell(onTap: () async  {

                  final picker = ImagePicker();
                  final imagem = await picker.pickImage(source: ImageSource.gallery);

                  if(imagem == null){
                    return;
                  }

                  final url = await Usuarioservice().uploadFoto(imagem);

                  if (url != null) {
                    setState(() {
                      widget.usuario?.fotoUrl = url;
                    });
                  }

                },

                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                    width: height * 0.15,
                    height: height * 0.15,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: widget.usuario?.fotoUrl != null
                        ? ClipOval(
                      child: Image.network(
                        widget.usuario!.fotoUrl!,
                        width: height * 0.15,
                        height: height * 0.15,
                        fit: BoxFit.cover,
                      ),
                    )
                        : Icon(Icons.person, size: 50),

                  ),
                ),


              ],


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
                enabled: !modoEdicao,
                validator: (value) {

                  if (modoEdicao) {
                    return null;
                  }

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
                enabled: !modoEdicao,
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

              //só vai aparecer se for cadastrar
              if(!modoEdicao) ... [

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



              ],

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

                      bool sucesso;

                      if(modoEdicao){
                        sucesso = await Usuarioservice().atualizar(usuario);
                      } else{
                        sucesso = await Usuarioservice().cadastrar(usuario);
                      }

          
                     if(sucesso){
                       Navigator.pop(context, usuario);
                     }else {
                       print("Erro ao cadastrar");
                     }
          
          
                    },

                    child: Text(
                    modoEdicao ? "Atualizar" : "Cadastrar",
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
      {bool isPassword = false, bool enabled = true, String? Function(String?)? validator}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.1, vertical: 4),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        enabled: enabled,
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