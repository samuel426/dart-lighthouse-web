import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../auth_provider.dart';
import '../header.dart';
import '../footer.dart';

class UserInfoPage extends StatelessWidget {
  const UserInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userInfo = authProvider.userInfo;

    return Scaffold(
      appBar: const Header(),
      body: Center(
        child: userInfo.isNotEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Email: ${userInfo['email']}'),
                  Text('Name: ${userInfo['name']}'),
                  Text('Join Year: ${userInfo['joinYear']}'),
                  Text('Generation: ${userInfo['generation']}'),
                  Text('Member Type: ${userInfo['memberType']}'),
                ],
              )
            : const Text('No user information available'),
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
