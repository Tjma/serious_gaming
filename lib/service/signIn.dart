import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:serious_gaming/ui/listview_note.dart';


class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email,_password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              SizedBox(height: 80.0),

              CircleAvatar(
                radius: 120,
                backgroundColor: Colors.white,
                child: ClipOval(
                  child: Image.asset('assets/upcebu.png'),
                ),
              ),

              SizedBox(height: 48.0),
              TextFormField(
                validator: (input) {
                  if(input.isEmpty){
                    return 'Please input your UP mail';
                  }
                },
                onSaved: (input) => email = input,
                decoration: InputDecoration(
                  labelText: 'Email',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              TextFormField(
                validator: (input) {
                  if(input.length < 6){
                    return 'Please input your password';
                  }
                },
                onSaved: (input) => _password = input,
                decoration: InputDecoration(
                  labelText: 'Password',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: 50.0),
              RaisedButton(
                onPressed: signIn,
                child: Text("Sign in"),
                color: Color(0xFFB83227),
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              )
            ],
          )),
    );
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if(formState.validate()){
      formState.save();
      try{
        FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: _password);
        Navigator.push(context, MaterialPageRoute(builder: (context) => ListViewNote(user: user)));
        //TODO: Navigate to Dashboard
      }catch(e){
        print(e.message);
      }
    }
  }

}
