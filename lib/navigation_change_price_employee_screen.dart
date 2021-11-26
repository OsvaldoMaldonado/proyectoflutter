// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:servicios_vic/model/modelo_navegacion_empleado.dart';
import 'package:http/http.dart' as http;

class NavigationChangePriceScreen extends StatefulWidget{

  final String? idTrabajo;

  const NavigationChangePriceScreen({Key? key,this.idTrabajo}) : super(key: key);

   @override
  // ignore: no_logic_in_create_state
  NavigationChangePriceState createState() => NavigationChangePriceState(idTrabajo: idTrabajo);
}


class NavigationChangePriceState extends State<NavigationChangePriceScreen> {
  NavigationChangePriceState({Key? key, this.idTrabajo});

  TextEditingController descripcion_controller = TextEditingController();
  String costo = "";

  final String? idTrabajo;

  TextEditingController nuevoPrecio = TextEditingController();
  @override
  Widget build(BuildContext context) {

    double screenSize = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
        foregroundColor: const Color(0xFFF96332),
        title: const Text('Cambio de precio', style: TextStyle(fontSize: 20.0,color: Colors.black,),)
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 4.0, bottom: 6.0),
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 6.0),
              child: const Align(
                alignment: Alignment.center,
                child: Text("Por favor escriba el nuevo precio" ,style: TextStyle(fontSize: 16.0,color: Colors.black,))
              ),
            ),     
            Container(       
              margin: const EdgeInsets.only(bottom: 10.0),
              child : const Align(
                alignment: Alignment.center,
                child: Text("(Este precio sera comprobado por el cliente)" ,style: TextStyle(fontSize: 12.0,color: Colors.black54,),),
              ),  
            ),
            FutureBuilder<CambioPrecio?>(   
              future: fetchCambioPrecio(http.Client(), idTrabajo),
              builder: (context, snapshot){
                if (snapshot.hasError) {
                  return Container(
                    margin: const EdgeInsets.only(top: 10.0, bottom: 15.0),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text('An error has occurred!'),
                    )
                  );
                } else if (snapshot.hasData) {
                  return  Text("\$" + snapshot.data!.costo + "MXN (Precio Anterior)" ,style: const TextStyle(fontSize: 14.0,color: Colors.black,),);
                  //return Text(snapshot.data!.correo);
                } else {
                  return Container(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            SizedBox(
              width: screenSize * 0.90,
              height: screenheight * 0.10,
              child:TextField(
                controller: nuevoPrecio,
                decoration: const InputDecoration(
                      icon: Icon(Icons.money),
                  hintText: "Nuevo precio",
                ),
              ),
            ),
            Container(       
              margin: EdgeInsets.only(top: 10.0, right: screenSize * 0.05),
              child :  Align(
                alignment: Alignment.topRight,
                child: OutlinedButton(
                onPressed: (){
                    costo = nuevoPrecio.text.toString();
                    cambioDeCosto(http.Client(), costo, idTrabajo, context);
                },
                child: const Text('Cambiar Precio', style: TextStyle(color: Colors.white, fontSize: 14)),
                  style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                    side: const BorderSide( width: 0.5, color: Color(0xFFF96332),),
                      //  padding: EdgeInsets.all(60),
                    minimumSize: Size(screenSize * 0.40, screenheight * 0.1),
                    backgroundColor: const Color(0xFFF96332),
                  ),  
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}