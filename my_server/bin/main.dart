import 'dart:convert';
import 'dart:io';
import 'package:alfred/alfred.dart';

void main() async {
  final app = Alfred();

  app.all('/*', (req, res) async {
    res.headers.add('Access-Control-Allow-Origin', '*');
    res.headers
        .add('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
    res.headers
        .add('Access-Control-Allow-Headers', 'Content-Type, Authorization');
    if (req.method == 'OPTIONS') {
      res.statusCode = HttpStatus.noContent;
      await res.close();
      return;
    }
  });

  app.post('/api/login', (req, res) async {
    try {
      final bodyString = await utf8.decoder.bind(req).join();
      final body = jsonDecode(bodyString) as Map<String, dynamic>;
      final email = body['email'];
      final password = body['password'];

      final users = await getUsersFromJson();

      final user = users.firstWhere(
        (user) => user['email'] == email && user['password'] == password,
        orElse: () => {},
      );

      if (user != null && user.isNotEmpty) {
        res.json({'token': 'your_jwt_token_here', 'user': user});
      } else {
        res.statusCode = HttpStatus.unauthorized;
        res.json({'status': 'error', 'message': 'Invalid credentials'});
      }
    } catch (e) {
      res.statusCode = HttpStatus.internalServerError;
      res.json({'status': 'error', 'message': 'Server error'});
    }
  });

  app.post('/api/signup', (req, res) async {
    try {
      final bodyString = await utf8.decoder.bind(req).join();
      final body = jsonDecode(bodyString) as Map<String, dynamic>;
      final email = body['email'];
      final name = body['name'];
      final password = body['password'];
      final joinYear = body['joinYear'];
      final memberType = body['memberType'];
      final generation = DateTime.now().year - 1978;

      final users = await getUsersFromJson();
      users.add({
        'email': email,
        'name': name,
        'password': password,
        'joinYear': joinYear,
        'generation': generation,
        'memberType': memberType
      });

      await saveUsersToJson(users);

      res.json(
          {'status': 'success', 'message': 'User registered successfully'});
    } catch (e) {
      res.statusCode = HttpStatus.internalServerError;
      res.json({'status': 'error', 'message': 'Server error'});
    }
  });

  app.get('/api/user_info', (req, res) async {
    final token = req.headers.value('Authorization')?.split(' ').last;

    if (token == 'your_jwt_token_here') {
      // 실제 사용자 정보를 반환합니다.
      final user = {
        'email': 'example@example.com',
        'name': '사용자 이름',
        'joinYear': 2020,
        'generation': 42,
        'memberType': 'YB',
      };
      res.json(user);
    } else {
      res.statusCode = 401;
      res.json({'error': 'Unauthorized'});
    }
  });

  await app.listen(8080);
  print('Server listening on port 8080');
}

Future<List<Map<String, dynamic>>> getUsersFromJson() async {
  final file = File('bin/user.json');
  if (await file.exists()) {
    final content = await file.readAsString();
    return List<Map<String, dynamic>>.from(jsonDecode(content));
  }
  return [];
}

Future<void> saveUsersToJson(List<Map<String, dynamic>> users) async {
  final file = File('bin/user.json');
  await file.writeAsString(jsonEncode(users));
}
