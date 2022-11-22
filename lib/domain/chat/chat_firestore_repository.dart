import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_firestore_stream/domain/chat/chat.dart';
import 'package:riverpod_firestore_stream/dto/chat/chat_req_dto.dart';

// 리턴 : Stream<List<Chat>>
final chatStreamProvider = StreamProvider.autoDispose<List<Chat>>((ref) {
  // 목적 : 스트림을 리턴하는 것 ( chat에 연결된 선을 파싱해서 넘겨 줌 )
  // 1. DB에 붙어서 스냅샷을 꺼내옴
  Stream<QuerySnapshot<Map<String, dynamic>>> stream = FirebaseFirestore.instance.collection("chat").snapshots();
  // 2. QuerySnapshot의 Map 타입 stream 완성.

  // 3. QuerySnapshot<Map<String, dynamic>>을 파싱하는 과정 ( 안하면 화면에서 파싱해야함 ) -> 화면은 Entity나 Dto를 쓰는게 편함.
  return stream.map((snapshots) => snapshots.docs.map((doc) => Chat.fromJson(doc.data(), doc.id)).toList());
  // Stream으로 map 타입이 흘러옴 -> Stream 안에 있는 파일을 파싱해서 Chat Entity로 만들었다.

  //QuerySnapshot : Snapshot은 비동기로 실제 서버 데이터를 가져온 내용물임. 컬랙션으로 들고와서 하나씩 까봐야 함

  //ref.onDispose(() { }); 화면을 죽일때 할 행동을 지정 ( 누구 나갔다 같은거 )
  //ref.Resume(() {} ); 화면이 죽었다가 다시 띄워질때 할 행동을 지정
});

// Provider ( 메모리에 띄우기 위한 Provider )
// New가 된게 아니고 chatFireStoreRespositoryProvider 에 Provider의 ref를 들고있는거.
// 호출시 ref를 쓰는거
final chatFireStoreRespositoryProvider = Provider((ref) {
  return ChatFireStoreRepository();
});

//통신과 파싱의 역할
class ChatFireStoreRepository {
  final db = FirebaseFirestore.instance;

  Future<DocumentReference> insert(ChatInsertReqDto dto) {
    return db.collection("chat").add(dto.toJson());
  }
}
