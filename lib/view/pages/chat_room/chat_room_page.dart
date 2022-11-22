import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatRoomPage extends StatelessWidget {
  const ChatRoomPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _bulidAppBar(),
      body: _bulidListView(),
    );
  }

  AppBar _bulidAppBar() {
    return AppBar(
      title: Text("riverpod & firestore & stream"),
    );
  }

  ListView _bulidListView() {
    return ListView.separated(
        itemBuilder: (context, index) => ListTile(
              title: Text("안녕"),
              subtitle: Text("from : ssar"),
            ),
        separatorBuilder: (context, index) => Divider(),
        itemCount: 2);
  }
}
