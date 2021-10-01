import 'package:flutter/material.dart';
import 'package:flutter_app3/modelo.dart';

class login_empleado extends StatelessWidget{

  TextEditingController entrada_login_Empleado_NombreCorreo = new TextEditingController();
  TextEditingController entrada_login_Empleado_NombreContra = new TextEditingController();
  String getvalue = "";
  String getvalue2 = "";
  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).

          children: <Widget>[
            Stack(
              children: <Widget>[
                new RotationTransition(
                  turns: new AlwaysStoppedAnimation(180 / 360),
                  child: Container(
                    width: screenSize,
                    height: screenheight * 0.22,
                    child: const DecoratedBox(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.0)),
                        color: Color(0xFFF96332),
                      ),
                    ),
                  ),
                ),

                Positioned(
                  bottom : 0,
                  child: RotationTransition(
                    turns: new AlwaysStoppedAnimation(180 / 360),
                    child: Container(
                      width: screenSize,
                      height: screenheight * 0.02,
                      child: const DecoratedBox(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.0)),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),


              ],
            ),
            Container(

              alignment: Alignment.centerLeft,
              child:Text(
                '  Iniciar sesión',
                style: const TextStyle(fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
            SizedBox(height: screenheight * 0.03,),
            Row(
              children: <Widget>[
                Spacer(),

                Container(
                  width: screenSize * 0.90,
                  height: screenheight * 0.10,

                  child:TextField(
                    controller: entrada_login_Empleado_NombreCorreo,

                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder( borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Color(0xFFe0e0e0), width: 2.0),),
                      fillColor: Color(0xFFe0e0e0), filled: true,
                      labelText: 'Correo Electronico',
                    ),
                  ),
                ),
                SizedBox(width: screenSize * 0.05, height: screenheight * 0.03,),
              ],
            ),
            SizedBox(height: screenheight * 0.03,),
            Row(
              children: <Widget>[
                Spacer(),

                Container(
                  width: screenSize * 0.90,
                  height: screenheight * 0.10,

                  child:TextField(
                    controller: entrada_login_Empleado_NombreContra,
                    obscureText: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder( borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Color(0xFFe0e0e0), width: 2.0),),
                      fillColor: Color(0xFFe0e0e0), filled: true,
                      labelText: 'Contraseña',
                    ),
                  ),
                ),
                SizedBox(width: screenSize * 0.05, height: screenheight * 0.03,),
              ],
            ),
            SizedBox(height: screenheight * 0.03,),
            OutlinedButton(

              onPressed: () async{
                getvalue = entrada_login_Empleado_NombreContra.text.toString();
                getvalue2 = entrada_login_Empleado_NombreCorreo.text.toString();
                loginempleado(getvalue2, getvalue);
              },
              child: const Text('Iniciar sesión',
                style: TextStyle(color: Colors.white),),
              style: OutlinedButton.styleFrom(
                shape: StadiumBorder(),
                //  padding: EdgeInsets.all(60),
                minimumSize: Size(screenSize * 0.83, screenheight * 0.09),
                backgroundColor: Color(0xFF102C4D),
              ),
            ),







          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      // onPressed: _incrementCounter,
      // tooltip: 'Increment',
      // child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
