import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopBarWidget extends StatelessWidget {




  const TopBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: 80,

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
                backgroundImage: NetworkImage(
                  "https://via.placeholder.com/150",
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}