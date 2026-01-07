import 'package:flutter/material.dart';
import 'package:news_app/views/login_view.dart';
import 'package:news_app/views/setting_view.dart';
import 'package:news_app/views/sign_up_view.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.indigo[900],
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.black),
            child: Center(
              child: Image.asset(
                'assets/icon/barcelona.png',
                width: 70,
                height: 70,
              ),
            ),
          ),
          const Divider(
            color: Colors.black,
            indent: 5,
            endIndent: 5,
            thickness: 2,
          ),
          _DrawerItem(
            title: 'Login',
            icon: Icons.login_sharp,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const LoginView()),
              );
            },
          ),
          _DrawerItem(
            title: 'Join us',
            icon: Icons.group_add,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SignUpView()),
              );
            },
          ),
          _DrawerItem(
            title: 'Settings',
            icon: Icons.settings,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SettingView()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 22),
      ),
      trailing: Icon(icon, color: Colors.white, size: 26),
      hoverColor: Colors.lime,
      onTap: onTap,
    );
  }
}
