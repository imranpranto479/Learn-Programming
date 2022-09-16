import 'package:flutter/material.dart';
import 'package:flutterd/screens/category_screens.dart';
import 'package:flutterd/screens/home_screen.dart';
import 'package:flutterd/screens/login_screen.dart';
import 'package:flutterd/screens/post_details_screens.dart';
import 'package:flutterd/screens/register_screen.dart';
import 'package:flutterd/state/post_state.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // instance create local storage er zonno
    LocalStorage storage =
        LocalStorage("usertoken"); //user token name e local storage
    // storage er vitore token save krbo

    return ChangeNotifierProvider(
      create: (context) =>
          PostState(), // z class take globally send korte chacchi (post state)
      child: MaterialApp(
        // zkono zayga theke material app er under e zoto page or screen thakok sb zaygai post state class ke dhorte parbo
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            //bg color of appbar
            primarySwatch: Colors.green,
            accentColor: Colors.orange),
        home: FutureBuilder(
          future: storage.ready,
          builder: (context, snapshot) {
            //-----------------local storage theke data dhora hoytese-------
            if (snapshot.data == null) {
              return Scaffold(
                body: Center(
                    child:
                        CircularProgressIndicator()), // circle sign dibe (zkhn local storage theke data ta dhorbe)
              );
              //-------------login----homescreen--------------zawar zonno
            }
            if (storage.getItem("token") == null) {
              return LoginScreen(); // token na thakle
            }
            return HomeScreens(); // thakle
          },
        ),
        routes: {
          HomeScreens.routeName: (context) => HomeScreens(), //homescreen e zabe
          PostDetailsScreens.routeName: ((context) =>
              PostDetailsScreens()), //post details er screen e zabe
          CategoryScreens.routeName: ((context) =>
              CategoryScreens()), // cateogry er screen e zabe

          LoginScreen.routeName: ((context) =>
              LoginScreen()), // login er screen e zabe
          RegisterScreen.routeName: ((context) =>
              RegisterScreen()), // register er screen e zabe
        },
      ),
    );
  }
}
