// ignore_for_file: non_constant_identifier_names, empty_catches

import 'dart:convert';
import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:servicios_vic/navigation_home_employee_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../navigation_home_screen.dart';

insertarusuario(String correo, String nombre, String apellido, String contrasena, String telefono) async{
  String theUrl = "https://proyectonunoxd.000webhostapp.com/crear_nuevo_usuario.php";
  await http.post(Uri.parse(Uri.encodeFull(theUrl)),headers: {"Accept":"application/json"},
  body: {
    "u_correo":correo,
    "u_nombre":nombre,
    "u_apellido":apellido,
    "u_contrasena":contrasena,
    "u_telefono":telefono,
  });
}

Future<void> userLogin(String email, String password, BuildContext context) async{
  var url = 'https://proyectonunoxd.000webhostapp.com/login_usuario.php';
  var data = {'email': email, 'password' : password};
  var response = await http.post(Uri.parse(Uri.encodeFull(url)), body: json.encode(data));
  var message = jsonDecode(response.body);
  if(message != 'Invalid'){
    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setString('id', message);
                    prefs.setString('type','usuario');
        print(prefs.get('id'));
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
      const NavigationHomeScreen()), (Route<dynamic> route) => false);
  }else{
  }
}

insertarempleado(String correo, String nombre, String apellido, String contrasena, String RFC) async{
  String theUrl = "https://proyectonunoxd.000webhostapp.com/crear_nuevo_empleado.php";
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
  var url = 'https://proyectonunoxd.000webhostapp.com/login_empleado.php';
  var data = {'email': email, 'password' : password};
  var response = await http.post(Uri.parse(Uri.encodeFull(url)), body: json.encode(data));
  var message = jsonDecode(response.body);
  if(message != 'Invalid'){
    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setString('id', message);
                    prefs.setString('type','prestador');
    print(prefs.get('id'));
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
      const NavigationHomeEmployeeScreen()), (Route<dynamic> route) => false);
  }else{
  }
}
