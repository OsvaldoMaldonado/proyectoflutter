import 'dart:convert';
import 'dart:core';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

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

datosespecializaciones() async{
  String theUrl = "https://tadeo46.000webhostapp.com/mostrarespecialidades.php";

  var res = await http.get(Uri.parse(Uri.encodeFull(theUrl)),headers: {"Accept":"application/json"});

  var  responsebody = json.decode(res.body);

  //print("${responsebody [0] ["title"]}");
  return responsebody;

}
// Modelo constructor del perfil de usuario
Future<Employee?> fetchEmployee(http.Client client, String id) async {
    final response = await client
      .get(Uri.parse("https://proyectonunoxd.000webhostapp.com/employee.php/?id=$id"));
    return compute(parseEmployee, response.body);
}

// A function that converts a response body into a List<Categorias>.
Employee? parseEmployee(String responseBody) {
  Map<String, dynamic> map = jsonDecode(responseBody);
  Employee person = Employee.fromJson(map);
  return person;
}

class Employee {
  final String correo;
  final String nombre;
  final String apellido;
  final String telefono;
  final String latitud;
  final String longitud;

  const Employee({
    required this.correo,
    required this.nombre,
    required this.apellido,
    required this.telefono,
    required this.latitud,
    required this.longitud,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      correo: json['correo'] as String,
      nombre: json['nombre'] as String,
      apellido: json['apellido'] as String,
      telefono: json['telefono'] as String,
      latitud: json['latitud'] as String,
      longitud: json['longitud'] as String,
    );
  }
}


Future<String> getLocacion(double latitud, double longitud) async {
  List<Placemark> placemarks = await placemarkFromCoordinates(latitud, longitud);   
  var locacion = placemarks[0].subLocality.toString() + ", " + placemarks[0].locality.toString();
  return locacion;
}