import 'package:flutter/material.dart';

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text('アカウント設定'),
      ),
      body: Center(
        child: Column(
            children: [
              Text("アカウント設定です"),
            ]
        ),
      ),
    );
  }
}
