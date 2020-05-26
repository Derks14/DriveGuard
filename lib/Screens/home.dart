import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatelessWidget {
  final FirebaseUser user;

  Home({Key key, this.user}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text('Home',style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),),
        trailing: Icon(Icons.menu),
      ),
      body: SingleChildScrollView(
        child: Container(
          child:StreamBuilder<DocumentSnapshot>(
              stream: Firestore.instance.collection('users').document(user.uid).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
                if(snapshot.hasError) return CupertinoAlertDialog(title: Text('Error'),content: Text('${snapshot.error}'),);
                switch(snapshot.connectionState){
                  case ConnectionState.waiting: return CupertinoActivityIndicator();
                  default:
                    return Center(
                      child: Text(snapshot.data['name']),
                    );
                }
          } ),
        ),
      ),
    );
  }
}
