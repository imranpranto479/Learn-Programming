import 'package:flutter/material.dart';
import 'package:flutterd/screens/home_screen.dart';
import 'package:flutterd/screens/register_screen.dart';
import 'package:flutterd/state/post_state.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _form = GlobalKey<
      FormState>(); //global key er maddhome puro form control krte pari
  String _username;
  String _password;

  void _loginNow() async {
    var isValid = _form.currentState
        .validate(); //validation form er key er maddhome check krbo
    if (!isValid) {
      return;
    }
    _form.currentState.save(); //username and pass save hobe
    bool islogin = await Provider.of<PostState>(context, listen: false)
        .loginNow(_username, _password); // global state theke dhorechi loginnow
    if (!islogin) {
      Navigator.of(context).pushReplacementNamed(HomeScreens.routeName);
      // login thik thakle homescreen e niye zabe
    } else {
      //-----------------------wrong user-- pass -------alert box--------------
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Something is Wrong!\nTry Again"),
              actions: [
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Ok"),
                )
              ],
            );
          });
    }
    //print(_username);
    //print(_password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Learn Programming"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            // form use kora hoyeche validation er zonno
            key: _form,
            child: Column(
              children: [
                Text(
                  "Login",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                SizedBox(
                  height: 200,
                ),
                //----------------------user name ------------------------------------
                TextFormField(
                  // 1ta key er moddhe puro form control krte pari
                  validator: (value) {
                    // validation checking
                    if (value.isEmpty) {
                      return 'Enter your Username'; //empty obstay submit krte chaile eta dekhabe
                    }
                    //----------------------form er maddhome error message show koriyechi---------------

                    return null;
                  },
                  onSaved: (value) {
                    _username = value; //save krle value user name e chole zabe
                  },
                  decoration: InputDecoration(
                    labelText: "Username",
                  ),
                ),
                //----------------------Password ------------------------------------
                TextFormField(
                  // 1ta key er moddhe puro form control krte pari
                  validator: (value) {
                    // validation checking
                    if (value.isEmpty) {
                      return 'Enter your Password'; //empty obstay submit krte chaile eta dekhabe
                    }
                    //----------------------form er maddhome error message show koriyechi---------------

                    return null;
                  },
                  onSaved: (value) {
                    _password = value; //save krle value user name e chole zabe
                  },
                  decoration: InputDecoration(
                    labelText: "Password",
                  ),
                  obscureText: true, //password show krbe na
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RaisedButton(
                      color: Colors.green,
                      onPressed: () {
                        _loginNow();
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    // SizedBox(
                    //   width: 310,
                    // ),
                    FlatButton(
                      color: Colors.orange,
                      onPressed: () {
                        Navigator.of(context).pushNamed(RegisterScreen
                            .routeName); //push name er karone back button dekhacche
                      },
                      child: Text(
                        "Register Now",
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
