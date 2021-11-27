import 'dart:convert';
import 'dart:core';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:servicios_vic/navigation_home_screen.dart';

//Modelo constructor del menu de navegación de home
Future<List<Categorias>?> fetchCategorias(http.Client client, String nombre) async {
  if(nombre != ''){
    final response = await client
      .get(Uri.parse("https://proyectonunoxd.000webhostapp.com/pagina_principal_usuarios.php?nombre=$nombre"));

    return compute(parseCategorias, response.body);
  }else{
    final response = await client
      .get(Uri.parse('https://proyectonunoxd.000webhostapp.com/pagina_principal_usuarios.php'));

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
      .get(Uri.parse("https://proyectonunoxd.000webhostapp.com/pagina_seleccion_tipo_de_servicio_usuarios.php/?id=$id&nombre='$nombre'"));
    return compute(parseTipoServicio, response.body);
  }else{
    final response = await client
      .get(Uri.parse('https://proyectonunoxd.000webhostapp.com/pagina_seleccion_tipo_de_servicio_usuarios.php/?id=$id'));  
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
        .get(Uri.parse("https://proyectonunoxd.000webhostapp.com/pagina_seleccion_servicio_usuarios.php/?id=$id&nombre='$nombre'"));
      return compute(parseServicio, response.body);
    }else{
      final response = await client
        .get(Uri.parse('https://proyectonunoxd.000webhostapp.com/pagina_seleccion_servicio_usuarios.php/?id=$id'));
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
      .get(Uri.parse("https://proyectonunoxd.000webhostapp.com/pagina_seleccion_empleado_usuarios.php/?sid=$sid&ulatitud=$ulatitud&ulongitud=$ulongitud&nombre='$nombre'"));

    return compute(parseEmpleados, response.body);
  }else{
    final response = await client
      .get(Uri.parse("https://proyectonunoxd.000webhostapp.com/pagina_seleccion_empleado_usuarios.php/?sid=$sid&ulatitud=$ulatitud&ulongitud=$ulongitud"));

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
  final String latitud;
  final String longitud;

  const Empleados({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.telefono,
    required this.imagen,
    required this.latitud,
    required this.longitud,
  });

  factory Empleados.fromJson(Map<String, dynamic> json) {
    return Empleados(
      id: json['id'] as String,
      nombre: json['nombre'] as String,
      apellido: json['apellido'] as String,
      telefono: json['telefono'] as String,
      imagen: json['imagen'] as String,
      latitud: json['latitud'] as String,
      longitud: json['longitud'] as String,
    );
  }
}


insertartrabajo(String estado_servicio, String fecha_publicacion, double costo, double latitud, 
double longitud, String descripcion, int prestador_id, int cliente_id, int? servicio_id, BuildContext context) async{
  String theUrl = "https://proyectonunoxd.000webhostapp.com/crear_nuevo_trabajo.php";
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
