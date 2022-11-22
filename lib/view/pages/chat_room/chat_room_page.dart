import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_firestore_stream/domain/chat/chat_controller.dart';
import 'package:riverpod_firestore_stream/dto/chat/chat_req_dto.dart';

class ChatRoomPage extends ConsumerWidget {
  const ChatRoomPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatController = ref.read(chatControllerProvider);
    return Scaffold(
      appBar: _bulidAppBar(),
      body: _bulidListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Random random = Random();
          ChatInsertReqDto dto = ChatInsertReqDto(from: "ssar", to: "cos", msg: "hello - ${random.nextInt(100)}");
          chatController.insert(dto);
        },
        child: Icon(Icons.add),
      ),
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
