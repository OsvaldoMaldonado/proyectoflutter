import 'dart:convert';
import 'dart:core';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

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
      id: json['id'] as String,
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
      id: json['id'] as String,
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
      id: json['id'] as String,
      nombre: json['nombre'] as String,
      descripcion: json['descripcion'] as String,
    );
  }
}

//Modelo constructor del menu de navegación de home
Future<List<Empleados>?> fetchEmpleados(http.Client client, String nombre ,int sid, double ulatitud, double ulongitud) async {
  if(nombre != ''){
    final response = await client
      .get(Uri.parse("https://proyectonunoxd.000webhostapp.com/empleadosdashboard.php/?sid=$sid&ulatitud=$ulatitud&ulongitud=$ulongitud&nombre='$nombre'"));

    return compute(parseEmpleados, response.body);
  }else{
    final response = await client
      .get(Uri.parse("https://proyectonunoxd.000webhostapp.com/empleadosdashboard.php/?sid=$sid&ulatitud=$ulatitud&ulongitud=$ulongitud"));

    return compute(parseEmpleados, response.body);
  }
    
}

// A function that converts a response body into a List<Empleados>.
List<Empleados>? parseEmpleados(String responseBody) {
  try{
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Empleados>((json) => Empleados.fromJson(json)).toList();
  }catch(e){}
  return null;
}

class Empleados {
  final String id;
  final String nombre;
  final String apellido;
  final String telefono;
  final String imagen;

  const Empleados({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.telefono,
    required this.imagen,
  });

  factory Empleados.fromJson(Map<String, dynamic> json) {
    return Empleados(
      id: json['id'] as String,
      nombre: json['nombre'] as String,
      apellido: json['apellido'] as String,
      telefono: json['telefono'] as String,
      imagen: json['imagen'] as String,
    );
  }
}
