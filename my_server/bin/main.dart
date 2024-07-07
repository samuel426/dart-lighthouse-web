import 'package:alfred/alfred.dart';

void main() async {
  final app = Alfred();

  // 기본 라우트
  app.get('/', (req, res) {
    return {'message': 'Hello, World!'};
  });

  // 로그인 라우트 예시
  app.post('/api/login', (req, res) async {
    final body = await req.bodyAsJsonMap;
    final email = body['email'];
    final password = body['password'];

    // 여기서 실제 인증 로직을 수행합니다. (예: 데이터베이스와 비교)
    if (email == 'test@example.com' && password == 'password') {
      return {'token': 'your_jwt_token_here'};
    } else {
      res.statusCode = 401;
      return {'error': 'Invalid credentials'};
    }
  });

  // 서버 시작
  await app.listen(8080);
  print('Server listening on port 8080');
}
