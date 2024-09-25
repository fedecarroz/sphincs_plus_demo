import 'package:flutter/material.dart';

class CustomBottomNavbar extends StatelessWidget {
  final int currentIndex;
  final void Function(int)? onTap;

  const CustomBottomNavbar({
    super.key,
    this.currentIndex = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      unselectedItemColor: Colors.black45,
      showUnselectedLabels: true,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.key),
          label: 'Key gen',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.edit),
          label: 'Message',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.edit_document),
          label: 'Sign',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.check),
          label: 'Verify',
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: Colors.orange[800],
      onTap: onTap,
    );
  }
}
