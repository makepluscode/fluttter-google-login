import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Login Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  Future<void> _handleSignIn(BuildContext context) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId:
            '840046869680-nsodunm9imla0l21v0j665b7afeeouk4.apps.googleusercontent.com',
        scopes: [
          'email',
          'profile',
        ],
      );

      final GoogleSignInAccount? account = await googleSignIn.signIn();

      if (account != null) {
        // 로그인 성공, 사용자 정보 페이지로 이동
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => UserInfoPage(user: account),
          ),
        );
      }
    } catch (error) {
      print('로그인 에러: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('로그인 중 오류가 발생했습니다.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google 로그인 데모'),
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          onPressed: () => _handleSignIn(context),
          child: const Text(
            'Google로 로그인',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}

class UserInfoPage extends StatelessWidget {
  final GoogleSignInAccount user;

  const UserInfoPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('사용자 정보'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(user.photoUrl ?? ''),
            ),
            const SizedBox(height: 16),
            Text(
              '이름: ${user.displayName}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              '이메일: ${user.email}',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
