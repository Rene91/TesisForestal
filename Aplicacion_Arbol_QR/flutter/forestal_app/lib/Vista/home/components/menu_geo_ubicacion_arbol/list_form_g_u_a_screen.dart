import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forestal_app/Controlador/ArbolesDB.dart';
import 'package:forestal_app/componentsGeneral/constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ListFormGeoUbicacionArbolScreen extends StatefulWidget {
  const ListFormGeoUbicacionArbolScreen({Key? key}) : super(key: key);

  @override
  _ListFormGeoUbicacionArbolScreenState createState() =>
      _ListFormGeoUbicacionArbolScreenState();
}

class _ListFormGeoUbicacionArbolScreenState
    extends State<ListFormGeoUbicacionArbolScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  Set<Marker> _listMarkers = {};
  List<Widget> _listPadings = [];
  //List<Widget> lista = [];
  static const double latitud = geoLatitud;
  static const double longitud = geoLongitud;
  static const double zoom = geoZoom;
  late String id = "";

  @override
  void initState() {
    super.initState();
    _crearMarkerts();
  }

  @override
  Widget build(BuildContext context) {
    /*Arboles? _objArbol = ModalRoute.of(context)!.settings.arguments
    as Arboles?; */ //cargamos datos del arbol

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
              Row(children: _listPadings)
              //listPadings,
              /*Creamoa caja de imagen*/
            ],
          ),
        ),
      );
    }

    const CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(latitud, longitud),
      zoom: zoom,
    );

    /*const CameraPosition _kLake = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(latitud, longitud),
        tilt: 59.440717697143555,
        zoom: 19.151926040649414);*/

    /* Future<void> _goToTheLake() async {
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
    }*/

    Future<void> _getUbicacionActual() async {
      final GoogleMapController controller = await _controller.future;
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          bearing: 192.8334901395799,
          tilt: 59.440717697143555,
          zoom: 19.151926040649414)));
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: _listMarkers,
            ),
          ),
          _buildContainer(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => {
          setState(() async {
            _getUbicacionActual();
          })
        },
        label: const Text('Mi ubicación'),
        icon: const Icon(FontAwesomeIcons.locationArrow),
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
                            size: 80,
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
              "Común: " + nomComun,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 20.0,
              ),
            ),
            //SizedBox(width: 5.0),
            Text(
              "Cientifico: " + nomCientifico,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 20,
      tilt: 50.0,
      bearing: 45.0,
    )));
  }

/* ************************ Cargamos imagen avatar ************************************ */
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

/* ************************ Cargamos Markerts  ************************************ */
  void _crearMarkerts() async {
    Set<Marker> newMarkers = {};
    List<Widget> newPaddings = [];
    var bitmapData = await _crearAvatar();
    var bitmapDescripcion = BitmapDescriptor.fromBytes(bitmapData);

    ArbolesDB mm = ArbolesDB();
    List? response = await mm.Listar_A("", "nombre_cientifico_a");
    int contPading = 0;
    for (var element in response!) {
      //(element as Map<String, dynamic>).forEach((key, value) {

      //print(element['id_a'].toString());
      newMarkers.add(Marker(
        /*Cargamos marker*/
        markerId: MarkerId(element['id_a'].toString()),
        position: LatLng(double.parse(element['latitud_a'].toString()),
            double.parse(element['longitud_a'].toString())),
        infoWindow: InfoWindow(title: "Nom. Común: " + element['nombre_comun_a'].toString()),
        icon: bitmapDescripcion,
        anchor: const Offset(0.5, 0.5),
      ));

      if (contPading < 5) {
        newPaddings.add(
          Padding(
            padding: const EdgeInsets.all(10),
            child: _boxes(
                element['foto_a'].toString(),
                double.parse(element['latitud_a'].toString()),
                double.parse(element['longitud_a'].toString()),
                element['nombre_comun_a'].toString(),
                element['nombre_cientifico_a'].toString(),
                element['id_a'].toString(),
                element['familia_a'].toString(),
                element['sector_a'].toString()),
          ),
        );
      }
      contPading++;
    }
    setState(() {
      _listMarkers = newMarkers;
      _listPadings = newPaddings;
    });
  }
}
