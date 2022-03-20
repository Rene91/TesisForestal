import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forestal_app/Modelo/Arboles.dart';
import 'package:forestal_app/componentsGeneral/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class VerIdFormGeoUbicacionArbolScreen extends StatefulWidget {
  const VerIdFormGeoUbicacionArbolScreen({Key? key}) : super(key: key);

  @override
  _VerIdFormGeoUbicacionArbolScreenState createState() =>
      _VerIdFormGeoUbicacionArbolScreenState();
}

class _VerIdFormGeoUbicacionArbolScreenState
    extends State<VerIdFormGeoUbicacionArbolScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  Set<Marker> _listMarkers = {};
  late double latitud = geoLatitud;
  late double longitud = geoLongitud;
  late double zoom = geoZoom;
  late String id = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Arboles? _objArbol = ModalRoute.of(context)!.settings.arguments
        as Arboles?; //cargamos datos del arbol
    _crearMarkerts(
        _objArbol!.getId_a.toString(),
        double.parse(_objArbol.latitud_a.toString()),
        double.parse(_objArbol.longitud_a.toString()),
        _objArbol.nombre_comun_a.toString());

    Widget _buildContainer() {
      return Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 20.0),
          height: 130.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              const SizedBox(width: 10.0),
              /*Creamoa caja de imagen*/
              Padding(
                padding: const EdgeInsets.all(10),
                child: _boxes(
                    _objArbol.getFoto_a.toString(),
                    double.parse(_objArbol.latitud_a.toString()),
                    double.parse(_objArbol.longitud_a.toString()),
                    _objArbol.nombre_comun_a.toString(),
                    _objArbol.nombre_cientifico_a.toString(),
                  _objArbol.getId_a.toString(),
                  _objArbol.getFamilia_a.toString(),
                  _objArbol.getSector_a.toString(),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Geo Ubicación Árbol'),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(
              FontAwesomeIcons.cannabis,
              color: kSecondColor,
            ),
            tooltip: 'Grid',
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              mapType: MapType.hybrid,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: false,
              initialCameraPosition:
                  CameraPosition(target: LatLng(latitud, longitud), zoom: zoom),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: _listMarkers,
            ),
          ),
          _buildContainer(),
        ],
      ),
    );
  }

/* ***************************** Creacion de ventana en pantalla ******************************** */
  Widget _boxes(String _image, double lat, double long, String nomComun,
      String nomCientifico, String id_arbol, String familia, String sector) {
    return GestureDetector(
      onTap: () {
        _gotoLocation(lat, long);
      },
      child: FittedBox(
        child: Material(
            color: Colors.white,
            elevation: 14.0,
            borderRadius: BorderRadius.circular(2.0),
            shadowColor: const Color(0x802196F3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: 180,
                  height: 180,
                  child: _image != ""
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(24.0),
                          child: Material(
                              color: kPrimaryColor,
                              child: Image(
                                fit: BoxFit.fill,
                                image: NetworkImage(_image),
                              )),
                        )
                      : const Material(
                          child: Icon(
                            Icons.add_a_photo_outlined,
                            color: kPrimaryColor,
                            size: 150,
                          ),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: myDetailsContainer1(nomComun, nomCientifico, id_arbol, familia, sector),
                ),
              ],
            )),
      ),
    );
  }

  Widget myDetailsContainer1(String nomComun, String nomCientifico, String id_arbol, String familia, String sector) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        const Text(
                          "Sector: ",
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          sector,
                          style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        const Text(
                          "Familia: ",
                          style: TextStyle(
                              color: kSecondColor,
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          familia,
                          style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ]),
                ])),
        const SizedBox(height: 5.0),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "Código: " + id_arbol,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 20.0,
              ),
            ),
            //SizedBox(width: 5.0),
            Text(
              "Nombre común",
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold
              ),
            ),
            Text(
              nomComun,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 20.0,
              ),
            ),
            //SizedBox(width: 5.0),
          ],
        ),
      ],
    );
  }

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(lat, long),
        bearing: 192.8334901395799,
        tilt: 59.440717697143555,
        zoom: 19.151926040649414)));
  }

/* ************************ Caragamos markets ************************************ */
  Future<Uint8List> _crearAvatar() async {
    final iconData = Icons.location_on_outlined;
    //final iconData = FontAwesomeIcons.tree;
    final pictureRecorder = PictureRecorder();
    final canvas = Canvas(pictureRecorder);
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    final iconStr = String.fromCharCode(iconData.codePoint);
    textPainter.text = TextSpan(
        text: iconStr,
        style: TextStyle(
          letterSpacing: 0.0,
          fontSize: 100.0,
          fontFamily: iconData.fontFamily,
          color: kSecondColor,
        ));
    textPainter.layout();
    textPainter.paint(canvas, const Offset(0.0, 0.0));
    final picture = pictureRecorder.endRecording();
    final image = await picture.toImage(100, 100);
    final bytes = await image.toByteData(format: ImageByteFormat.png);
    return bytes!.buffer.asUint8List();
  }

  void _crearMarkerts(
      String id, double Lat, double Lng, String infoWindow) async {
    Set<Marker> newMarkers = {};
    var bitmapData = await _crearAvatar();
    var bitmapDescripcion = BitmapDescriptor.fromBytes(bitmapData);
    /*var bitmapDescripcion = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(10, 10)), 'assets/images/arbol.png');*/

    newMarkers.add(Marker(
      markerId: MarkerId(id),
      position: LatLng(Lat, Lng),
      infoWindow: InfoWindow(title: infoWindow),
      icon: bitmapDescripcion,
      anchor: const Offset(0.5, 0.5), /* ubicacion exacta persona*/
      //icon: BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(24, 24)), 'assets/my_icon.png'),
      /*icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueRose,
      ),*/
    ));
    setState(() {
      _listMarkers = newMarkers;
    });
  }
}
