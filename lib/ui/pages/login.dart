import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:presentacion/core/utilities/constanst.dart';
import 'package:presentacion/core/services/authentication.dart';
import 'package:presentacion/core/utilities/alertDialog.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;
  TextEditingController _user = new TextEditingController();
  TextEditingController _pass = new TextEditingController();
  final AlertDialogApp alertDialogApp = new AlertDialogApp();

  bool isSign = false;

  Widget _buildEmailTF(TextEditingController txt) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          // decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            controller: txt,
            style: TextStyle(
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: paddingText,
              prefixIcon: Icon(
                Icons.person,
                color: Colors.black,
              ),
              hintText: 'Usuario',
              labelText: 'Usuario'
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF(TextEditingController txt) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          height: 60.0,
          child: TextField(
            obscureText: true,
            controller: txt,
            style: TextStyle(
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: paddingText,
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.black,
              ),
              hintText: 'Contraseña',
              labelText: 'Contraseña',

            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginBtn( BuildContext _context ,  _emailField , _passwordField) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async  {
          print(_emailField);
          print(_passwordField);
          bool shouldNavigate = await signIn(_emailField, _passwordField);

          if(shouldNavigate){
            Navigator.pushNamed(_context, '/welcome');
          }

        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: primaryColor,
        child: Text(
          'INGRESAR',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildSocialBtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap(),
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialBtnRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSocialBtn(
                () => print('Login with Google'),
            AssetImage(
              'assets/images/social/google.jpg',
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState(){
    setState(() {
      isSign = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.only(top: 80.0, left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Ayuda Reportando',
                        style: TextStyle(
                          // color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10.0),
                          Container(
                            alignment: Alignment.centerLeft,
                            // decoration: kBoxDecorationStyle,
                            height: 60.0,
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: _user,
                              style: TextStyle(
                                fontFamily: 'OpenSans',
                              ),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding: paddingText,
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Colors.black,
                                  ),
                                  hintText: 'Usuario',
                                  labelText: 'Usuario'
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10.0),
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 60.0,
                            child: TextFormField(
                              obscureText: true,
                              controller: _pass,
                              style: TextStyle(
                                fontFamily: 'OpenSans',
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: paddingText,
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.black,
                                ),
                                hintText: 'Contraseña',
                                labelText: 'Contraseña',

                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 25.0),
                        width: double.infinity,
                        child: RaisedButton(
                          elevation: 5.0,
                          onPressed: () async  {
                            if(isSign) return;
                            setState(() {
                              isSign = true;
                            });
                            bool shouldNavigate = await signIn(_user.text, _pass.text);

                            setState(()  {
                              isSign = false;
                            });

                            if(shouldNavigate){

                              Navigator.pushNamed(context, '/welcome');
                            }else{

                              alertDialogApp.buildAlertDialog(context, "Usuario y contraseña incorrectos");
                            }


                          },
                          padding: EdgeInsets.all(15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: primaryColor,
                          child: !isSign? Text(
                            'INGRESAR',
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 1.5,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                            ),
                          ) : CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                      ),
                      _buildSocialBtnRow(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}