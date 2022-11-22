import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_firestore_stream/firebase_options.dart';
import 'package:riverpod_firestore_stream/view/pages/chat_room/chat_room_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 메인 메서드에 비동기 작입어 있으면 꼭 필요함.
  // 내부가 퓨처로 되어있어서 걸어야함.
  // 실제 ios와 android가 실행됨.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    // 위젯에서 프로바이더를 사용하고 읽기 위해 앱 전체적으로 ProviderScope 위젯을 감싸줘야 함.
    // 여기에 프로바이더의 상태가 저장됨.
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatRoomPage(),
    );
  }
}
