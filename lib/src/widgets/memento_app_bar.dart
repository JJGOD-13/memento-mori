import 'package:flutter/material.dart';

class MementoAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool renderSettings;
  final VoidCallback? onSettingsPressed;

  const MementoAppBar({
    super.key,
    required this.renderSettings,
    this.onSettingsPressed,
  });
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Memento Mori"),
      centerTitle: true,
      backgroundColor: Colors.black,
      elevation: 0,
      leading:
          renderSettings ? _SettingsButton(onPressed: onSettingsPressed) : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SettingsButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const _SettingsButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return DrawerButton(
          color: Colors.white,
          onPressed: () {
            try {
              if (Scaffold.of(context).hasDrawer) {
                Scaffold.of(context).openDrawer();
              } else {
                throw Exception("No Drawer to open");
              }
            } catch (e) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("$e")));
            }
          }
          // () {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     const SnackBar(
          //       content: Text("Bruhhhhh"),
          //     ),
          //   );
          // },
          );
    });
  }
}
