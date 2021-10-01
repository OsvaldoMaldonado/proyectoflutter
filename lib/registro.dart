import 'package:flutter/material.dart';
import 'package:flutter_app3/modelo.dart';

import 'package:http/http.dart' as http;
class registro extends StatefulWidget {
  final String title;

  registro({this.title = 'Demo'});

  @override
  registranding createState() => registranding();
}
class registranding extends State<registro> {

  TextEditingController entrada_registro_NombreCorreo = new TextEditingController();
  TextEditingController entrada_registro_NombreCuenta = new TextEditingController();
  TextEditingController entrada_registro_ApellidoCuenta = new TextEditingController();
  TextEditingController entrada_registro_ContraCuenta = new TextEditingController();
  TextEditingController entrada_registro_RFCCuenta = new TextEditingController();
  String getvalue = "";
  String getvalue2 = "";
  String getvalue3 = "";
  String getvalue4 = "";
  String getvalue5 = "";
  String dropdownValue = 'Efectivo';



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
                    height: screenheight * 0.17,
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
            SizedBox(height: screenheight * 0.01,),
            Row(
              children: <Widget>[
                  Spacer(),

                   Container(
                     width: screenSize * 0.90,
                     height: screenheight * 0.10,

                  child:TextField(
                    controller: entrada_registro_NombreCorreo,
                    obscureText: true,
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
            SizedBox(height: screenheight * 0.01,),
            Row(
              children: <Widget>[
                SizedBox(width: screenSize * 0.05 , height: screenheight * 0.03,),
                Container(
                  width: screenSize * 0.40,
                  height: screenheight * 0.10,

                  child:TextField(
                    controller: entrada_registro_NombreCuenta,
                    obscureText: true,
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
                    controller: entrada_registro_ApellidoCuenta,
                    obscureText: true,
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
            SizedBox(height: screenheight * 0.01,),
            Row(
              children: <Widget>[
                Spacer(),

                Container(
                  width: screenSize * 0.90,
                  height: screenheight * 0.10,

                  child:TextField(
                    controller: entrada_registro_ContraCuenta,
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

            SizedBox(height: screenheight * 0.01,),
            Row(
              children: <Widget>[
                Spacer(),

                Container(
                  width: screenSize * 0.90,
                  height: screenheight * 0.10,

                  child:TextField(
                    obscureText: true,
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
            SizedBox(height: screenheight * 0.01,),
            Row(
              children: <Widget>[
                Spacer(),

                Container(
                  width: screenSize * 0.90,
                  height: screenheight * 0.10,

                  child:TextField(
                    controller: entrada_registro_RFCCuenta,
                    obscureText: true,
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
            SizedBox(height: screenheight * 0.01,),
                Row(
                children: <Widget>[
                  SizedBox(width: screenSize * 0.05 , height: screenheight * 0.10,),
                Container(
                width: screenSize * 0.30,
                height: screenheight * 0.10,
                  child: InputDecorator(

                  decoration:  new InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: OutlineInputBorder( borderRadius: BorderRadius.circular(20.0),
                      borderSide: const BorderSide(color:  Color(0xFFe0e0e0), width: 2.0), ),
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,

                  fillColor: Color(0xFFe0e0e0), filled: true,),
                child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,

                  onChanged: (String? newValue) {
                  setState(() {
                  dropdownValue = newValue!;
                  });
                  },
                  items: <String>['Efectivo', 'PayPal' , 'Tarjeta']
                      .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                  );
                  }).toList(),
                  ),
                  ),
                ),
                ),
                  SizedBox(width: screenSize * 0.59 , height: screenheight * 0.10,),
  ],
  ),
            SizedBox(height: screenheight * 0.01,),

               OutlinedButton(

                onPressed: () async{
                  getvalue = entrada_registro_NombreCuenta.text.toString();
                  getvalue2 = entrada_registro_ApellidoCuenta.text.toString();
                  getvalue3 = entrada_registro_ContraCuenta.text.toString();
                  getvalue4 = entrada_registro_RFCCuenta.text.toString();
                  getvalue5 = entrada_registro_NombreCorreo.text.toString();
                  insertarusuario(getvalue5, getvalue, getvalue2, getvalue3, getvalue4);
                      setState(()  {

                      });

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

