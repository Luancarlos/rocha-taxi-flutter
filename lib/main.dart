import 'package:flutter/material.dart';

import 'package:taxirocha/pages/MapPage/mapPage.dart';
import 'package:taxirocha/util.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: primaryColor,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final double height = MediaQuery.of(context).size.height;
    final double width  = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: <Widget>[
            Image.asset("assets/images/map.jpg"),
            RichText(
              text: TextSpan(
                text: 'TAXI ',
                style: new TextStyle(fontSize: 45, color: primaryColor, fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(text: 'ROCHA', style: TextStyle(color: Colors.black)),
                ],
              ),
            ),
            SizedBox(height: 30),
            Text('Só mais um aplicativo de mobilidade urbana'),
            SizedBox(height: height * 0.35),
            Text('Seja Bem-vindo!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w100),),
            SizedBox(height: 25.0),
            ButtonTheme(
              minWidth: width * 0.7,
              height: 55,
              child: RaisedButton(
                elevation: 0,
                color: primaryColor,
                onPressed: () {
                  Navigator.push(context, PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 1000),
                      pageBuilder: (context, _, __) => MapPage()));
                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                child: Text('início', style: TextStyle(fontSize: 18),),
              ),
            )
          ],
        ),
      ),
    );
  }


}

