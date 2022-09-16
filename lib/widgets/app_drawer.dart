import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutterd/screens/login_screen.dart';
import 'package:localstorage/localstorage.dart';

class AddDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // instance create local storage er zonno
    LocalStorage storage =
        LocalStorage("usertoken"); //user token name e local storage
    // storage er vitore token save krbo

    _logoutnow() {
      storage.clear(); // storage clear
      Navigator.of(context)
          .pushReplacementNamed(LoginScreen.routeName); // redirect kore login
    }

    return Drawer(
      child: Column(children: [
        Image.network(
          "https://images.unsplash.com/photo-1607743386760-88ac62b89b8a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NDF8fHByb2dyYW1taW5nfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
        ),
        SizedBox(height: 10),
        Text(
          "About",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            "Programming for Beginners",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Spacer(),
        ListTile(
          onTap: () {
            _logoutnow();
          },
          trailing: Icon(
            Icons.logout,
            color: Colors.red,
          ),
          title: Text(
            "LogOut",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        )
      ]),
    );
  }
}
