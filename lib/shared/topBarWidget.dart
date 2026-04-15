import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopBarWidget extends StatelessWidget {




  const TopBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20,
        top: 40,
        bottom: 16),



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

                child: Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.black,
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}