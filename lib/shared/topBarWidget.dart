import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../DTO/UsuarioDTO.dart';

class TopBarWidget extends StatelessWidget {


  const TopBarWidget({super.key});

  @override
  Widget build(BuildContext context) {


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
              child: Icon(
                Icons.menu,
                size: 40,
                color: Colors.white,
              ),
            ),
          ),

        ],
      ),
    );
  }
}