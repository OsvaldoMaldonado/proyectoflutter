import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as location;
import 'package:geocoding/geocoding.dart';
import 'package:servicios_vic/model/modelo_navegacion_empleado.dart';
import 'package:http/http.dart' as http;

import 'model/modelo_perfil_cuentas.dart';


class MyHomePage extends StatefulWidget {
  final String latitud;
  final String longitud;
  final String trabajoId;

  const MyHomePage({Key? key, required this.latitud,required this.longitud,required this.trabajoId}) : super(key: key);
  @override
  // ignore: no_logic_in_create_state
  _MyHomePageState createState() => _MyHomePageState(latitud: latitud, longitud: longitud, trabajoId: trabajoId);
}

class _MyHomePageState extends State<MyHomePage> {

  _MyHomePageState({Key? key, required this.latitud, required this.longitud, required this.trabajoId});
  final LatLng _initialcameraposition = const LatLng(23.74517489950849, -99.12962892142436);
  late GoogleMapController _controller;
  final location.Location _location = location.Location();
  final String latitud;
  final String longitud;
  final String trabajoId;


  void _onMapCreated(GoogleMapController _cntlr)
  {
    _controller = _cntlr;
    _location.onLocationChanged.listen((l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude!, l.longitude!),zoom: 12),
          ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
        foregroundColor: const Color(0xFFF96332),
        title: const Text('Mis trabajos activos', style: TextStyle(fontSize: 20.0,color: Colors.black,),)
      ),
      body: SizedBox(
        height: screenHeight,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                alignment: Alignment.topCenter,
                height: screenHeight * 0.40,
                child: GoogleMap(
                  markers: _createMarkers(),
                  initialCameraPosition: CameraPosition(target: _initialcameraposition),
                  mapType: MapType.normal,
                  scrollGesturesEnabled: true,
                  tiltGesturesEnabled: false,
                  trafficEnabled: false,
                  compassEnabled: true,
                  rotateGesturesEnabled: false,
                  myLocationEnabled: true,
                  zoomGesturesEnabled: true,
                  onMapCreated: _onMapCreated,
                ),
              )
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: screenHeight * 0.51,
                child: FutureBuilder<TrabajosEmpleado?>(   
                  future: fetchDetallesTrabajoEmpleado(http.Client(), trabajoId),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('An error has occurred!'),
                      );
                    } else if (snapshot.hasData) {
                      //return Text(snapshot.data!.correo);
                      return DetallesTrabajo(detallesTrabajosEmpleado: snapshot.data!);
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Set<Marker> _createMarkers() {
    var tmp = <Marker>{};
      tmp.add(
        Marker(
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
          markerId: MarkerId("Lugar de trabajo"),
          position: LatLng(double.parse(latitud.toString()), double.parse(longitud.toString())),
          infoWindow: const InfoWindow(title: "Lugar de trabajo"),
        ),
      );
    return tmp;
  }

}


class DetallesTrabajo extends StatefulWidget{
  const DetallesTrabajo({Key? key,required this.detallesTrabajosEmpleado}) : super(key: key);
  final TrabajosEmpleado detallesTrabajosEmpleado;

  @override
  // ignore: no_logic_in_create_state
  DetallesTrabajoState createState() => DetallesTrabajoState(trabajosEmpleado: detallesTrabajosEmpleado);
}


class DetallesTrabajoState extends State<DetallesTrabajo> {
  DetallesTrabajoState({Key? key,required this.trabajosEmpleado});

  var locacion = "";

