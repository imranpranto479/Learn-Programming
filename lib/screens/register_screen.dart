import 'package:flutter/material.dart';
import 'package:flutterd/screens/login_screen.dart';
import 'package:flutterd/state/post_state.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  //form validation er zonno
  static const routeName = '/register-screens';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _username;
  String _password;
  String _confirmpassowrd;

  final _form = GlobalKey<
      FormState>(); //global key er maddhome puro form control krte pari

  void _registerNow() async {
    var isValid = _form.currentState
        .validate(); //validation form er key er maddhome check krbo
    if (!isValid) {
      return;
    }
    _form.currentState.save(); //username and pass save hobe
    bool isregister = await Provider.of<PostState>(context, listen: false)
        .registerNow(
            _username, _password); // global state theke dhorechi loginnow
    if (isregister == false) {
      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
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
          padding: EdgeInsets.all(16),
          child: Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "Register",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
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
                  onChanged: (value) {
                    setState(() {
                      _password =
                          value; //save krle value user name e chole zabe
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "Password",
                  ),
                  obscureText: true, //password show krbe na
                ),
                //---------------------- Confirm Password ------------------------------------
                TextFormField(
                  // 1ta key er moddhe puro form control krte pari
                  validator: (value) {
                    // validation checking
                    if (_password != value) {
                      return 'Confirm Password'; //empty obstay submit krte chaile eta dekhabe
                    }
                    //----------------------form er maddhome error message show koriyechi---------------

                    return null;
                  },
                  onSaved: (value) {
                    _confirmpassowrd =
                        value; //save krle value user name e chole zabe
                  },
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                  ),
                  obscureText: true, //password show krbe na
                ),
                SizedBox(
                  height: 5,
                ),
                //-------------------button--------------
                SizedBox(
                  width: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RaisedButton(
                      color: Colors.orange,
                      onPressed: () {
                        _registerNow();
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    // SizedBox(
                    //   width: 318,
                    // ),
                    FlatButton(
                      color: Colors.green,
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed(LoginScreen
                            .routeName); //push name er karone back button dekhacche
                      },
                      child: Text(
                        "Login Now",
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
