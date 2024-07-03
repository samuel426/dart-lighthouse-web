import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.camera_alt), // Instagram icon placeholder
            onPressed: () {
              // Instagram link action
            },
          ),
          Image.asset(
            'icon1.png', // Add your image to the assets folder and provide the correct path
            height: 50,
            width: 50,
          ),
        ],
      ),
    );
  }
}
