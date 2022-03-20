import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forestal_app/Controlador/ArbolesDB.dart';
import 'package:forestal_app/Controlador/DispositivoDB.dart';
import 'package:forestal_app/Modelo/Arboles.dart';
import 'package:forestal_app/Modelo/Usuario.dart';
import 'package:forestal_app/componentsGeneral/constants.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:permission_handler/permission_handler.dart';

class MenuLateral extends StatefulWidget {
  const MenuLateral({
    Key? key,
    required this.objUsuario,
  }) : super(key: key);

  final Usuario? objUsuario;

  @override
  _menu_lateral createState() => _menu_lateral();
}

class _menu_lateral extends State<MenuLateral> {
  String? usuario = 'Usuario'; //user
  String? usuarioEmail = 'Email'; //userEmail
  String? fotoPerfil = ''; //userEmail
  int? idUsuario;
  late String likFoto = "";
  late Widget image;

  void _signOut(BuildContext context, int id) async {
    try {
      DispositivoDB dispositivo = DispositivoDB();
      dispositivo.CerrarSecion_D(id, context);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      usuario = widget.objUsuario!.getNombre_u;
      usuarioEmail = widget.objUsuario!.getEmail_u;
      idUsuario = widget.objUsuario!.getId_u;
      //if (widget.objUsuario!.getFoto_u != "") {
      likFoto = widget.objUsuario!.getFoto_u.toString();
      //}
    });
  }

  @override
  Widget build(BuildContext context) {
    /*Uint8List bytes = Base64Codec().decode(
        _base64); */ /*decodificamos imagen del servidor en datos en datos reconocibles por CircleAvatar*/
    return Drawer(
      elevation: 30.0,
      child: Container(
        color: kPrimaryColor,
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                maxRadius: 10.0,
                child: likFoto != ""
                    ? ClipOval(
                        //color: kPrimaryColor,
                        child: Image.network(
                          likFoto,
                          width: 100,
                          height: 100,
                          //color: Colors.white,
                          //size: 50,
                          fit: BoxFit.cover,
                        ),
                      )
                    : const ClipOval(
                        //color: kPrimaryColor,
                        child: Icon(
                          Icons.add_a_photo_outlined,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
              ),
              accountName: Text(
                '$usuario',
                style: const TextStyle(
                  color: kGroundColorColor,
                ),
              ),
              accountEmail: Text('$usuarioEmail',
                  style: const TextStyle(color: kGroundColorColor)),
              decoration: const BoxDecoration(
                  color: kSecondColor,
                  image: DecorationImage(
                    alignment: Alignment(1.0, 0),
                    image: AssetImage(
                      'assets/images/home_page.jpg',
                    ),
                    /*cargamos imagen de fondo*/
                    fit: BoxFit.scaleDown, //BoxFit.fitHeight
                  )),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pop();
                /*page.lista().then((value) {
                  print(value);
                  setState(() {
                    contentPage = value;
                  });
                });*/
              },
              leading: const Icon(
                Icons.home,
                color: kSecondColor,
              ),
              title: const Text(
                'Inicio',
                style: TextStyle(color: kGroundColorColor),
              ),
            ),
            const Divider(
              height: 2.0,
              color: kGroundColorColor,
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pop();
                setState(() {
                  Navigator.of(context).pushNamed("/edit_form_u_screen",
                      arguments: widget.objUsuario);
                });
              },
              leading: const Icon(
                FontAwesomeIcons.user,
                color: kSecondColor,
              ),
              title: const Text(
                'Perfil',
                style: TextStyle(color: kSecondColor),
              ),
            ),
            ListTile(
              onTap: () {
                setState(() {
                  ventanaScaner();
                });
              },
              leading: const Icon(
                FontAwesomeIcons.qrcode,
                color: kSecondColor,
              ),
              title: const Text(
                'Leer código QR',
                style: TextStyle(color: kSecondColor),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pop();
                setState(() {
                  Navigator.of(context).pushNamed("/list_form_g_u_a_screen",
                      arguments: widget.objUsuario);
                });
              },
              leading: const Icon(
                FontAwesomeIcons.mapMarkedAlt,
                color: kSecondColor,
              ),
              title: const Text(
                'Mapa Arboles',
                style: TextStyle(color: kSecondColor),
              ),
            ),
            widget.objUsuario!.getNivel_u == "admin"
                ? ExpansionTile(
                    leading: const Icon(
                      Icons.settings,
                      color: kSecondColor,
                    ),
                    title: const Text(
                      'Configuración',
                      style: TextStyle(color: kSecondColor),
                    ),
                    children: <Widget>[
                      ListTile(
                        onTap: () {
                          Navigator.of(context).pop();
                          setState(() {
                            Navigator.of(context).pushNamed(
                                "/list_form_u_screen",
                                arguments: widget.objUsuario);
                          });
                        },
                        title: const Text(
                          '               Administrar Usuarios',
                          style: TextStyle(color: kSecondColor),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.of(context).pop();
                          setState(() {
                            Navigator.of(context).pushNamed(
                                "/list_form_a_r_screen",
                                arguments: widget.objUsuario);
                          });
                        },
                        title: const Text(
                          '               Acciones recomendadas',
                          style: TextStyle(color: kSecondColor),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.of(context).pop();
                          setState(() {
                            Navigator.of(context).pushNamed(
                                "/list_form_e_f_screen",
                                arguments: widget.objUsuario);
                          });
                        },
                        title: const Text(
                          '               Estado fitosanitario',
                          style: TextStyle(color: kSecondColor),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.of(context).pop();
                          setState(() {
                            Navigator.of(context).pushNamed(
                                "/list_form_p_e_screen",
                                arguments: widget.objUsuario);
                          });
                        },
                        title: const Text(
                          '               Presencia de enfermedades',
                          style: TextStyle(color: kSecondColor),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.of(context).pop();
                          setState(() {
                            Navigator.of(context).pushNamed(
                                "/list_form_p_p_screen",
                                arguments: widget.objUsuario);
                          });
                        },
                        title: const Text(
                          '               Presencia de plagas',
                          style: TextStyle(color: kSecondColor),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.of(context).pop();
                          setState(() {
                            Navigator.of(context).pushNamed(
                                "/list_form_p_f_screen",
                                arguments: widget.objUsuario);
                          });
                        },
                        title: const Text(
                          '               Problemas físicos',
                          style: TextStyle(color: kSecondColor),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.of(context).pop();
                          setState(() {
                            Navigator.of(context).pushNamed(
                                "/list_form_r_p_screen",
                                arguments: widget.objUsuario);
                          });
                        },
                        title: const Text(
                          '               Riesgos potenciales',
                          style: TextStyle(color: kSecondColor),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.of(context).pop();
                          setState(() {
                            Navigator.of(context).pushNamed(
                                "/list_form_u_e_screen",
                                arguments: widget.objUsuario);
                          });
                        },
                        title: const Text(
                          '               Ubicación de enfermedades',
                          style: TextStyle(color: kSecondColor),
                        ),
                      ),
                      /*ListTile(
                        onTap: () {
                          Navigator.of(context).pop();
                          setState(() {
                            DispositivoDB objDB = DispositivoDB();
                            objDB.RespaldarBD();
                          });
                        },
                        title: const Text(
                          '               Respaldar Base de Datos ',
                          style: TextStyle(color: Colors.deepOrange),
                        ),
                      ),*/
                      const Divider(
                        height: 2.0,
                        color: kGroundColorColor,
                      ),
                    ],
                  )
                : Container(),
            ListTile(
              title: const Text(
                'Cerrar Sesion',
                style: TextStyle(color: kSecondColor),
              ),
              leading: const Icon(
                Icons.exit_to_app,
                color: kSecondColor,
              ),
              onTap: () {
                //Navigator.of(context).pop();
                //_signOut(context);
                _signOut(context, idUsuario!);
              },
            ),
            ListTile(
              title: const Text(
                'Acerca de nosotros',
                style: TextStyle(color: kSecondColor),
              ),
              onTap: () {
                Navigator.of(context).pop();
                setState(() {
                  Navigator.of(context).pushNamed("/acerca_de_screen");
                });
              },
            ),
            ListTile(
              title: const Text(
                'App version 1.0.0',
                style: TextStyle(color: kSecondColor),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  /*Obtenemos los datos del servidor*/
  void ventanaScaner() async {
    try {
      await Permission.camera.request();
      String? barcode = await scanner.scan();
      if (barcode == null) {
        print('QR no existe');
        Navigator.of(context).pop();
      } else {
        ArbolesDB mm = ArbolesDB();
        List? response = await mm.Ver_Id_A(barcode.toString());
        Arboles? _objArbol = Arboles(
            int.parse(response![0]['id_a']),
            response[0]['nombre_comun_a'],
            response[0]['nombre_cientifico_a'],
            response[0]['longitud_a'],
            response[0]['latitud_a'],
            response[0]['altitud_a'],
            double.parse(response[0]['cap_a']),
            double.parse(response[0]['dap_a']),
            double.parse(response[0]['ht_a']),
            double.parse(response[0]['hc_a']),
            double.parse(response[0]['tam_copa_prom_a']),
            int.parse(response[0]['porcentaje_hojas_a']),
            response[0]['madurez_a'],
            response[0]['floracion_a'],
            response[0]['fructificacion_a'],
            response[0]['rectitud_fuste_a'],
            response[0]['crecimiento_a'],
            response[0]['comentarios_a'],
            response[0]['estado_a'],
            response[0]['foto_a'],
            response[0]['familia_a'],
            response[0]['sector_a'],
            response[0]['proyecto_a']);

        Navigator.of(context).pop();
        Navigator.of(context)
            .pushNamed("/verid_form_a_screen", arguments: _objArbol);
      }
    } on PlatformException catch (e) {
      
    }
  }
}

void showHome(BuildContext context) {
  Navigator.pop(context);
}
