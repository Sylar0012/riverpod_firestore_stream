import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_firestore_stream/domain/chat/chat_controller.dart';
import 'package:riverpod_firestore_stream/domain/chat/chat_firestore_repository.dart';
import 'package:riverpod_firestore_stream/dto/chat/chat_req_dto.dart';

class ChatRoomPage extends ConsumerWidget {
  const ChatRoomPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatController = ref.read(chatControllerProvider);
    final chatStream = ref.read(chatStreamProvider);
    return Scaffold(
      appBar: _bulidAppBar(),
      body: _buildListView(ref),
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

  Widget _buildListView(WidgetRef ref) {
    final chatStream = ref.watch(chatStreamProvider);
    return chatStream.when(
      data: (chats) {
        if (chats.isNotEmpty) {
          return ListView.separated(
            itemCount: chats.length,
            itemBuilder: (context, index) => ListTile(
              title: Text("msg : ${chats[index].msg}"),
              subtitle: Text("from : ${chats[index].from}"),
            ),
            separatorBuilder: (context, index) => Divider(),
          );
        } else {
          return Center(
            child: Text("채팅 내역 없음"),
          );
        }
      },
      error: (error, stackTrace) => CircularProgressIndicator(),
      loading: () => CircularProgressIndicator(),
    );
  }
}
