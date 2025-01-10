import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
  String message="";
  String city_name="";

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
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.text,
              onChanged: (city) {
                if (city.isNotEmpty) {
                  //ここで天気APIを呼ぶ
                  loadweather(city);
                } else {
                  //テキストフィールドが空の時の処理
                  setState(() {
                    message = "";
                  });
                }
              },
            ),
          ),
          Expanded(
              child: message.isNotEmpty
                  ? Center(
                      child: Text(message),
                    )
                  : ListView(
                      children: [
                        ListTile(
                          title: Text("都市名"),
                          subtitle: Text(city_name),
                        ),
                      ],
                    ))
        ]),
      ),
    );
  }

  Future<void>loadweather(String city)async {
    setState(() {
      message="APIレスポンス待ち";
    });

    final response=await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&lang=ja&appid=daa2ce4d8e74ca54914d85a3b63f74ca'));

    if (response.statusCode != 200) {
      return;
    }
    final body=json.decode(response.body) as Map<String, dynamic>;

    setState(() {
      message="";
      city_name=(body['name'] ?? []);
    });
  }

}

