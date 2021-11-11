// ignore_for_file: non_constant_identifier_names, empty_catches

import 'dart:convert';
import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:servicios_vic/navigation_employees_screen.dart';
import 'package:servicios_vic/navigation_home_employee_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../navigation_home_screen.dart';

insertarusuario(String correo, String nombre, String apellido, String contrasena, String telefono) async{
  String theUrl = "https://proyectonunoxd.000webhostapp.com/insertarusuario.php";
  await http.post(Uri.parse(Uri.encodeFull(theUrl)),headers: {"Accept":"application/json"},
  body: {
    "u_correo":correo,
    "u_nombre":nombre,
    "u_apellido":apellido,
    "u_contrasena":contrasena,
    "u_telefono":telefono,
  });
}
modificarusuario(String nombre, String nombremod) async{
  String theUrl = "https://tadeo46.000webhostapp.com/modificarusuario.php";
  await http.post(Uri.parse(Uri.encodeFull(theUrl)),headers: {"Accept":"application/json"},
      body: {
        "u_nombre":nombre,
        "u_nombremod":nombremod,
      });
}
modificarusuarioapellido(String apellido, String apellidomod) async{
  String theUrl = "https://tadeo46.000webhostapp.com/modificarusuarioapellido.php";
  await http.post(Uri.parse(Uri.encodeFull(theUrl)),headers: {"Accept":"application/json"},
      body: {
        "u_nombre":apellido,
        "u_nombremod":apellidomod,
      });
}
modificarusuariocorreo(String correo, String correomod) async{
  String theUrl = "https://tadeo46.000webhostapp.com/modificarusuariocorreo.php";
  await http.post(Uri.parse(Uri.encodeFull(theUrl)),headers: {"Accept":"application/json"},
      body: {
        "u_nombre":correo,
        "u_nombremod":correomod,
      });
}
modificarusuariotelefono(String telefono, String telefonomod) async{
  String theUrl = "https://tadeo46.000webhostapp.com/modificarusuariotelefono.php";
  await http.post(Uri.parse(Uri.encodeFull(theUrl)),headers: {"Accept":"application/json"},
      body: {
        "u_nombre":telefono,
        "u_nombremod":telefonomod,
      });
}
Future<void> userLogin(String email, String password, BuildContext context) async{
  var url = 'https://proyectonunoxd.000webhostapp.com/logearusuario.php';
  var data = {'email': email, 'password' : password};
  var response = await http.post(Uri.parse(Uri.encodeFull(url)), body: json.encode(data));
  var message = jsonDecode(response.body);
  if(message != 'Invalid'){
    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setString('id', message);
                    prefs.setString('type','usuario');
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
      const NavigationHomeScreen()), (Route<dynamic> route) => false);
  }else{
  }
}

insertarempleado(String correo, String nombre, String apellido, String contrasena, String RFC) async{
  String theUrl = "https://proyectonunoxd.000webhostapp.com/insertarempleado.php";
  await http.post(Uri.parse(Uri.encodeFull(theUrl)),headers: {"Accept":"application/json"},
    body: {
      "u_correo":correo,
      "u_nombre":nombre,
      "u_apellido":apellido,
      "u_contrasena":contrasena,
      "u_RFC":RFC,
    });
}

//cambiar
/*loginempleado(String correo,String contrasena) async{
  String theUrl = "https://proyectonunoxd.000webhostapp.com/logearempleado.php";
  await http.post(Uri.parse(Uri.encodeFull(theUrl)),headers: {"Accept":"application/json"},
    body: {
      "u_correo":correo,
      "u_contrasena":contrasena,
    });
}*/
Future<void> loginempleado(String email, String password, BuildContext context) async{
  var url = 'https://proyectonunoxd.000webhostapp.com/logearempleado.php';
  var data = {'email': email, 'password' : password};
  var response = await http.post(Uri.parse(Uri.encodeFull(url)), body: json.encode(data));
  var message = jsonDecode(response.body);
  if(message != 'Invalid'){
    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setString('id', message);
                    prefs.setString('type','prestador');
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
      const NavigationHomeEmployeeScreen()), (Route<dynamic> route) => false);
  }else{
  }
}

insertartrabajo(String estado_servicio, String fecha_publicacion, double costo, double latitud, 
double longitud, String descripcion, int prestador_id, int cliente_id, int? servicio_id, BuildContext context) async{
  String theUrl = "https://proyectonunoxd.000webhostapp.com/insertartrabajo.php";
  var response = await http.post(Uri.parse(Uri.encodeFull(theUrl)),headers: {"Accept":"application/json"},
  body: {
    "u_estado_servicio":estado_servicio,
    "u_fecha_publicacion":fecha_publicacion,
    "u_costo":costo.toString(),
    "u_latitud":latitud.toString(),
    "u_longitud":longitud.toString(),
    "u_descripcion":descripcion,
    "u_prestador_id":prestador_id.toString(),
    "u_cliente_id":cliente_id.toString(),
    "u_servicio_id":servicio_id.toString(),
  });
  var message = jsonDecode(response.body);
  if(message == 'Creado'){
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
      const NavigationHomeScreen()), (Route<dynamic> route) => false);
  }else{
  }
}
