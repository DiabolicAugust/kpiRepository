import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:unidev/screens/main_screen.dart';
import 'package:unidev/tools/constants.dart';
import 'package:unidev/tools/key_values.dart';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(1080, 2400),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Constants.mainColor,
            title: Text('Link Formatter'),
          ),
          body: HomePage(),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                 DrawerHeader(
                  decoration: BoxDecoration(
                    color: Constants.mainColor,
                  ),
                  child: Text('DLink Formatter'),
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: const Text('HomeScreen'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.help),
                  title: const Text('Help'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
