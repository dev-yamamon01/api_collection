import 'package:flutter/material.dart';

class WeatherAPI extends StatelessWidget {
  const WeatherAPI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text('天気API'),
      ),
      body: Center(
        child: Column(
          children: [
            Text("天気APIです"),
          ]
        ),
      ),
    );
  }
}
