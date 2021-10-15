// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:servicios_vic/home_screen.dart';
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

Future<void> userLogin(String email, String password, BuildContext context) async{

  // SERVER LOGIN API URL
  var url = 'https://proyectonunoxd.000webhostapp.com/logearusuario.php';

  // Store all data with Param Name.
  var data = {'email': email, 'password' : password};

  // Starting Web API Call.
  var response = await http.post(Uri.parse(Uri.encodeFull(url)), body: json.encode(data));

  // Getting Server response into variable.
  var message = jsonDecode(response.body);

  // If the Response Message is Matched.
  if(message != 'Invalid'){
    print("acceso");
    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setString('id', message);
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
      NavigationHomeScreen()), (Route<dynamic> route) => false);
  }else{
  }

}


insertarempleado(String correo, String nombre, String apellido, String contrasena, String RFC) async{
  String theUrl = "https://proyectonunoxd.000webhostapp.com/insertarempleado.php";
  
  //var res = 
  await http.post(Uri.parse(Uri.encodeFull(theUrl)),headers: {"Accept":"application/json"},
      body: {
        "u_correo":correo,
        "u_nombre":nombre,
        "u_apellido":apellido,
        "u_contrasena":contrasena,
        "u_RFC":RFC,
      });
      
  /*try{
    var respbody = jsonDecode(res.body.toString());
    print(respbody);
  }catch(e) { 
  }*/
}


loginempleado(String correo,String contrasena) async{
  String theUrl = "https://proyectonunoxd.000webhostapp.com/logearempleado.php";
  
  //var res = 
  await http.post(Uri.parse(Uri.encodeFull(theUrl)),headers: {"Accept":"application/json"},
      body: {
        "u_correo":correo,
        "u_contrasena":contrasena,
      });

  //var respbody = jsonDecode(res.body.toString());
  //print(respbody);

}

datosprestadorservicios() async{
  String theUrl = "https://jsonplaceholder.typicode.com/posts";

  var res = await http.get(Uri.parse(Uri.encodeFull(theUrl)),headers: {"Accept":"application/json"});

  var  responsebody = json.decode(res.body);

  print("${responsebody [0] ["title"]}");
  return responsebody;

}
datosprestadorservicios2() async{
  String theUrl = "https://tadeo46.000webhostapp.com/mostrarservicios.php";

  var res = await http.get(Uri.parse(Uri.encodeFull(theUrl)),headers: {"Accept":"application/json"});

  var  responsebody = json.decode(res.body);

  //print("${responsebody [0] ["title"]}");
  return responsebody;

}

// Modelo constructor del perfil de usuario
Future<List<User>?> fetchUser(http.Client client, String id) async {
    final response = await client
      .get(Uri.parse("https://proyectonunoxd.000webhostapp.com/user.php?id=$id"));
    return compute(parseUser, response.body);
}

// A function that converts a response body into a List<Categorias>.
List<User>? parseUser(String responseBody) {
  try{
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }catch(e){}
  return null;
}

class User {
  final String correo;
  final String nombre;
  final String apellido;
  final String telefono;

  const User({
    required this.correo,
    required this.nombre,
    required this.apellido,
    required this.telefono,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      correo: json['correo'] as String,
      nombre: json['nombre'] as String,
      apellido: json['apellido'] as String,
      telefono: json['telefono'] as String,
    );
  }
}


//Modelo constructor del menu de navegación de home

Future<List<Categorias>?> fetchCategorias(http.Client client, String nombre) async {
  if(nombre != ''){
    final response = await client
      .get(Uri.parse("https://proyectonunoxd.000webhostapp.com/categoriashome.php?nombre=$nombre"));

    return compute(parseCategorias, response.body);
  }else{
    final response = await client
      .get(Uri.parse('https://proyectonunoxd.000webhostapp.com/categoriashome.php'));

    return compute(parseCategorias, response.body);
  }
    
}

// A function that converts a response body into a List<Categorias>.
List<Categorias>? parseCategorias(String responseBody) {
  try{
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Categorias>((json) => Categorias.fromJson(json)).toList();
  }catch(e){}
  return null;
}

class Categorias {
  final String id;
  final String nombre;
  final String color;
  final String icono;

  const Categorias({
    required this.id,
    required this.nombre,
    required this.color,
    required this.icono,
  });

  factory Categorias.fromJson(Map<String, dynamic> json) {
    return Categorias(
      id: json['idTab_Categoria'] as String,
      nombre: json['nombre'] as String,
      color: json['color'] as String,
      icono: json['icono'] as String,
    );
  }
}


//Modelo constructor de navegación categorias
Future<List<TipoServicio>?> fetchTipoServicio(http.Client client, int id, String? nombre) async {
  if(nombre!=''){
    final response = await client
      .get(Uri.parse("https://proyectonunoxd.000webhostapp.com/tiposervicio.php/?id=$id&nombre='$nombre'"));
    return compute(parseTipoServicio, response.body);
  }else{
    final response = await client
      .get(Uri.parse('https://proyectonunoxd.000webhostapp.com/tiposervicio.php/?id=$id'));  
    return compute(parseTipoServicio, response.body);
  }
}


// A function that converts a response body into a List<Categorias>.
List<TipoServicio>? parseTipoServicio(String responseBody) {
  try{
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<TipoServicio>((json) => TipoServicio.fromJson(json)).toList();
  }catch(e){}
  return null;
}

class TipoServicio {
  final String id;
  final String nombre;
  final String descripcion;

  const TipoServicio({
    required this.id,
    required this.nombre,
    required this.descripcion,
  });

  factory TipoServicio.fromJson(Map<String, dynamic> json) {
    return TipoServicio(
      id: json['idTab_tiposervicio'] as String,
      nombre: json['nombre'] as String,
      descripcion: json['descripcion'] as String,
    );
  }
}


//Modelo contructor del menu de trabajos
Future<List<Servicio>?> fetchServicio(http.Client client, int id, String nombre) async {
    if(nombre!=''){
      final response = await client
        .get(Uri.parse("https://proyectonunoxd.000webhostapp.com/servicio.php/?id=$id&nombre='$nombre'"));
      return compute(parseServicio, response.body);
    }else{
      final response = await client
        .get(Uri.parse('https://proyectonunoxd.000webhostapp.com/servicio.php/?id=$id'));
      return compute(parseServicio, response.body);
    }
}

// A function that converts a response body into a List<Categorias>.
List<Servicio>? parseServicio(String responseBody) {
  try{
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Servicio>((json) => Servicio.fromJson(json)).toList();
  }catch(e){}
  return null;
}

class Servicio {
  final String id;
  final String nombre;
  final String descripcion;

  const Servicio({
    required this.id,
    required this.nombre,
    required this.descripcion,
  });

  factory Servicio.fromJson(Map<String, dynamic> json) {
    return Servicio(
      id: json['idTab_servicio'] as String,
      nombre: json['nombre'] as String,
      descripcion: json['descripcion'] as String,
    );
  }
}
