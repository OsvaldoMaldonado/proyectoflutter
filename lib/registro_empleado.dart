import 'package:flutter/material.dart';
import 'package:flutter_app3/modelo.dart';
import 'package:flutter_app3/registro_empleado.dart';
import 'package:flutter_app3/especializacion_empleado.dart';
class registro_empleado extends StatelessWidget{
  TextEditingController entrada_registro_Empleado_NombreCorreo = new TextEditingController();
  TextEditingController entrada_registro_Empleado_NombreCuenta = new TextEditingController();
  TextEditingController entrada_registro_Empleado_ApellidoCuenta = new TextEditingController();
  TextEditingController entrada_registro_Empleado_ContraCuenta = new TextEditingController();
  TextEditingController entrada_registro_Empleado_RFCCuenta = new TextEditingController();
  String getvalue = "";
  String getvalue2 = "";
  String getvalue3 = "";
  String getvalue4 = "";
  String getvalue5 = "";
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
                '  Crear Cuenta',
                style: const TextStyle(fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
            SizedBox(height: screenheight * 0.02,),
            Row(
              children: <Widget>[
                Spacer(),

                Container(
                  width: screenSize * 0.90,
                  height: screenheight * 0.10,

                  child:TextField(
                    controller: entrada_registro_Empleado_NombreCorreo,
                    obscureText: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder( borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Color(0xFFe0e0e0), width: 2.0),),
                      fillColor: Color(0xFFe0e0e0), filled: true,
                      hintText: 'Correo Electronico',
                    ),
                  ),
                ),
                SizedBox(width: screenSize * 0.05, height: screenheight * 0.03,),
              ],
            ),
            SizedBox(height: screenheight * 0.02,),
            Row(
              children: <Widget>[
                SizedBox(width: screenSize * 0.05 , height: screenheight * 0.03,),
                Container(
                  width: screenSize * 0.40,
                  height: screenheight * 0.10,

                  child:TextField(
                    controller: entrada_registro_Empleado_NombreCuenta,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder( borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Color(0xFFe0e0e0), width: 2.0),),
                      fillColor: Color(0xFFe0e0e0), filled: true,
                      labelText: 'Nombre',
                    ),
                  ),
                ),
                SizedBox(width: screenSize * 0.05 , height: screenheight * 0.03,),
                Container(
                  width: screenSize * 0.45,
                  height: screenheight * 0.10,

                  child:TextField(
                    controller: entrada_registro_Empleado_ApellidoCuenta,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder( borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Color(0xFFe0e0e0), width: 2.0),),
                      fillColor: Color(0xFFe0e0e0), filled: true,
                      labelText: 'Apellido',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenheight * 0.02,),
            Row(
              children: <Widget>[
                Spacer(),

                Container(
                  width: screenSize * 0.90,
                  height: screenheight * 0.10,

                  child:TextField(
                    controller: entrada_registro_Empleado_ContraCuenta,
                    obscureText: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder( borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Color(0xFFe0e0e0), width: 2.0),),
                      fillColor: Color(0xFFe0e0e0), filled: true,
                      labelText: 'Contraseña',
                    ),
                  ),
                ),
                SizedBox(width: screenSize * 0.05 , height: screenheight * 0.03,),
              ],
            ),

            SizedBox(height: screenheight * 0.02,),
            Row(
              children: <Widget>[
                Spacer(),

                Container(
                  width: screenSize * 0.90,
                  height: screenheight * 0.10,

                  child:TextField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder( borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Color(0xFFe0e0e0), width: 2.0),),
                      fillColor: Color(0xFFe0e0e0), filled: true,
                      labelText: 'Vuelva a escribir la contraseña',
                    ),
                  ),
                ),
                SizedBox(width: screenSize * 0.05 , height: screenheight * 0.10,),
              ],
            ),
            SizedBox(height: screenheight * 0.02,),
            Row(
              children: <Widget>[
                Spacer(),

                Container(
                  width: screenSize * 0.90,
                  height: screenheight * 0.10,

                  child:TextField(
                    controller: entrada_registro_Empleado_RFCCuenta,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder( borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Color(0xFFe0e0e0), width: 2.0),),
                      fillColor: Color(0xFFe0e0e0), filled: true,
                      labelText: 'RFC',
                    ),
                  ),
                ),
                SizedBox(width: screenSize * 0.05 , height: screenheight * 0.10,),
              ],
            ),
            SizedBox(height: screenheight * 0.02,),
            OutlinedButton(

              onPressed: () {
                getvalue = entrada_registro_Empleado_NombreCuenta.text.toString();
                getvalue2 = entrada_registro_Empleado_ApellidoCuenta.text.toString();
                getvalue3 = entrada_registro_Empleado_ContraCuenta.text.toString();
                getvalue4 = entrada_registro_Empleado_RFCCuenta.text.toString();
                getvalue5 = entrada_registro_Empleado_NombreCorreo.text.toString();
                insertarempleado(getvalue5, getvalue, getvalue2, getvalue3, getvalue4);
                Navigator.push(context, new MaterialPageRoute(builder: (context) => especializacion_empleado()));

              },
              child: const Text('Crear Cuenta',
                style: TextStyle(color: Colors.white),),
              style: OutlinedButton.styleFrom(
                shape: StadiumBorder(),
                //  padding: EdgeInsets.all(60),
                minimumSize: Size(screenSize * 0.50, screenheight * 0.09,),
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
