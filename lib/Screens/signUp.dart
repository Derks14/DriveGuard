import 'package:driveguard/Screens/signIn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _name, _email, _phone, _password;
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Icon(Icons.drive_eta),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Text('Create Your Account', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                // ignore: missing_return
                validator: (input){
                  if(input.isEmpty) return 'Please enter your fullname';
                },
                onSaved: (input) => _name = input,
                decoration: InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.person)
                ),
              ),),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  // ignore: missing_return
                  validator: (input){
                    if(input.isEmpty) return 'Please enter your email';
                  },
                  onSaved: (input) => _email = input,
                  decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.alternate_email)),
                ),),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                // ignore: missing_return
                validator: (input){
                  if(input.isEmpty) return 'Please enter your phone';
                },
                onSaved: (input) => _phone = input,
                decoration: InputDecoration(
                    labelText: 'Phone',
                    prefixIcon: Icon(Icons.phone)
                ),
              ),),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),

                child: TextFormField(
                // ignore: missing_return
                validator: (input){
                  if(input.isEmpty) return 'Please enter your password';
                },
                onSaved: (input) => _password = input,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock)
                ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: CupertinoButton(color: Colors.blueGrey,
                    child: Text('Sign In'),
                    onPressed: signUp),
              ),
              CupertinoButton(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Text('Dont have an account, Sign Up here', style: TextStyle(fontSize: 16),),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()))
                ,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signUp() async{
    final formState = _formKey.currentState;
    if(formState.validate()){
      formState.save();
      try {
        AuthResult result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
        FirebaseUser user = result.user;
        user.sendEmailVerification();

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignIn()));
      } catch (e) {
        print(e);
      }
    }
  }


}
