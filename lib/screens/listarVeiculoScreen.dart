import 'package:flutter/material.dart';
import 'package:projeto_integrador/DTO/UsuarioDTO.dart';
import 'package:projeto_integrador/services/usuarioService.dart';
import 'package:projeto_integrador/services/veiculoService.dart';
import 'package:projeto_integrador/shared/botaoAdicionar.dart';
import 'package:projeto_integrador/shared/botaoCancelar.dart';
import 'package:projeto_integrador/shared/cardVeiculo.dart';

import '../DTO/VeiculoDTO.dart';
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


  final VeiculoService veiculoService = VeiculoService();
  final Usuarioservice usuarioService = Usuarioservice();
  List<VeiculoDTO> veiculos = [];


  @override
  void initState() {
    super.initState();

    carregar();
  }

  Future<void> carregar() async {

    veiculos = await veiculoService.listarVeiculos();

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

            TopBarWidget(),


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
                itemCount: veiculos.length,
                itemBuilder: (context, index) {
                  final veiculo = veiculos[index];

                  return Padding(
                    padding: const EdgeInsets.only(left: 2),
                    child: Cardveiculo(
                      nomeVeiculo: veiculo.modeloCarro,
                      modeloVeiculo: veiculo.nomeMarca,
                      cor: veiculo.idVeiculo == widget.usuario.idVeiculoPrincipal ?
                      AppColors.principal : Colors.white,
                      principal: veiculo.idVeiculo == widget.usuario.idVeiculoPrincipal,

                      //troca o veiculo principal
                      onPressed: () async {

                        await usuarioService.atualizarVeiculoPrincipal(veiculo.idVeiculo!);

                        widget.usuario.idVeiculoPrincipal = veiculo.idVeiculo;

                        await carregar();

                        print(

                          "Principal: ${veiculo.modeloCarro}",

                        );
                      },

                      onDelete: () async {

                        await veiculoService.deletar(veiculo.idVeiculo!,);

                        await carregar();

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