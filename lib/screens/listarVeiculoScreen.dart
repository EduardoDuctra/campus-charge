import 'package:flutter/material.dart';
import 'package:projeto_integrador/DTO/UsuarioDTO.dart';
import 'package:projeto_integrador/services/usuarioService.dart';
import 'package:projeto_integrador/services/veiculoService.dart';
import 'package:projeto_integrador/shared/botaoAdicionar.dart';
import 'package:projeto_integrador/shared/botaoCancelar.dart';
import 'package:projeto_integrador/shared/cardVeiculo.dart';

import '../DTO/VeiculoDTO.dart';
import '../controller/veiculoController.dart';
import '../shared/appDrawer.dart';
import '../shared/saldoCard.dart';
import '../shared/topBarWidget.dart';
import '../theme/colors.dart';
import '../utils/modal_recarga.dart';

class ListarVeiculoScreen extends StatefulWidget {

  final UsuarioDTO usuario;

  const ListarVeiculoScreen({super.key, required this.usuario});

  @override
  State<ListarVeiculoScreen> createState() => _ListarVeiculoScreenState();
}

class _ListarVeiculoScreenState extends State<ListarVeiculoScreen> {


  final VeiculoController controller = VeiculoController();

  @override
  void initState() {
    super.initState();

    carregar();
  }

  Future<void> carregar() async {

    await controller.carregarVeiculos(widget.usuario,);

    setState(() {});

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawer: AppDrawer(
        usuario: widget.usuario,),

      backgroundColor: Colors.black,

      body: SafeArea(
        child: Column(
          children: [

            TopBarWidget(usuario: widget.usuario),


            SaldoCard(
                saldo: widget.usuario!.saldo ?? 0,
                onPressed: () => abrirModalRecarga(context)
            ),

            SizedBox(height: 20,),

            Text(

              'Selecione seu veículo principal',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 20,),

            SizedBox(

              height: 260,
              child: ListView.builder(

                padding: const EdgeInsets.symmetric(
                  horizontal: 20,),

                scrollDirection: .horizontal,
                itemCount: controller.veiculos.length,
                itemBuilder: (context, index) {
                  final veiculo = controller.veiculos[index];

                  return Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Cardveiculo(
                      nomeVeiculo: veiculo.modeloCarro,
                      modeloVeiculo: veiculo.nomeMarca,
                      cor: index == controller.indexPrincipal ?
                      AppColors.principal : Colors.white,

                      //troca o veiculo principal
                      onPressed: () async {

                        await controller.usuarioservice.atualizarVeiculoPrincipal(veiculo.idVeiculo!);

                        widget.usuario.idVeiculoPrincipal = veiculo.idVeiculo;

                        await carregar();

                        print(

                          "Principal: ${veiculo.modeloCarro}",

                        );
                      },

                      onDelete: () async {

                        await controller.veiculoService.deletar(veiculo.idVeiculo!,);

                        await controller.carregarVeiculos(widget.usuario);

                    },

                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 20,),

            BotaoAdicionar(usuarioDTO: widget.usuario,),
            SizedBox(height: 10,),
            BotaoCancelar(),

          ],
        ),
      ),


    );
  }
}