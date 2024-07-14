# 풀스택 프로그래밍 프로젝트

동아리 홈페이지 사이트 제작

## 서버 소스코드

해당 프로젝트는 **dart/ alfred**로 제작되었습니다.

### 소스코드 설명

**main.dart**

- client가 login에 요청을 보내면 해당하는 요청에 따른 결과를 보내줌
- client가 signup에 요청을 보내면 해당하는 요청에 따른 결과를 보내줌
- user.json에 user의 데이터를 저장함

json 양식은 다음과 같음

```
[
  {
    "email": "samuel2626@naver.com",
    "name": "우성현",
    "password": "admin1234",
    "joinYear": 2020,
    "generation": 42,
    "memberType": "YB"
  },
  {
    "email": "test@example.com",
    "name": "테스트",
    "password": "1234",
    "joinYear": 2021,
    "generation": 43,
    "memberType": "YB"
  }
]

```
