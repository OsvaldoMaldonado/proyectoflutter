// To parse this JSON data, do
//
//     final dataModel = dataModelFromJson(jsonString);

import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;

insertarusuario(String correo, String nombre, String apellido, String contrasena, String RFC) async{
  String theUrl = "https://proyectonunoxd.000webhostapp.com/insertarusuario.php";

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
Future<String?> login(String correo,String contrasena) async{
  String theUrl = "https://proyectonunoxd.000webhostapp.com/logearusuario.php";

  var res = await http.post(Uri.parse(Uri.encodeFull(theUrl)),headers: {"Accept":"application/json"},
      body: {
        "u_correo":correo,
        "u_contrasena":contrasena,
      });
  try{
      var respbody = jsonDecode(res.body.toString());
      return respbody;
  // ignore: empty_catches
  }catch(e) { 
  } 
  return null;
}

insertarempleado(String correo, String nombre, String apellido, String contrasena, String RFC) async{
  String theUrl = "https://proyectonunoxd.000webhostapp.com/insertarempleado.php";

  var res = await http.post(Uri.parse(Uri.encodeFull(theUrl)),headers: {"Accept":"application/json"},
      body: {
        "u_correo":correo,
        "u_nombre":nombre,
        "u_apellido":apellido,
        "u_contrasena":contrasena,
        "u_RFC":RFC,
      });
  try{
    var respbody = jsonDecode(res.body.toString());
    print(respbody);
  }catch(e) { 
  }
}

Future<String?> usuarioActivo (String id) async{
  String theUrl = "https://proyectonunoxd.000webhostapp.com/usuarioactivo.php";

  var res = await http.post(Uri.parse(Uri.encodeFull(theUrl)),headers: {"Accept":"application/json"},
      body: {
        "id":id,
      });
  try{
      var respbody = jsonDecode(res.body.toString());
      return respbody;
  // ignore: empty_catches
  }catch(e) { 
  } 
  return null;
}

loginempleado(String correo,String contrasena) async{
  String theUrl = "https://proyectonunoxd.000webhostapp.com/logearempleado.php";

  var res = await http.post(Uri.parse(Uri.encodeFull(theUrl)),headers: {"Accept":"application/json"},
      body: {
        "u_correo":correo,
        "u_contrasena":contrasena,
      });

  var respbody = jsonDecode(res.body.toString());
  print(respbody);

}