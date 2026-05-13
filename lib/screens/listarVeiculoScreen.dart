import 'package:flutter/material.dart';
import 'package:projeto_integrador/DTO/UsuarioDTO.dart';
import 'package:projeto_integrador/services/usuarioService.dart';
import 'package:projeto_integrador/services/veiculoService.dart';
import 'package:projeto_integrador/shared/botaoAdicionar.dart';
import 'package:projeto_integrador/shared/botaoCancelar.dart';
import 'package:projeto_integrador/shared/cardVeiculo.dart';

import '../DTO/VeiculoDTO.dart';
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

  String? marcaSelecionada;
  String? modeloSelecionado;





  final VeiculoService veiculoService = VeiculoService();
  final Usuarioservice usuarioservice = Usuarioservice();

  List<VeiculoDTO> veiculos = [];

  int indexPrincipal = 0;


  @override
  void initState() {
    super.initState();

    carregarVeiculos();
  }

  //ordena com o principal sempre em primeiro
  Future<void> carregarVeiculos() async {

    final lista = await veiculoService.listarVeiculos();

    int principal = 0;

    for (int i = 0; i < lista.length; i++) {

      if (lista[i].idVeiculo ==
          widget.usuario.idVeiculoPrincipal) {

        principal = i;
        break;
      }
    }

    // move o veículo principal para primeira posição
    final veiculoPrincipal = lista.removeAt(principal);

    lista.insert(0, veiculoPrincipal);

    setState(() {

      veiculos = lista;

      indexPrincipal = 0;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.black,

      body: SafeArea(
        child: Column(
          children: [

            TopBarWidget(usuario: widget.usuario),


            SaldoCard(
                saldo: widget.usuario!.saldo ?? 0,
                onPressed: () => abrirModalRecarga(context)
            ),

            SizedBox(height: 60,),

            Text(

              'Selecione seu veículo principal',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 60,),

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
                    padding: const EdgeInsets.only(left: 20),
                    child: Cardveiculo(
                      nomeVeiculo: veiculo.modeloCarro,
                      modeloVeiculo: veiculo.nomeMarca,
                      cor: index == indexPrincipal ?
                      AppColors.principal : Colors.white,

                      //troca o veiculo principal
                      onPressed: () async {

                        await usuarioservice.atualizarVeiculoPrincipal(veiculo.idVeiculo!);


                        setState(() async {

                          indexPrincipal = index;

                          widget.usuario.idVeiculoPrincipal = veiculo.idVeiculo;

                          await carregarVeiculos();

                        });

                        print(

                          "Principal: ${veiculo.modeloCarro}",

                        );
                      },

                      onDelete: () async {

                        await veiculoService.deletar(veiculo.idVeiculo!,);

                        await carregarVeiculos();

                    },

                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 40,),

            BotaoAdicionar(usuarioDTO: widget.usuario,),
            SizedBox(height: 10,),
            BotaoCancelar(),

          ],
        ),
      ),


    );
  }
}