import 'dart:io';
import 'package:flutter/material.dart';

//const kPrimaryColor = Color(0xFF6A6287);
//const kPrimaryColor = Color(0xFF19212B);
const kPrimaryColor = Color(0xFF8BC34E);
const kGroundColorColor = Color(0xFFE5E5E5);
const kSecondColor = Color(0xFF1B5E20);
//const kSecondColor = Color(0xFF006064);
const kTreeColor = Color(0xFFB9F6CA);
//var miURLServer = Uri.parse('http://192.168.0.110/forestal_app/Modelo/Datos.php');
//String UrlServer = "http://192.168.0.110/forestal_app/";
String UrlServer = "https://r3gsystems.com/forestal_app/";
var miURLServer = Uri.parse(UrlServer + 'Modelo/Datos.php');

/* Usuario */
final globalFormkey_AgregarU = new GlobalKey<FormState>();
final globalFormkey_EditarU = new GlobalKey<FormState>();
final globalFormkey_loginUser = new GlobalKey<FormState>();

/* Presencia de Enfermedades */
final globalFormkey_PresenciaEnfermedades = new GlobalKey<FormState>();
/* Ubicacion de Enfermedades */
final globalFormkey_UbicacionEnfermedades = new GlobalKey<FormState>();
/* Presencia de Enfermedades */
final globalFormkey_PresenciaPlagas = new GlobalKey<FormState>();
/* Acciones Recomendadas */
final globalFormkey_AccionesRecomendadas = new GlobalKey<FormState>();
/* Problemas Fisicos */
final globalFormkey_ProblemasFisicos = new GlobalKey<FormState>();
/* Riesgos Potenciales */
final globalFormkey_RiesgosPotenciales = new GlobalKey<FormState>();
/* Arboles */
final globalFormkey_Arbol = new GlobalKey<FormState>();
/* Riesgos Potenciales */
final globalFormkey_RiesgosArbol = new GlobalKey<FormState>();
/* Estado Fitosanitario */
final globalFormkey_EstadoFitosanitario = new GlobalKey<FormState>();

var refreshkey = GlobalKey<RefreshIndicatorState>();

//////////////// listas despegables  ////////
var listEstadoMadurez = ['Seleccione Opción', 'Joven', 'Adulto', 'Viejo'];
var listFloracion = [
  'Seleccione Opción',
  'Terminado flor',
  'En floración',
  'Iniciando',
  'Sin floración'
];
var listFructuacion = [
  'Seleccione Opción',
  'Terminado fructuación',
  'En fructuación',
  'Iniciando',
  'Sin fructuación'
];
var listRectitudFuste = [
  'Seleccione Opción',
  'Muy inclinado',
  'Inclinado',
  'Recto',
  'Torcido'
];
var listEspacioCrecimiento = [
  'Seleccione Opción',
  'Amplio',
  'Moderado',
  'Estrecho'
];
var listRaFusCorRamHoYE = ['Seleccione Opción', 'Bueno', 'Regular', 'Mala'];
var listCalidadCopa = [
  'Seleccione Opción',
  'Irregular',
  'Poco simétrica',
  'Simétrica'
];
var listRiesgosPotenciales = ['Seleccione Opción', 'Alto', 'Medio', 'Bajo'];

//////////////// titulos genrerales  ////////
String strTituloRegistro = "Formulario de Registro";
String strTituloEdicion = "Formulario de Edición";
String strTituloEliminar = "Formulario de Eliminación";
String strTituloVerDatos = "Formulario de Datos";

//////////////// Geo Ubicacion coordenadas loja ////////
const double geoLatitud = -3.9888306;
const double geoLongitud = -79.2102758;
const double geoZoom = 14.4746;

/** alarmas **/

Future<bool> willPopCallback(context) async {
  showDialog<String>(
    barrierDismissible: false,
    //barrierColor: Colors.green,
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: kTreeColor,
      title: const Text('Se perdera todos los cambios'),
      content: const Text(
        '¿Estás seguro de que quieres salir?',
        style: TextStyle(color: kSecondColor),
      ),
      actions: <Widget>[
        const Divider(
          // height: 1.0,
          color: kGroundColorColor,
        ),
        TextButton(
          onPressed: () => {
            Navigator.pop(context, 'Si'),
            Navigator.of(context).pop(),
          },
          child: const Text('Si'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'No'),
          child: const Text('No'),
        ),
      ],
    ),
  );
  return Future.value(false);
}



Future<bool> willPopCallbackSalirSistema(context) async {
  showDialog<String>(
    barrierDismissible: false,
    //barrierColor: Colors.green,
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: kTreeColor,
      title: const Text('Se perdera todos los cambios'),
      content: const Text(
        '¿Estás seguro de que quieres salir?',
        style: TextStyle(color: kSecondColor),
      ),
      actions: <Widget>[
        const Divider(
          // height: 1.0,
          color: kGroundColorColor,
        ),
        TextButton(
          onPressed: () => {
            Navigator.pop(context, 'Si'),
            exit(0),
          },
          child: const Text('Si'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'No'),
          child: const Text('No'),
        ),
      ],
    ),
  );
  return Future.value(false);
}
