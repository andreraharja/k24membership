import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_k24_membership/sizeconfig.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'apiK24.dart';
import 'homepage.dart';
import 'modellogin.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isHidePassword = true;
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  int _state = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          padding: EdgeInsets.only(
              left: SizeConfig.blockSizeHorizontal! * 8,
              right: SizeConfig.blockSizeHorizontal! * 8),
          child: Center(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                logo(),
                SizedBox(height: SizeConfig.blockSizeVertical! * 5),
                usernameLogin(),
                SizedBox(height: SizeConfig.blockSizeVertical!),
                passwordLogin(),
                SizedBox(height: SizeConfig.blockSizeVertical! * 4),
                buttonLogin(),
                SizedBox(height: SizeConfig.blockSizeVertical! * 5),
                Text(
                  'Copyright © Andre Christian Raharja',
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget logo() {
    return Container(
        height: SizeConfig.blockSizeVertical! * 25,
        child: Image(
          image: AssetImage('assets/k24.png'),
          fit: BoxFit.contain,
        ));
  }

  Widget usernameLogin() {
    return TextFormField(
      controller: usernameController,
      keyboardType: TextInputType.text,
      autofocus: false,
      readOnly: _state == 1 ? true : false,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.person,
          color: Colors.green,
        ),
        hintText: 'Username',
        contentPadding: EdgeInsets.only(
            left: SizeConfig.blockSizeHorizontal!,
            right: SizeConfig.blockSizeHorizontal!),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.green)),
        fillColor: Colors.grey,
      ),
    );
  }

  Widget passwordLogin() {
    return TextFormField(
      controller: passwordController,
      autofocus: false,
      readOnly: _state == 1 ? true : false,
      obscureText: isHidePassword,
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.green,
          ),
          hintText: 'Password',
          contentPadding: EdgeInsets.only(
              left: SizeConfig.blockSizeHorizontal!,
              right: SizeConfig.blockSizeHorizontal!),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          suffixIcon: GestureDetector(
            onTap: () {
              togglePassVisibility();
            },
            child: Icon(
              isHidePassword ? Icons.visibility_off : Icons.visibility,
              color: isHidePassword ? Colors.grey : Colors.green,
            ),
          )),
    );
  }

  void togglePassVisibility() {
    setState(() {
      isHidePassword = !isHidePassword;
    });
  }

  Widget buttonLogin() {
    return Container(
      height: SizeConfig.blockSizeVertical! * 7,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.green,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: _state == 1
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 3,
                ),
              )
            : Text('SIGN IN', style: TextStyle(color: Colors.white)),
        onPressed: () async {
          setState(() {
            _state = 1;
          });
          loginPost newPost = new loginPost(
              username: usernameController.text,
              password: passwordController.text);
          AccessK24? resultAccess = await getAccessK24(body: newPost.toMap());
          if (resultAccess == null) {
            setState(() {
              _state = 0;
            });
            final snackBar = SnackBar(
              content: Text('Invalid Username / Password',
                  textAlign: TextAlign.center),
              backgroundColor: Colors.green,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('partnerId', resultAccess.partnerID ?? "");
            prefs.setString('partnerCode', resultAccess.partnerCode ?? "");
            prefs.setString('name', resultAccess.name ?? "");
            prefs.setString('description', resultAccess.description ?? "");
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (_) {
              return HomePage();
            }));
          }
        },
      ),
    );
  }
}
