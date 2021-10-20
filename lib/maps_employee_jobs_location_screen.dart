import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as location;
import 'package:geocoding/geocoding.dart';


class MyHomePage extends StatefulWidget {
  final String? latitud;
  final String? longitud;

  const MyHomePage({Key? key, this.latitud, this.longitud}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState(latitud: latitud, longitud: longitud);
}

class _MyHomePageState extends State<MyHomePage> {

  _MyHomePageState({Key? key, this.latitud, this.longitud});
  final LatLng _initialcameraposition = const LatLng(20.5937, 78.9629);
  late GoogleMapController _controller;
  final location.Location _location = location.Location();
  final String? latitud;
  final String? longitud;


  void _onMapCreated(GoogleMapController _cntlr)
  {
    _controller = _cntlr;
    _location.onLocationChanged.listen((l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude),zoom: 15),
          ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
        foregroundColor: const Color(0xFFF96332),
        title: const Text('Mis trabajos activos', style: TextStyle(fontSize: 20.0,color: Colors.black,),)
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            GoogleMap(
              markers: _createMarkers(),
              initialCameraPosition: CameraPosition(target: _initialcameraposition),
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              //myLocationEnabled: true,
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