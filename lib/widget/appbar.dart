import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 2,
      backgroundColor: Colors.white,
      title: SizedBox(
        width: double.infinity,
        height: 56,
        child: Image.asset('assets/images/appbar.png'),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
