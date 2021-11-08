import 'dart:convert';
import 'dart:core';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;


Future<String> getLocacion(double latitud, double longitud) async {
  List<Placemark> placemarks = await placemarkFromCoordinates(latitud, longitud);   
  var locacion = placemarks[0].subLocality.toString() + ", " + placemarks[0].locality.toString() + ", " + placemarks[0].street.toString();
  return locacion;
}

// Modelo constructor del perfil de usuario
Future<List<HistorialServicios>?> fetchHistorialServiciosUsuario(http.Client client, String id) async {
    final response = await client
      .get(Uri.parse("https://proyectonunoxd.000webhostapp.com/historial_de_servicios_usuario.php/?id=$id"));
    return compute(parseHistorialServiciosUsuario, response.body);
}

// A function that converts a response body into a List<Categorias>.
List<HistorialServicios>? parseHistorialServiciosUsuario(String responseBody) {
  try{
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<HistorialServicios>((json) => HistorialServicios.fromJson(json)).toList();
  }catch(e){}
  return null;
}

class HistorialServicios {
  final String fecha_publicacion;
  final String fecha_aceptacion;
  final String latitud;
  final String longitud;
  final String costo;
  final String valoracion;
  final String resena;
  final String descripcion;
  final String nombre;
  final String apellido;
  final String nombre_servicio;

  const HistorialServicios({
    required this.fecha_publicacion,
    required this.fecha_aceptacion,
    required this.latitud,
    required this.longitud,
    required this.costo,
    required this.valoracion,
    required this.resena,
    required this.descripcion,
    required this.nombre,
    required this.apellido,
    required this.nombre_servicio,
  });

  factory HistorialServicios.fromJson(Map<String, dynamic> json) {
    return HistorialServicios(
      fecha_publicacion: json['fecha_publicacion'] as String,
      fecha_aceptacion: json['fecha_aceptacion'] as String,
      latitud: json['latitud'] as String,
      longitud: json['longitud'] as String,
      costo: json['costo'] as String,
      valoracion: json['valoracion'] as String,
      resena: json['resena'] as String,
      descripcion: json['descripcion'] as String,
      nombre: json['nombre'] as String,
      apellido: json['apellido'] as String,
      nombre_servicio: json['nombre_servicio'] as String,
    );
  }
}



// Modelo constructor del perfil de usuario
Future<List<HistorialServiciosEmpleadoP>?> fetchHistorialServiciosEmpleadoP(http.Client client, String id, String estado) async {
    final response = await client
      .get(Uri.parse("https://proyectonunoxd.000webhostapp.com/historial_de_servicios_empleado_pendientes.php/?id=$id&estado=$estado"));
    return compute(parseHistorialServiciosEmpleadoP, response.body);
}

// A function that converts a response body into a List<Categorias>.
List<HistorialServiciosEmpleadoP>? parseHistorialServiciosEmpleadoP(String responseBody) {
  try{
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<HistorialServiciosEmpleadoP>((json) => HistorialServiciosEmpleadoP.fromJson(json)).toList();
  }catch(e){}
  return null;
}

class HistorialServiciosEmpleadoP {
  final String fecha_publicacion;
  final String fecha_aceptacion;
  final String latitud;
  final String longitud;
  final String costo;
  final String valoracion;
  final String resena;
  final String descripcion;
  final String nombre;
  final String apellido;
  final String nombre_servicio;

  const HistorialServiciosEmpleadoP({
    required this.fecha_publicacion,
    required this.fecha_aceptacion,
    required this.latitud,
    required this.longitud,
    required this.costo,
    required this.valoracion,
    required this.resena,
    required this.descripcion,
    required this.nombre,
    required this.apellido,
    required this.nombre_servicio,
  });

  factory HistorialServiciosEmpleadoP.fromJson(Map<String, dynamic> json) {
    return HistorialServiciosEmpleadoP(
      fecha_publicacion: json['fecha_publicacion'] as String,
      fecha_aceptacion: json['fecha_aceptacion'] as String,
      latitud: json['latitud'] as String,
      longitud: json['longitud'] as String,
      costo: json['costo'] as String,
      valoracion: json['valoracion'] as String,
      resena: json['resena'] as String,
      descripcion: json['descripcion'] as String,
      nombre: json['nombre'] as String,
      apellido: json['apellido'] as String,
      nombre_servicio: json['nombre_servicio'] as String,
    );
  }
}


//https://proyectonunoxd.000webhostapp.com/historial_de_servicios_usuario.php/?id=2