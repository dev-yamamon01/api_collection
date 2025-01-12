import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const PostAPI());
}

class PostAPI extends StatelessWidget {
  const PostAPI({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Collection',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: '郵便番号API'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  TextEditingController controller=TextEditingController();
  List<String> items=[];
  String errorMessage="";

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> loadZipCode(String zipCode) async{
    setState(() {
      errorMessage='APIレスポンス待ち';
    });

    final response=await http.get(Uri.parse('https://zipcloud.ibsnet.co.jp/api/search?zipcode=$zipCode'));

    if (response.statusCode != 200) {
      return;
    }
    final body=json.decode(response.body) as Map<String, dynamic>;
    final results=(body['results'] ?? [])as List<dynamic>;

    if (results.isEmpty) {
      setState(() {
        errorMessage = 'そのような郵便番号はありません';
      });
    } else {
      setState(() {
        errorMessage = '';
        items = results.map((result) =>
        "${result['address1']}${result['address2']}${result['address3']}")
            .toList(growable: false);
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'ここに郵便番号を入力',
              ),
              controller: controller,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  loadZipCode(value);
                }
              },
            ),
          ),
          Expanded(
            child: errorMessage.isNotEmpty
                ? Center(
                    child: Text(errorMessage),
                  )
                : ListView.builder(
                    itemBuilder: (context, index) {
                      return ListTile(title: Text(items[index]));
                    },
                    itemCount: items.length,
                  ),
          )
        ],
      ),
    );
  }
}
