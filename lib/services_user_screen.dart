import 'package:flutter/material.dart';
import 'package:servicios_vic/model/modelo_servicios_cuentas.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ServicesUserScreen extends StatefulWidget{
   const ServicesUserScreen({Key? key}) : super(key: key);

  @override
  ServicesUserState createState() => ServicesUserState();
}


class ServicesUserState extends State<ServicesUserScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  String locacion = "";
  String id = '2';
  double latitud = 0.0, longitud = 0.0;

  void _getiD() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String idUser = prefs.getString('id') ?? '';

      setState(() => id = idUser);
  }

  @override
  void initState() {
    _getiD();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
        foregroundColor: const Color(0xFFF96332),
        title: const Text('Historial de servicios', style: TextStyle(fontSize: 20.0,color: Colors.black,),)
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: screenheight * 0.01),
          Expanded(
            child: FutureBuilder<List<HistorialServicios>?>(
              future: fetchHistorialServiciosUsuario(http.Client(), id),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Ningun Resultado!'),
                  );
                } else if (snapshot.hasData) {
                  return HistorialServiciosUsuarioList(historialServiciosUsuario: snapshot.data!);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
       ],
      ),
    );
  }
}

class HistorialServiciosUsuarioList extends StatelessWidget {
  const HistorialServiciosUsuarioList({Key? key, required this.historialServiciosUsuario});

  final List<HistorialServicios> historialServiciosUsuario;
  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: historialServiciosUsuario.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(
            left: screenSize * 0.05,
            right: screenSize * 0.05,
            bottom: 10.0,
            top: 10.0
          ),
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 2.0,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(historialServiciosUsuario[index].nombre_servicio, textAlign: TextAlign.left,style: const TextStyle(fontSize: 16),),
                    Text("Emitido el: " + historialServiciosUsuario[index].fecha_publicacion, textAlign: TextAlign.left,style: const TextStyle(fontSize: 14),),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 2.0,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(historialServiciosUsuario[index].nombre + " " + historialServiciosUsuario[index].apellido, textAlign: TextAlign.left,style: const TextStyle(fontSize: 14),),
                    Text("Aceptado el: " + historialServiciosUsuario[index].fecha_aceptacion, textAlign: TextAlign.left,style: const TextStyle(fontSize: 14),),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 2.0,),
                child: FutureBuilder<String>(   
                  future: getLocacion(double.parse(historialServiciosUsuario[index].latitud), double.parse(historialServiciosUsuario[index].longitud)),
                  builder: (context, snapshot){
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('An error has occurred!'),
                      );
                    } else if (snapshot.hasData) {
                      return Flexible(
                        child: Text(snapshot.data.toString(), maxLines: 15, style: const TextStyle(fontSize: 14))
                      );
                    } else {
                      return const Center(
                        child: LinearProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 2.0,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("\$" + historialServiciosUsuario[index].costo + " MXN", textAlign: TextAlign.left,style: const TextStyle(fontSize: 14),),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 2.0,),
                child: Flexible(
                  child: Text("Descripción: " + historialServiciosUsuario[index].descripcion, maxLines: 15, textAlign: TextAlign.left,style: const TextStyle(fontSize: 14),),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 2.0,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Calificación: " + historialServiciosUsuario[index].valoracion, textAlign: TextAlign.left,style: const TextStyle(fontSize: 14),),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 2.0,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Reseña: " +historialServiciosUsuario[index].resena, textAlign: TextAlign.left,style: const TextStyle(fontSize: 14),),
                  ],
                ),
              ),
              const Divider(color: Color(0xFFF96332),thickness: 0.5),           
            ],
          ),    
        );    
      },
    );
  }
}