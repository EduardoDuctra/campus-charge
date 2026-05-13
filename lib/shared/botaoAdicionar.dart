import 'package:flutter/material.dart';

class BotaoCancelar extends StatelessWidget {
  const BotaoCancelar({super.key});

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.1),

      child: SizedBox(
        width: width * 0.7,
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
    );
  }
}