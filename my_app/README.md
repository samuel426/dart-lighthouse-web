# 풀스택 프로그래밍 프로젝트

동아리 홈페이지 사이트 제작

## 클라이언트 소스코드

해당 프로젝트는 **dart flutter**로 제작되었습니다.

### 소스코드 설명

**main.dart**

- 홈페이지 라우터 설정
- 홈페이지 테마 설정
- 앱 실행

**header.dart**

- 홈페이지 헤더 부분
- 다른 링크로 이동
- 로그인시 헤더 변경됨

**footer.dart**

- 홈페이지 footer 부분

**auth_provider.dart**

- 로그인 / 로그아웃 상태 관리
- 클라이언트가 서버에게 요청을 보냄

**theme.dart**

- 홈페이지 테마 작성 부분
- main.dart로 import해서 사용

**/pages/**

- header와 footer 공유

**/pages/home.dart**

- 홈 화면 출력
- 인스타 링크 버튼 있음
- 데모 버전 최근 게시글 모음 있음

**/pages/login.dart**

- 로그인 화면

**/pages/signup.dart**

- 회원가입 화면
- 사용자 정보 입력 후 회원가입 버튼 누르면
- 서버의 user.json 파일에 데이터 저장

**/pages/user_info.dart**

- 로그인한 유저 정보 출력
- 서버에게 받은 나머지 유저 데이터 출력

**/pages/calendar.dart**

- 동아리 일정 소개 페이지
- 프로토타입 버전만 구현

### 미개발 페이지

- /pages/free_board.dart (자유 게시판)
- /pages/inquiry_board.dart (문의사항 페이지)
- /pages/notice_board.dart (공지사항 게시판)
- /pages/introduction.dart (동아리 소개)
