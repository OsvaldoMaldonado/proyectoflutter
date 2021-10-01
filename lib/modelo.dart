// To parse this JSON data, do
//
//     final dataModel = dataModelFromJson(jsonString);

import 'dart:convert';
import 'dart:core';


import 'package:http/http.dart' as http;

insertarusuario(String correo, String nombre, String apellido, String contrasena, String RFC) async{
  String theUrl = "https://tadeo46.000webhostapp.com/InsertarUsuario.php";

  var res = await http.post(Uri.parse(Uri.encodeFull(theUrl)),headers: {"Accept":"application/json"},
  body: {
    "u_correo":correo,
    "u_nombre":nombre,
    "u_apellido":apellido,
    "u_contrasena":contrasena,
    "u_RFC":RFC,
  });

  var respbody = jsonDecode(res.body.toString());
  print(respbody);

}
login(String correo,String contrasena) async{
  String theUrl = "https://tadeo46.000webhostapp.com/LogearUsuario.php";

  var res = await http.post(Uri.parse(Uri.encodeFull(theUrl)),headers: {"Accept":"application/json"},
      body: {
        "u_correo":correo,
        "u_contrasena":contrasena,
      });

  var respbody = jsonDecode(res.body.toString());
  print(respbody);

}
insertarempleado(String correo, String nombre, String apellido, String contrasena, String RFC) async{
  String theUrl = "https://tadeo46.000webhostapp.com/InsertarEmpleado.php";

  var res = await http.post(Uri.parse(Uri.encodeFull(theUrl)),headers: {"Accept":"application/json"},
      body: {
        "u_correo":correo,
        "u_nombre":nombre,
        "u_apellido":apellido,
        "u_contrasena":contrasena,
        "u_RFC":RFC,
      });

  var respbody = jsonDecode(res.body.toString());
  print(respbody);

}
loginempleado(String correo,String contrasena) async{
  String theUrl = "https://tadeo46.000webhostapp.com/LogearEmpleado.php";

  var res = await http.post(Uri.parse(Uri.encodeFull(theUrl)),headers: {"Accept":"application/json"},
      body: {
        "u_correo":correo,
        "u_contrasena":contrasena,
      });

  var respbody = jsonDecode(res.body.toString());
  print(respbody);

}