import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: GestureDetector(
        onTap: () {
          Navigator.pushReplacementNamed(context, '/');
        },
        child: Text('등대'),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.info),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/introduction');
          },
        ),
        IconButton(
          icon: Icon(Icons.calendar_today),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/calendar');
          },
        ),
        IconButton(
          icon: Icon(Icons.notifications),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/notice');
          },
        ),
        IconButton(
          icon: Icon(Icons.forum),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/free');
          },
        ),
        IconButton(
          icon: Icon(Icons.contact_mail),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/inquiry');
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
