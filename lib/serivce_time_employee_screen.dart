import 'package:flutter/material.dart';
import 'package:servicios_vic/model/modelo_servicios_cuentas.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:time_range/time_range.dart';

class ServiceTimeEmployeeScreen extends StatefulWidget{
   const ServiceTimeEmployeeScreen({Key? key}) : super(key: key);

  @override
  ServiceTimeEmployeeState createState() => ServiceTimeEmployeeState();
}


class ServiceTimeEmployeeState extends State<ServiceTimeEmployeeScreen> {
  
  static const orange = Color(0xFFFE9A75);
  static const dark = Color(0xFF333A47);
  static const double leftPadding = 50;

  final _defaultTimeRange = TimeRangeResult(
    TimeOfDay(hour: 14, minute: 50),
    TimeOfDay(hour: 15, minute: 20),
  );
  TimeRangeResult? _timeRange;

  @override
  void initState() {
    super.initState();
    _timeRange = _defaultTimeRange;
  }

  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
        foregroundColor: const Color(0xFFF96332),
        title: const Text('Horario de servicio', style: TextStyle(fontSize: 20.0,color: Colors.black,),)
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(height: screenheight * 0.01),
            TimeRange(
              fromTitle: const Text(
                'Desde',
                style: TextStyle(
                  fontSize: 18,
                  color: dark,
                ),
              ),
              toTitle: const Text(
                'Hasta',
                style: TextStyle(
                  fontSize: 18,
                  color: dark,
                ),
              ),
              titlePadding: screenSize * 0.05,
              textStyle: const TextStyle(
                fontWeight: FontWeight.normal,
                color: dark,
              ),
              activeTextStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                color: orange,
              ),
              borderColor: dark,
              activeBorderColor: dark,
              backgroundColor: Colors.transparent,
              activeBackgroundColor: dark,
              firstTime: TimeOfDay(hour: 0, minute: 00),
              lastTime: TimeOfDay(hour: 24, minute: 00),
              initialRange: _timeRange,
              timeStep: 10,
              timeBlock: 20,
              onRangeCompleted: (range) => setState(() => _timeRange = range),
            ),
            SizedBox(height: screenheight * 0.02),
            if (_timeRange != null)
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Rango seleccionado: ${_timeRange!.start.format(context)} - ${_timeRange!.end.format(context)}',
                      style: TextStyle(fontSize: 20, color: dark),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            Container(
              alignment: Alignment.topRight,
              padding: EdgeInsets.only(right: screenSize * 0.05),
              child: OutlinedButton(
              onPressed: (){
              },
              child: const Text('Aceptar', style: TextStyle(color: Colors.white, fontSize: 14)),
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(20)),
                  side: const BorderSide( width: 0.5, color: Color(0xFFF96332),),
                    //  padding: EdgeInsets.all(60),
                  minimumSize: Size(screenSize * 0.30, screenheight * 0.05),
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
