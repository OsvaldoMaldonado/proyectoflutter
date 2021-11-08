// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:core';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

//Modelo constructor del menu de navegación de home
Future<List<TrabajosEmpleado>?> fetchTrabajosEmpleado(http.Client client,int id) async {
    final response = await client
      .get(Uri.parse("https://proyectonunoxd.000webhostapp.com/home_empleados.php/?id=$id"));
    return compute(parseTrabajosEmpleado, response.body);  
}

// A function that converts a response body into a List<Empleados>.
List<TrabajosEmpleado>? parseTrabajosEmpleado(String responseBody) {
  try{
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<TrabajosEmpleado>((json) => TrabajosEmpleado.fromJson(json)).toList();
  }catch(e){}
  return null;
}

class TrabajosEmpleado {
  final String estado_servicio;
  final String fecha_publicacion;
  final String costo;
  final String latitud;
  final String longitud;
  final String descripcion;
  final String nombre;
  final String apellido;
  final String telefono;
  final String nombreS;

  const TrabajosEmpleado({
    required this.estado_servicio,
    required this.fecha_publicacion,
    required this.costo,
    required this.latitud, 
    required this.longitud,
    required this.descripcion,
    required this.nombre,
    required this.apellido,
    required this.telefono,
    required this.nombreS,
  });
  factory TrabajosEmpleado.fromJson(Map<String, dynamic> json) {
    return TrabajosEmpleado(
      estado_servicio: json['estado_servicio'] as String,
      fecha_publicacion: json['fecha_publicacion'] as String,
      costo: json['costo'] as String,
      latitud: json['latitud'] as String,
      longitud: json['longitud'] as String,
      descripcion: json['descripcion'] as String,
      nombre: json['nombre'] as String,
      apellido: json['apellido'] as String,
      telefono: json['telefono'] as String,
      nombreS: json['nombreS'] as String,
    );
  }
}