  final TrabajosEmpleado trabajosEmpleado;
  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
        //border: Border.all(color: const Color(0xFFF96332), width: 1),
      ),
      // ignore: prefer_const_constructors
      child: Container(
        margin: EdgeInsets.only(
            left: screenSize * 0.05,
            right: screenSize * 0.05,
            bottom: 10.0,
            top: 10.0
        ),
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 4.0, bottom: 10.0),
              child: Row(
                children: <Widget>[
                  Text("Detalles del servicio", textAlign: TextAlign.left,style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4.0, bottom: 6.0, left: 7.0),
              child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(flex: 2, child: Text("Servicio", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),                            
                  Expanded(flex: 5, child: Text(trabajosEmpleado.nombreS, style: const  TextStyle(fontSize: 17, color: Colors.black54,))),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4.0, bottom: 6.0, left: 7.0),
              child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(flex: 2, child: Text("Fecha", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),                            
                  Expanded(flex: 5, child: Text(trabajosEmpleado.fecha_publicacion, style:  TextStyle(fontSize: 17, color: Colors.black54,))),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4.0, bottom: 6.0, left: 7.0),
              child: Row(
                children: <Widget>[
                  Expanded(flex: 2, child: Text("Pago", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),                            
                  Expanded(flex: 5, 
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("\$" + trabajosEmpleado.costo + " MXN", textAlign: TextAlign.left,style:  TextStyle(fontSize: 17, color: Colors.black54,)),
                        OutlinedButton(
                          onPressed: (){
                          },
                          child: const Text('Nuevo Precio', style: TextStyle(color: Colors.white, fontSize: 14)),
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                            side: const BorderSide( width: 0.5, color: Color(0xFFF96332),),
                            //  padding: EdgeInsets.all(60),
                            minimumSize: Size(screenSize * 0.1, screenHeight * 0.045),
                            backgroundColor: const Color(0xFFF96332),
                          ),
                        ),
                      ]
                    ),
                  )
                ]
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4.0, bottom: 6.0, left: 7.0),
              child: FutureBuilder<String>(   
                future: getLocacion2(double.parse(trabajosEmpleado.latitud), double.parse(trabajosEmpleado.longitud)),
                builder: (context, snapshot){
                  if (snapshot.hasError) {
                    return Container(
                      child: Text('An error has occurred!'),
                    );
                  } else if (snapshot.hasData) {
                    return Row (
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget> [ 
                        Expanded(flex: 2, child: Text("Ubicación", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),                            
                        Expanded(flex: 5, child: Text(snapshot.data.toString(), style: const  TextStyle(fontSize: 17, color: Colors.black54,))),
                    ]);
                  } else {
                    return Container(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4.0, bottom: 6.0, left: 7.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(flex: 2, child: Text("Nombre del Cliente", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),                            
                  Expanded(flex: 5, child: Text(trabajosEmpleado.nombre + " " + trabajosEmpleado.apellido, textAlign: TextAlign.left,style:  TextStyle(fontSize: 17, color: Colors.black54,))),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4.0, bottom: 6.0, left: 7.0),
              child: Row(
                children: <Widget>[
                  Expanded(flex: 2, child: Text("Numero Telefonico", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),                            
                  Expanded(flex: 5, child: Text(trabajosEmpleado.telefono, textAlign: TextAlign.left,style: TextStyle(fontSize: 17, color: Colors.black54,))),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4.0, bottom: 6.0, left: 7.0),
              child: Row(
                children: <Widget>[
                  Expanded(flex: 2, child: Text("Descripción", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),                            
                  Expanded(flex: 5, child: Text(trabajosEmpleado.descripcion, textAlign: TextAlign.left,style: TextStyle(fontSize: 17, color: Colors.black54,))),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.05,),
            OutlinedButton(
              onPressed: (){
               
              },
              child: const Text('Finalizar Contrato', style: TextStyle(color: Colors.white, fontSize: 14)),
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
                  side: const BorderSide( width: 0.5, color: Color(0xFFF96332),),
                    //  padding: EdgeInsets.all(60),
                  minimumSize: Size(screenSize * 0.92, screenHeight * 0.045),
                  backgroundColor: const Color(0xFFF96332),
                ),
            ),
          ],
        ),       
      ),
    );  
  }
}