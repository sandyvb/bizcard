import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mi_card/screens/loading_screen.dart';
import 'package:mi_card/screens/micard_screen.dart';
import 'package:mi_card/screens/update_screen.dart';
import 'package:mi_card/services/controller.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  final Controller c = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    // SET SYSTEM ORIENTATION AND STATUS BAR
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // TRANSPARENT STATUS BAR
    ));

    // GET FILE AND UPDATE DATA OR GO TO UPDATE SCREEN
    getApplicationDocumentsDirectory().then((Directory directory) async {
      File jsonFile = File(directory.path + "/" + c.fileName.value);
      c.fileExists.value = jsonFile.existsSync();
      if (!c.fileExists.value) {
        Get.to(UpdateScreen());
      } else {
        c.fileContent.value = await jsonDecode(jsonFile.readAsStringSync());
        await c.updateDataFromFile();
        Get.to(MiCardScreen());
      }
    });

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MiCard',
      theme: ThemeData(
        fontFamily: 'RedHat',
        unselectedWidgetColor: Color(c.buttonColor.value),
        toggleableActiveColor: Color(c.buttonColor.value),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(c.borderRadius.value),
          ),
        ),
      ),
      home: LoadingScreen(),
    );
  }
}
