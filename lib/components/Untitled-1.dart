/*child: ListView(
          // Important: Remove any padding from the ListView.
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFF96332),
                    Color(0xFFFF6365),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Container(
                alignment: Alignment.bottomLeft,
                child: const Text(""),
              ),  
            ),
            Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(left: 12.0,top: 6.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,MaterialPageRoute(builder: (context) => const EmployeeProfileScreen()));
                    },
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.person_pin, size: 30.0),
                        SizedBox(width: screenSize*0.02,),
                        const Text('Mi cuenta',style: TextStyle(fontSize: 18.0,color: Colors.black,),),
                      ],
                    )
                  )
                ),
                Container(
                  margin: const EdgeInsets.only(left: 12.0,top: 12.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ServicesEmployeeScreen()));
                    },
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.access_time,size: 30.0),
                        SizedBox(width: screenSize*0.02,),
                        const Text('Historial de servicios',style: TextStyle(fontSize: 18.0,color: Colors.black,),),
                      ],
                    )
                  )
                ),
                Container(
                  margin: const EdgeInsets.only(left: 12.0,top: 12.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ServiceTimeEmployeeScreen()));
                    },
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.time_to_leave,size: 30.0),
                        SizedBox(width: screenSize*0.02,),
                        const Text('Configuración de Diponibilidad',style: TextStyle(fontSize: 18.0,color: Colors.black,),),
                      ],
                    )
                  )
                ),
                Container(
                  margin: const EdgeInsets.only(left: 12.0,top: 12.0),
                  child: InkWell(
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.location_on,size: 30.0),
                        SizedBox(width: screenSize*0.02,),
                        const Text('Ubicaciones',style: TextStyle(fontSize: 18.0,color: Colors.black,),),
                      ],
                    )
                  )
                ),
                Container(
                  margin: const EdgeInsets.only(left: 12.0,top: 12.0),
                  child: InkWell(
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.account_balance, size: 30.0),
                        SizedBox(width: screenSize*0.02,),
                        const Text('Terminos y condiciones',style: TextStyle(fontSize: 18.0,color: Colors.black,),),
                      ],
                    )
                  )
                ),
                Container(
                  margin: const EdgeInsets.only(left: 12.0,top: 12.0),
                  child: InkWell(
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.help, size: 30.0),
                        SizedBox(width: screenSize*0.02,),
                        const Text('Ayuda',style: TextStyle(fontSize: 18.0,color: Colors.black,),),
                      ],
                    )
                  )
                ),
                Container(height: screenheight*.40,),
                Container(
                  margin: const EdgeInsets.only(left: 12.0,top: 6.0),
                  child: InkWell(
                    onTap: () async {
                       SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.remove('id');
                        prefs.remove('type');
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (BuildContext ctx) => const HomeScreen()));
                    },
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.logout, size: 30.0),
                        SizedBox(width: screenSize*0.02,),
                        const Text('Cerrar Sesión',style: TextStyle(fontSize: 18.0,color: Colors.black,),),
                      ],
                    )
                  )
                ),
              ],
            ),
          ],
        ),
        
        
        
        
        
         Container(
                      child: OutlinedButton(
                      onPressed: (){
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyHomePage(latitud:trabajosEmpleado[index].latitud, longitud:trabajosEmpleado[index].longitud)),
                        );
                      },
                      child: const Text('Ver ubicación', style: TextStyle(color: Colors.white, fontSize: 14)),
                        style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                          side: const BorderSide( width: 0.5, color: Color(0xFFF96332),),
                            //  padding: EdgeInsets.all(60),
                          minimumSize: Size(screenSize * 0.30, screenHeight * 0.05),
                          backgroundColor: const Color(0xFFF96332),
                        ),
                      ),
                    )
        
        
        
        
        
        
        
        
        
        
        */