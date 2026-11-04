import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:guia_turismo/controllers/gps_controller.dart';
import 'package:provider/provider.dart';
import 'package:guia_turismo/controllers/lugaresController.dart';
import 'package:latlong2/latlong.dart';

class GpsScreen extends StatefulWidget {
  const GpsScreen({super.key});

  @override
  State<GpsScreen> createState() => _GpsScreenState();
}
class _GpsScreenState extends State<GpsScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<GpsController, LugaresController>(
      builder: (context, gpsControle, lugaresControle,child) => Scaffold(
        body: SafeArea(
          top: true,
          bottom: true,
          child: Column(
            //centralizado bonito
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              gpsControle.carregando ? Center(child: CircularProgressIndicator())
              //nao encontrou
              : gpsControle.atual == null ? Center(child: Text("Não foi encontrado")) 
              : Expanded( 
              child: FlutterMap(
                options: MapOptions(
                  initialZoom: 25,
                  initialCenter: gpsControle.atual! // usando ! pois nao esta null
                ),
                children: [
                  TileLayer(
                    urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                    userAgentPackageName: "br.com.guiaturismo.maps",
                  ),
                      MarkerLayer(
                        markers: 
                        lugaresControle.lugares.map(
                          (lugaresSalvos) => Marker(
                            alignment: Alignment.center,
                            width: 50,
                            height: 50,
                            rotate: true,
                            point: LatLng(lugaresSalvos.latitude.toDouble(),
                            lugaresSalvos.longitude.toDouble()),
                            child: Tooltip(
                            message: lugaresSalvos.nome,
                            child: Icon(Icons.place, color: Colors.blueAccent)
                            )
                          ),
                        ).toList() //repassando para lista
                        ),
                        MarkerLayer(
                    markers: 
                    gpsControle.pins.map(
                      (pontoReferencia) => Marker(
                        alignment: Alignment.center,
                        width: 50,
                        height: 50,
                        rotate: true,
                        point: pontoReferencia,
                        child: Icon(Icons.location_on)
                      )
                      ).toList()//repassando para lista
                    ),
                ]
                ) 
              ),
            ],
          )
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => gpsControle.buscarLocal(),
          child: Icon(Icons.person_pin_circle_rounded),
          ),
      )
    );
  }
}