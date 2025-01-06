import 'package:flutter/material.dart';

//String state="https://api.openweathermap.org/data/2.5/weather?q=tokyo&units=metric&lang=ja&appid=daa2ce4d8e74ca54914d85a3b63f74ca";

void main() {
  runApp(const WeatherAPI());
}

class WeatherAPI extends StatelessWidget {
  const WeatherAPI ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Collection',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const WeatherPage(title: '天気API'),
    );
  }
}


class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key, required this.title});
  final String title;

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  TextEditingController controller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(children: [

          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
              TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                onChanged: (city) {
                  if (city.isNotEmpty) {
                    //loadweather(city);
                  }
                },
              ),
          ),

        ]),
      ),
    );
  }
}

