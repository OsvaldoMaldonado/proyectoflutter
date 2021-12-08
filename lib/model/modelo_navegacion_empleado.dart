// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:core';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:servicios_vic/screens_employee/navigation_home_employee_screen.dart';

//Modelo constructor del menu de navegación de home
Future<List<TrabajosEmpleado>?> fetchTrabajosEmpleado(http.Client client,String id, String estado) async {
    final response = await client
      .get(Uri.parse("https://proyectonunoxd.000webhostapp.com/pagina_principal_empleados.php/?id=$id&estado='$estado'"));
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
  final String id;
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
  final String icono;
  final String color;

  const TrabajosEmpleado({
    required this.id,
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
    required this.icono,
    required this.color
  });
  factory TrabajosEmpleado.fromJson(Map<String, dynamic> json) {
    return TrabajosEmpleado(
      id: json['id'] as String,
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
      icono: json['icono'] as String,
      color: json['color'] as String
    );
  }
}

// Modelo constructor del perfil de usuario
Future<TrabajosEmpleado?> fetchDetallesTrabajoEmpleado(http.Client client, String id) async {
    final response = await client
      .get(Uri.parse("https://proyectonunoxd.000webhostapp.com/detalles_trabajo_empleado.php/?id=$id"));
    return compute(parseDetalles, response.body);
}

// A function that converts a response body into a List<Categorias>.
TrabajosEmpleado? parseDetalles(String responseBody) {
  Map<String, dynamic> map = jsonDecode(responseBody);
  TrabajosEmpleado person = TrabajosEmpleado.fromJson(map);
  return person;
}



// Modelo constructor del perfil de usuario
Future<CambioPrecio?> fetchCambioPrecio(http.Client client, String? id) async {
    final response = await client
      .get(Uri.parse("https://proyectonunoxd.000webhostapp.com/detalles_trabajo_empleado.php/?id=$id"));
    return compute(parseCambioPrecio, response.body);
}

// A function that converts a response body into a List<Categorias>.
CambioPrecio? parseCambioPrecio(String responseBody) {
  Map<String, dynamic> map = jsonDecode(responseBody);
  CambioPrecio person = CambioPrecio.fromJson(map);
  return person;
}

class CambioPrecio{
  final String id;
  final String costo;

  const CambioPrecio({
    required this.id,
    required this.costo,
  });
  factory CambioPrecio.fromJson(Map<String, dynamic> json) {
    return CambioPrecio(
      id: json['id'] as String,
      costo: json['costo'] as String,
    );
  }
}

cambioDeCosto(http.Client client,String costo, String? id,  BuildContext context) async {
    final response = await client
      .get(Uri.parse("https://proyectonunoxd.000webhostapp.com/cambiar_precio_trabajo.php/?costo=$costo&id=$id"));
    var message = jsonDecode(response.body);
    if(message != 'Invalid'){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        const NavigationHomeEmployeeScreen()), (Route<dynamic> route) => false);
    }  
}

finalizacionContrato(http.Client client, String? id,  BuildContext context, String fecha) async {
    final response = await client
      .get(Uri.parse("https://proyectonunoxd.000webhostapp.com/finalizacion_contrato_empleado.php/?id=$id&fecha=$fecha"));
    var message = jsonDecode(response.body);
    if(message != 'Invalid'){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        const NavigationHomeEmployeeScreen()), (Route<dynamic> route) => false);
    }  
}

