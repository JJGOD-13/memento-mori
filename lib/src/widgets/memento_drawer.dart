import 'package:flutter/material.dart';
import 'package:memento_mori/main.dart';
import 'package:url_launcher/url_launcher.dart';

class MementoDrawer extends StatelessWidget {
  const MementoDrawer({super.key});
  final url = "https://github.com/JJGOD-13/memento-mori";

  Future<void> _launchURL() async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw "COULD NOT LAUNCH $url";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey.shade900,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 150,
            child: DrawerHeader(
              margin: EdgeInsets.zero,
              child: Text(
                "Memento Mori",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: const Text("Settings"),
            onTap: () =>
                Navigator.popAndPushNamed(context, MementoRoutes.input),
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: const Text("About"),
            onTap: _launchURL,
          ),
        ],
      ),
    );
  }
}
