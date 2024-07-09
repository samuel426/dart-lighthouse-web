import 'package:alfred/alfred.dart';
import 'dart:convert';
import 'dart:io';

void main() async {
  final app = Alfred();

  // 사용자 데이터 파일 경로 설정
  final String userFilePath = 'bin/user.json';

  // CORS 설정 추가
  app.all('*', (req, res) async {
    res.headers.add('Access-Control-Allow-Origin', '*');
    res.headers
        .add('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, DELETE');
    res.headers.add(
        'Access-Control-Allow-Headers', 'Origin, Content-Type, X-Auth-Token');
    if (req.method == 'OPTIONS') {
      res.statusCode = 200;
      await res.close();
    }
  });

  app.get('/', (req, res) {
    return {'message': 'Hello, World!'};
  });

  app.post('/api/login', (req, res) async {
    try {
      final body = await req.bodyAsJsonMap;
      final email = body['email'];
      final password = body['password'];

      final File file = File(userFilePath);
      if (await file.exists()) {
        final contents = await file.readAsString();
        final users = jsonDecode(contents) as List<dynamic>;
        final user = users.firstWhere(
          (user) => user['email'] == email && user['password'] == password,
          orElse: () => null,
        );

        if (user != null) {
          print('Login successful for $email');
          res.json({'token': 'your_jwt_token_here'});
        } else {
          res.statusCode = 401;
          print('Login failed for $email');
          res.json({'error': 'Invalid credentials'});
        }
      } else {
        res.statusCode = 401;
        print('User file not found for $email');
        res.json({'error': 'Invalid credentials'});
      }
    } catch (e) {
      print('Error during login: $e');
      res.statusCode = 500;
      res.json({'error': 'Login failed', 'details': e.toString()});
    }
  });

  app.post('/api/signup', (req, res) async {
    try {
      final body = await req.bodyAsJsonMap;
      final email = body['email'];
      final name = body['name'];
      final password = body['password'];
      final int joinYear = int.parse(body['joinYear']);
      final String memberType = body['memberType'];
      final int generation = joinYear - 1979 + 1;

      final File file = File(userFilePath);
      List<dynamic> users = [];

      if (await file.exists()) {
        final contents = await file.readAsString();
        users = jsonDecode(contents) as List<dynamic>;
      }

      users.add({
        'email': email,
        'name': name,
        'password': password,
        'joinYear': joinYear,
        'generation': generation,
        'memberType': memberType,
      });

      await file.writeAsString(jsonEncode(users));

      print('Signup successful for $email');
      res.json({'token': 'your_jwt_token_here'});
    } catch (e) {
      print('Error during signup: $e');
      res.statusCode = 500;
      res.json({'error': 'Signup failed', 'details': e.toString()});
    }
  });

  await app.listen(8080);
  print('Server listening on port 8080');
}
