import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(children: [
        ListTile(
          leading: const Icon(
            Icons.notifications,
          ),
          title: const Text(
            "Notifications",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          trailing: IconButton(
              icon: Switch(
                  value: true, activeColor: Colors.grey, onChanged: (bol) {}),
              onPressed: () {}),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.privacy_tip),
          title: Text(
            'Privacy Policies',
            style: TextStyle(fontSize: 20),
          ),
          subtitle: Text('User data safe with this application '),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.verified_sharp),
          title: Text('Version'),
          subtitle: Text('1.7.1'),
        ),
        Divider(),
        ListTile(
          onTap: () => {},
          leading: Icon(Icons.confirmation_num),
          title: Text('Terms and conditions'),
          subtitle: Text('view more'),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.info),
          onTap: () => showAboutDialog(
              applicationIcon: Image.asset(
                'assests/images/Splash_screen.png',
                width: 70,
                height: 70,
              ),
              context: context,
              applicationName: 'Musion',
              applicationVersion: '1.7',
              children: [
                Text("Musion is a Offline Music Player Created by Athul"),
              ]),
          title: Text(
            'About',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ]),
    );
  }
}
