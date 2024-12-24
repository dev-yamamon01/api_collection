import 'package:flutter/material.dart';

class PokeAPI extends StatelessWidget {
  const PokeAPI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text('ポケモンAPI'),
      ),
      body: Center(
        child: Column(
            children: [
              Text("ポケモンAPIです"),
            ]
        ),
      ),
    );
  }
}
