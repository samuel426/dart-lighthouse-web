import 'package:alfred/alfred.dart';

void main() async {
  final app = Alfred();

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
    final body = await req.bodyAsJsonMap;
    final email = body['email'];
    final password = body['password'];

    if (email == 'test@example.com' && password == 'password') {
      print('Login successful for $email');
      return {'token': 'your_jwt_token_here'};
    } else {
      res.statusCode = 401;
      print('Login failed for $email');
      return {'error': 'Invalid credentials'};
    }
  });

  app.post('/api/signup', (req, res) async {
    final body = await req.bodyAsJsonMap;
    final email = body['email'];
    final name = body['name'];
    final password = body['password'];
    final int joinYear = int.parse(body['joinYear']);
    final int generation = joinYear - 1979 + 1;

    // 회원가입 로직 추가 (예: 데이터베이스에 사용자 추가)
    // 여기서는 예제로 바로 토큰을 반환합니다.
    print('Signup successful for $email');
    return {'token': 'your_jwt_token_here', 'generation': generation};
  });

  await app.listen(8080);
  print('Server listening on port 8080');
}
