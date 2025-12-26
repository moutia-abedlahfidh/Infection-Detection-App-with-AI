

import 'package:firebase_auth/firebase_auth.dart';
import 'package:FistulaCheck/login/login_service.dart';
import 'package:FistulaCheck/upload/uploadscreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends ChangeNotifier {
  LoginService service = LoginService();
  TextEditingController email  = TextEditingController();
  TextEditingController password =TextEditingController() ;

  void loginUser(BuildContext context) async{
    String? result = await service.loginUser(email: email.text, password: password.text);
    if (result == null) {
      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content:  Text('Erfolgreich Einloggen ...'),backgroundColor: Colors.green,),
    );
    String uid = FirebaseAuth.instance.currentUser!.uid;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('uid', uid);
      Navigator.push(context,MaterialPageRoute(builder: (context) => UploadImagePage()));
    }else {
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(result),backgroundColor: Colors.red,),
    );
    }
  }





}