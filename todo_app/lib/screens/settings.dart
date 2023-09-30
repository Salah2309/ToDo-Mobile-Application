import 'package:flutter/material.dart';
import 'drawer.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});
  static const String appName = 'Todo List App';
  static const String appVersion = '1.0.0';

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: _appbar(),
      endDrawer: const AppDrawer(),
      backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white70,
      body: Stack(
        children: const [
          Text(appName),
          Text(appVersion)
        ],
      )
    );
  }

  AppBar _appbar(){
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text('Settings'),
    );
  }
}
