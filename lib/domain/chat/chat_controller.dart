import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_firestore_stream/core/routes_enum.dart';
import 'package:riverpod_firestore_stream/domain/chat/chat_firestore_repository.dart';
import 'package:riverpod_firestore_stream/dto/chat/chat_req_dto.dart';

//Provider ( 메모리에 띄우기 위한 Provider )
final chatControllerProvider = Provider((ref) {
  return ChatController(ref);
});

class ChatController {
  Ref _ref;
  ChatController(this._ref);

  void insert(ChatInsertReqDto dto) {
    Future<DocumentReference> futureDoc = _ref.read(chatFireStoreRespositoryProvider).insert(dto);
    futureDoc.then(
      (value) {
        print("document id : ${value.id}");
        // 화면 이동
        // Navigator.pushNamed(context, Routes.login.path);
        // Navigator.popAndPushNamed(context, Routes.login.path);
        // Navigator.pop(context);
        // Navigator.pushNamedAndRemoveUntil(context, Routes.login.path, (route) => false);
      },
    ).onError(
      (error, stackTrace) {
        print("error : ${error}");
        // 경고창 (에러 메세지)
      },
    );
  }
}
