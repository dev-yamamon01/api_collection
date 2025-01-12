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
  String weather="";
  double max_temp=0,min_temp=0,temp=0;
  int humidity=0;

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
              decoration: InputDecoration(
                hintText: '例：tokyo',
                labelText: '都市名', // ラベルとして表示するテキスト
                border: OutlineInputBorder(), // 枠線を追加
              ),
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
                        ListTile(
                          title: Text("天気"),
                          subtitle: Text(weather),
                        ),
                        ListTile(
                          title: Text("気温"),
                          subtitle: Text(temp.toString()+"℃　(↑："+max_temp.toString()+"　↓："+min_temp.toString()+")"),
                        ),
                        ListTile(
                          title: Text("湿度"),
                          subtitle: Text(humidity.toString()+"%"),
                        ),
                      ],
                    ))
        ]),
      ),
    );
  }

  Future<void>loadweather(String city)async {
    setState(() {
      message = "APIレスポンス待ち";
    });

    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&lang=ja&appid=daa2ce4d8e74ca54914d85a3b63f74ca'));
    final body = json.decode(response.body) as Map<String, dynamic>;

    if (response.statusCode != 200 && body.isEmpty) {
      return;
    }

    if (body['message'] == "city not found") {
      setState(() {
        message = "そのような都市は見つかりません";
      });
    } else {
      setState(() {
        message = "";
        //「?」はnullの時は例外にせずそのまま終了、「??」はnullの時に右側の値を代わりに使用
        // 「as String」はdynamicを明示的にStringにキャストしている
        city_name = (body['name'] ?? []);
        weather=(body['weather']?[0]?['description'] ?? '') as String;
        final main=body['main'] as Map<String,dynamic>;
        temp=main['temp'] ?? '';
        max_temp=main['temp_max'] ?? '';
        min_temp=main['temp_min'] ?? '';
        humidity=main['humidity'] ?? '';
      });
    }
  }
}

