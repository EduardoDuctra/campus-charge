import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../DTO/UsuarioDTO.dart';

class TopBarWidget extends StatelessWidget {

  final UsuarioDTO usuario;





  const TopBarWidget({
    super.key, required this.usuario,
  });

  @override
  Widget build(BuildContext context) {

    final fotoUrl=usuario.fotoUrl;
    final temFoto = fotoUrl != null && fotoUrl.isNotEmpty;

    return Container(
      padding: EdgeInsets.only(
        left: 20,
        top: 40,
        bottom: 30),



      child: Row(
        mainAxisAlignment: .spaceBetween,

        children: [

          Builder(
            builder: (context) => GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,

                backgroundImage: temFoto ? NetworkImage(fotoUrl) : null,

                child: !temFoto
                    ? Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.black,
                )
                    : null,
              ),
            ),
          ),

        ],
      ),
    );
  }
}