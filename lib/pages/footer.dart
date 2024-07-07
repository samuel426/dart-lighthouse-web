import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(height: 1, color: Colors.black), // 구분선 추가
        Container(
          color: Colors.white, // 배경색을 하얀색으로 설정
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Image.asset(
                    'assets/icon1_cropped.png', // Add your image to the assets folder and provide the correct path
                    height: 100,
                    width: 100,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text('동아리방 위치',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              const Text('경희대학교 학생회관 516호',
                  style: TextStyle(color: Colors.black)),
              const Text('경기 용인시 기흥구 덕영대로 1732',
                  style: TextStyle(color: Colors.black)),
              const Text('17104', style: TextStyle(color: Colors.black)),
            ],
          ),
        ),
      ],
    );
  }
}
