// This widget is the root of your application.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_integrador/screens/loginScreen.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

@override
Widget build(BuildContext context) {
  return MaterialApp(
    title: 'UFSM Charge',
    theme: ThemeData(

      colorScheme: .fromSeed(seedColor: Colors.deepPurple),
    ),
    home: LoginScreen(),
  );
}
}