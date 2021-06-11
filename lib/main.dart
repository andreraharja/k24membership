import 'package:flutter/material.dart';

import 'login.dart';

void main() async {
  runApp(MaterialApp(
    theme: ThemeData(primaryColor: Colors.green),
    debugShowCheckedModeBanner: false,
    title: 'K24 Membership Apps',
    home: LoginScreen(),
    //routes: routes,
  ));
}
