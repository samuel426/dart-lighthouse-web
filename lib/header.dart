import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('등대'),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
        ),
        IconButton(
          icon: const Icon(Icons.info),
          onPressed: () {
            Navigator.pushNamed(context, '/introduction');
          },
        ),
        IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: () {
            Navigator.pushNamed(context, '/calendar');
          },
        ),
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {
            Navigator.pushNamed(context, '/notice');
          },
        ),
        IconButton(
          icon: const Icon(Icons.forum),
          onPressed: () {
            Navigator.pushNamed(context, '/free');
          },
        ),
        IconButton(
          icon: const Icon(Icons.contact_mail),
          onPressed: () {
            Navigator.pushNamed(context, '/inquiry');
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
