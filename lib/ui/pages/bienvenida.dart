import 'package:flutter/material.dart';
import 'package:presentacion/ui/pages/frmReporte.dart';
import 'package:presentacion/core/services/authentication.dart';
import 'package:presentacion/core/utilities/shared_preferences_util.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}
class _WelcomeScreenState extends State<WelcomeScreen> {

  SharedPreferencesUtil sharedPreferences = new SharedPreferencesUtil();
  String? _name = "";

  @override
  void initState(){
    super.initState();

    sharedPreferences.getUserName().then((value) => {
      setState(() {
        _name = value;
      })
    });


  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            padding: EdgeInsets.only(top: 80.0, left: 20, right: 20),
            width: double.infinity,
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'Bienvenido: ' + _name.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                  ),
                ),
                SizedBox(height: 50.0),
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    padding: EdgeInsets.all(15.0),
                    onPressed: () => {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FrmReportScreen()))
                    },
                    child: Text("Realizar Reporte" , style: TextStyle(fontSize: 28.0),),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black,width: 3),
                    ),
                  ),
                ),
                SizedBox(height: 30.0),
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    padding: EdgeInsets.all(15.0),
                    onPressed: () => {
                      Navigator.pushNamed(context, '/history')
                    },
                    child: Text("Mi Historial" , style: TextStyle(fontSize: 28.0),),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black,width: 3),
                    ),
                  ),
                ),
                SizedBox(height: 30.0),
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    padding: EdgeInsets.all(15.0),
                    onPressed: () async {
                      await signOut();
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text("Cerrar Sesión" , style: TextStyle(fontSize: 28.0),),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black,width: 3),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
}