import 'package:driveguard/Screens/home.dart';
import 'package:driveguard/Screens/signUp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SignIn extends StatefulWidget {

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  String _email, _password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text('DriveGuard',style: TextStyle(fontSize: 24),),
      ),
      body: SingleChildScrollView(child: Container(
        padding: EdgeInsets.all(30),
        child: Form(
            key: _formKey,
            child: Column(
//              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: Icon(Icons.drive_eta, size: 100,),),
                Container(child: TextFormField(
                  // ignore: missing_return
                  validator: (input){
                    if(input.isEmpty) return 'Please enter email';
                  },
                  onSaved: (input) => _email = input,
                  decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.alternate_email)
                  ),
                ),),
                SizedBox(height: 10,),
                Container(child: TextFormField(
                  // ignore: missing_return
                  validator: (input){
                    if(input.isEmpty){
                      return 'Please enter password';
                    }
                  },
                  onSaved: (input) => _password = input,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: CupertinoButton(color: Colors.blueGrey,
                      child: Text('Sign In'),
                      onPressed: signIn),
                ),
                CupertinoButton(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Text('Dont have an account, Sign Up here', style: TextStyle(fontSize: 16),),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()))
                  ,
                )
              ],
            )
        ),
      ),),
    );
  }

   Future<void> signIn() async{
    final formState = _formKey.currentState;
    if(formState.validate()){
      formState.save();
      AuthResult result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
      FirebaseUser user = result.user;

      Navigator.push(context, MaterialPageRoute(builder: (context) => Home(user: user,)));
    }
  }
}
