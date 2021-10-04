import 'package:flutter/material.dart';
import 'modelo.dart';
import 'register_employee_jobs_screen.dart';
class registro_empleado extends StatelessWidget{
  TextEditingController entrada_registro_Empleado_NombreCorreo = TextEditingController();
  TextEditingController entrada_registro_Empleado_NombreCuenta = TextEditingController();
  TextEditingController entrada_registro_Empleado_ApellidoCuenta = TextEditingController();
  TextEditingController entrada_registro_Empleado_ContraCuenta = TextEditingController();
  TextEditingController entrada_registro_Empleado_RFCCuenta = TextEditingController();
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
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(

          children: <Widget>[
            Stack(
              children: <Widget>[
                RotationTransition(
                  turns: const AlwaysStoppedAnimation(180 / 360),
                  child: SizedBox(
                    width: screenSize,
                    height: screenheight * 0.22,
                    child: const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFFF6365),
                            Color(0xFFF96332),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom : 0,
                  child: RotationTransition(
                    turns: AlwaysStoppedAnimation(180 / 360),
                    child: SizedBox(
                      width: screenSize,
                      height: screenheight * 0.02,
                      child: const DecoratedBox(
                        decoration: BoxDecoration(
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
              child:const Text(
                '  Crear Cuenta',
                style: TextStyle(fontWeight: FontWeight.bold,
                fontSize: 25),
              ),
            ),
            SizedBox(height: screenheight * 0.04,),
            SizedBox(
              width: screenSize * 0.90,
              height: screenheight * 0.10,
              child:TextField(
                controller: entrada_registro_Empleado_NombreCorreo,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder( borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(color: Color(0xFFe0e0e0), width: 2.0),),
                  fillColor: Color(0xFFe0e0e0), filled: true,
                  hintText: 'Correo Electronico',
                ),
              ),
            ),
            Row(
              children: <Widget>[
                SizedBox(width: screenSize * 0.05),
                SizedBox(
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
                SizedBox(width: screenSize * 0.05),
                SizedBox(
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
            SizedBox(
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
            SizedBox(
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
            SizedBox(
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
            OutlinedButton(

              onPressed: () {
                getvalue = entrada_registro_Empleado_NombreCuenta.text.toString();
                getvalue2 = entrada_registro_Empleado_ApellidoCuenta.text.toString();
                getvalue3 = entrada_registro_Empleado_ContraCuenta.text.toString();
                getvalue4 = entrada_registro_Empleado_RFCCuenta.text.toString();
                getvalue5 = entrada_registro_Empleado_NombreCorreo.text.toString();
                insertarempleado(getvalue5, getvalue, getvalue2, getvalue3, getvalue4);
                Navigator.push(context, MaterialPageRoute(builder: (context) => EspecializacionEmpleado()));

              },
              child: const Text('Crear Cuenta', style: TextStyle(color: Colors.white, fontSize: 20)),
                style: OutlinedButton.styleFrom(
                    shape: const StadiumBorder (
                      side: BorderSide(
                          width: 20,
                      )
                    ),
                  side: const BorderSide( width: 1, color: Color(0xFFF96332),),
                    //  padding: EdgeInsets.all(60),
                  minimumSize: Size(screenSize * 0.90, screenheight * 0.07),
                    backgroundColor: const Color(0xFFF96332),
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
