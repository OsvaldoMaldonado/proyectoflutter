// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:servicios_vic/model/modelo_navegacion_usuario.dart';
import 'package:servicios_vic/paypal_payment.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationConfirmJobScreen extends StatefulWidget {
  final String? servicio;
  final int? id_servicio;
  final String? id_prestador;
  final String? prestador;

  const NavigationConfirmJobScreen(
      {Key? key,
      this.servicio,
      this.id_servicio,
      this.id_prestador,
      this.prestador})
      : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  NavigationConfirmJobState createState() => NavigationConfirmJobState(
      id_servicio: id_servicio,
      servicio: servicio,
      id_prestador: id_prestador,
      prestador: prestador);
}

class NavigationConfirmJobState extends State<NavigationConfirmJobScreen> {
  String dropdownValue = 'Efectivo';

  NavigationConfirmJobState(
      {Key? key,
      this.servicio,
      this.id_servicio,
      this.id_prestador,
      this.prestador});
  String busqueda = "";
  String locacion = "";
  String descripcion = "";
  String id = "";
  double latitud = 0.0, longitud = 0.0;

  TextEditingController descripcion_controller = TextEditingController();

  Future<void> setBuscador(String textoBuscador) async {
    //print(textoBuscador);
    setState(() => busqueda = textoBuscador);
  }

  final String? servicio;
  final int? id_servicio;
  final String? id_prestador;
  final String? prestador;

  String _getCurrentDate() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    return formatted; // something like 2013-04-20
  }

  void _getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {});
      } else {
        var position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        List<Placemark> placemarks = await placemarkFromCoordinates(
            position.latitude, position.longitude);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        setState(() {
          id = prefs.getString('id')!;
          latitud = position.latitude;
          longitud = position.longitude;
          locacion = placemarks[0].street.toString() +
              ", " +
              placemarks[0].subLocality.toString() +
              ", " +
              placemarks[0].locality.toString();
        });
      }
    } else {
      var position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        id = prefs.getString('id')!;
        latitud = position.latitude;
        longitud = position.longitude;
        locacion = placemarks[0].street.toString() +
            ", " +
            placemarks[0].subLocality.toString() +
            ", " +
            placemarks[0].locality.toString();
      });
    }
  }

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          backgroundColor: Color(0xFFF1F0F5),
          elevation: 0,
          shadowColor: Colors.transparent,
          foregroundColor: const Color(0xFFF96332),
          title: const Text(
            'Confirmar contrato',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
            ),
          )),
      body: Container(
        color: Color(0xFFF1F0F5),
        width: screenSize,
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 4.0, bottom: 4.0, left: 18),
              child: Row(
                children: const <Widget>[
                  Text(
                    "Estado: Pendiente",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ],
              ),
            ),
            const Divider(color: Color(0xFFF96332), thickness: 1.0),
            Container(
              width: screenSize * .90,
              margin: const EdgeInsets.only(top: 4.0, bottom: 4.0),
              child: Row(
                children: <Widget>[
                  Text(
                    "Fecha: " + _getCurrentDate(),
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ],
              ),
            ),
            const Divider(color: Color(0xFFF96332), thickness: 1.0),
            Container(
              width: screenSize * .90,
              child: const Flexible(
                child: Text(
                  "Costo: \$50.0MX",
                  maxLines: 15,
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ),
            ),
            Container(
              width: screenSize * .90,
              child: const Flexible(
                child: Text(
                  "(Este precio es el costo de la visita, nuestro prestador evaluara el precio real del servicio)",
                  maxLines: 15,
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ),
            ),
            const Divider(color: Color(0xFFF96332), thickness: 1.0),
            Container(
              width: screenSize * .90,
              margin: const EdgeInsets.only(top: 4.0, bottom: 4.0),
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: Text(
                      "Ubicación: " + locacion,
                      maxLines: 15,
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: Color(0xFFF96332), thickness: 1.0),
            Container(
              width: screenSize * .90,
              margin: const EdgeInsets.only(top: 4.0, bottom: 4.0),
              child: Column(
                children: <Widget>[
                  const Text(
                    "Descripción: ",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  TextField(
                    controller: descripcion_controller,
                    decoration: const InputDecoration(
                      labelText: 'Escriba su descripción del trabajo',
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: Color(0xFFF96332), thickness: 1.0),
            Container(
              width: screenSize * .90,
              margin: const EdgeInsets.only(top: 4.0, bottom: 4.0),
              child: Row(
                children: <Widget>[
                  Text(
                    "Prestador: $prestador",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ],
              ),
            ),
            const Divider(color: Color(0xFFF96332), thickness: 1.0),
            Container(
              width: screenSize * .90,
              margin: const EdgeInsets.only(top: 4.0, bottom: 4.0),
              child: Row(
                children: <Widget>[
                  Text(
                    "Servicio: $servicio",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4.0, bottom: 4.0, left: 18),
              alignment: Alignment.centerLeft,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                      if (dropdownValue == 'Efectivo') {
                      } else {
                        if (dropdownValue == 'Paypal') {}
                      }
                    });
                  },
                  items: <String>['Efectivo', 'Paypal']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 4.0, top: screenHeight * 0.3),
              alignment: Alignment.bottomCenter,
              child: OutlinedButton(
                onPressed: () {
                  descripcion = descripcion_controller.text.toString();
                  if (dropdownValue == 'Paypal') {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => PaypalPayment(
                          onFinish: (number) async {
                            // payment done
                            insertartrabajo(
                                "activo",
                                _getCurrentDate(),
                                50.0,
                                latitud,
                                longitud,
                                descripcion,
                                int.parse(id_prestador.toString()),
                                int.parse(id),
                                id_servicio,
                                context);
                          },
                        ),
                      ),
                    );
                  } else {
                    insertartrabajo(
                        "activo",
                        _getCurrentDate(),
                        0.0,
                        latitud,
                        longitud,
                        descripcion,
                        int.parse(id_prestador.toString()),
                        int.parse(id),
                        id_servicio,
                        context);
                  }
                },
                child: const Text('Crear contrato',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                style: OutlinedButton.styleFrom(
                  shape: const StadiumBorder(
                      side: BorderSide(
                    width: 20,
                  )),
                  side: const BorderSide(
                    width: 1,
                    color: Color(0xFFF96332),
                  ),
                  //  padding: EdgeInsets.all(60),
                  minimumSize: Size(screenSize * 0.90, screenHeight * 0.15),
                  backgroundColor: const Color(0xFFF96332),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
