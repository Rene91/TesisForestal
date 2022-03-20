import 'dart:convert';
import 'dart:io';
import 'dart:io' as Io;

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forestal_app/Controlador/ArbolesDB.dart';
import 'package:forestal_app/Modelo/Arboles.dart';
import 'package:forestal_app/Modelo/Usuario.dart';
import 'package:forestal_app/componentsGeneral/constants.dart';
import 'package:forestal_app/componentsGeneral/input_container.dart';
import 'package:forestal_app/componentsGeneral/rounded_button_cancelar.dart';
import 'package:forestal_app/componentsGeneral/rounded_num_decimal_input.dart';
import 'package:forestal_app/componentsGeneral/rounded_num_input.dart';
import 'package:forestal_app/componentsGeneral/rounded_text_descrip_input.dart';
import 'package:forestal_app/componentsGeneral/rounded_text_input.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class AddFormArbolesScreen extends StatefulWidget {
  const AddFormArbolesScreen({Key? key}) : super(key: key);

  @override
  _AddFormArbolesScreen createState() => _AddFormArbolesScreen();
}

class _AddFormArbolesScreen extends State<AddFormArbolesScreen> {
  var _FileImage;
  var _ImagePicker;
  late String _strMadurez = "Seleccione Opción";
  late String _strFloracion = "Seleccione Opción";
  late String _strFructuacion = "Seleccione Opción";
  late String _strFuste = "Seleccione Opción";
  late String _strCrecimiento = "Seleccione Opción";
  late String _ImagenBase64Aux = "";

  /*   --------------- Parametros para Editar Usuario --------------*/
  late TextEditingController getTextNomComun = TextEditingController();
  late TextEditingController getTextNomCientifico = TextEditingController();
  late TextEditingController getTextDescricion = TextEditingController();
  late TextEditingController getTextLatitud = TextEditingController();
  late TextEditingController getTextLogitud = TextEditingController();
  late TextEditingController getTextAltitud = TextEditingController();
  late TextEditingController getTextCap = TextEditingController();
  late TextEditingController getTextDap = TextEditingController();
  late TextEditingController getTextHt = TextEditingController();
  late TextEditingController getTextHc = TextEditingController();
  late TextEditingController getTextTamCopaPro = TextEditingController();
  late TextEditingController getTextPorcentajeHojas = TextEditingController();
  late TextEditingController getTextSector = TextEditingController();
  late TextEditingController getTextFamilia = TextEditingController();
  late TextEditingController getTextProyecto = TextEditingController();

  @override
  void initState() {
    super.initState();
    getTextProyecto.text =
        '17-DI-FARNR-2021: “Dinámica de crecimiento y servicios ecosistémicos del arbolado urbano de la ciudad de Loja”';
    _ImagePicker = ImagePicker();
    /*Obtenemos los datos del Usuario*/
  }

  @override
  void dispose() {
    getTextNomComun.dispose();
    getTextNomCientifico.dispose();
    getTextDescricion.dispose();
    getTextLatitud.dispose();
    getTextLogitud.dispose();
    getTextAltitud.dispose();
    getTextCap.dispose();
    getTextDap.dispose();
    getTextHt.dispose();
    getTextHc.dispose();
    getTextTamCopaPro.dispose();
    getTextPorcentajeHojas.dispose();
    getTextFamilia.dispose();
    getTextSector.dispose();
    getTextProyecto.dispose();
    super.dispose();
  }

  late DateTime _lastQuitTime;

  @override
  Widget build(BuildContext context) {
    Usuario? objUsuario;
    objUsuario = ModalRoute.of(context)!.settings.arguments as Usuario?;
    Size size =
        MediaQuery.of(context).size; //obtenemos todo el ancho de la pantalla

    return WillPopScope(
        onWillPop: () async => willPopCallback(context),
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: const Text('Registrar Árbol'),
            actions: <Widget>[
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.assignment),
                tooltip: 'Grid',
              ),
            ],
          ),
          body: Container(
            color: Colors.white,
            constraints: const BoxConstraints.expand(),
            child: Form(
              key: globalFormkey_Arbol,
              autovalidate: false,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Divider(
                      height: 10.0,
                      color: Theme.of(context).primaryColor,
                    ),
                    Text(
                      strTituloRegistro,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          //ponemos en negrita el texto
                          fontSize: 24 //aumentamos letra
                          ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: _FileImage != null
                          ? ClipOval(
                              child: Material(
                                color: kPrimaryColor,
                                child: InkWell(
                                  onTap: () async {
                                    _showPicker(context);
                                  },
                                  child: Image.file(
                                    _FileImage,
                                    //color: Colors.white,
                                    //size: 50,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            )
                          : ClipOval(
                              child: Material(
                                color: kPrimaryColor,
                                child: InkWell(
                                  onTap: () async {
                                    _showPicker(context);
                                  },
                                  child: const Icon(
                                    Icons.add_a_photo_outlined,
                                    color: Colors.white,
                                    size: 150,
                                  ),
                                ),
                              ),
                            ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    RoundTextDescripInput(
                      icon: FontAwesomeIcons.tasks,
                      hint: 'Nombre proyecto*',
                      obtenerDatos: getTextProyecto,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    RoundTextInput(
                      icon: FontAwesomeIcons.pagelines,
                      hint: 'Nombre común*',
                      obtenerDatos: getTextNomComun,
                      tipoEscritura: TextCapitalization.words,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    RoundTextInput(
                      icon: FontAwesomeIcons.cannabis,
                      hint: 'Nombre cientifico*',
                      obtenerDatos: getTextNomCientifico,
                      tipoEscritura: TextCapitalization.words,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    RoundTextInput(
                      icon: FontAwesomeIcons.teeth,
                      hint: 'Familia*',
                      obtenerDatos: getTextFamilia,
                      tipoEscritura: TextCapitalization.characters,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    RoundTextDescripInput(
                      icon: Icons.assignment_rounded,
                      hint: 'Comentarios*',
                      obtenerDatos: getTextDescricion,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InputContainer(
                      child: Column(children: <Widget>[
                        const Text('Información General'),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: DropdownSearch<String>(
                                    mode: Mode.MENU,
                                    showSelectedItems: true,
                                    items: listEstadoMadurez,
                                    label: "Estado de madurez*",
                                    hint: "country in menu mode",
                                    popupItemDisabled: (String s) =>
                                        s.startsWith('Sele'),
                                    onChanged: (a) {
                                      setState(() {
                                        _strMadurez = a.toString();
                                      });
                                    },
                                    selectedItem: "Seleccione Opción"),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: DropdownSearch<String>(
                                    mode: Mode.MENU,
                                    showSelectedItems: true,
                                    items: listFloracion,
                                    label: "Floración*",
                                    hint: "country in menu mode",
                                    popupItemDisabled: (String s) =>
                                        s.startsWith('Sele'),
                                    onChanged: (a) {
                                      setState(() {
                                        _strFloracion = a.toString();
                                      });
                                    },
                                    selectedItem: "Seleccione Opción"),
                              ),
                            ]),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: DropdownSearch<String>(
                                    mode: Mode.MENU,
                                    showSelectedItems: true,
                                    items: listEspacioCrecimiento,
                                    label: "Espacio Crecimiento*",
                                    hint: "country in menu mode",
                                    popupItemDisabled: (String s) =>
                                        s.startsWith('Sele'),
                                    onChanged: (a) {
                                      setState(() {
                                        _strCrecimiento = a.toString();
                                      });
                                    },
                                    selectedItem: "Seleccione Opción"),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: DropdownSearch<String>(
                                    mode: Mode.MENU,
                                    showSelectedItems: true,
                                    items: listRectitudFuste,
                                    label: "Rectitud del fuste*",
                                    hint: "country in menu mode",
                                    popupItemDisabled: (String s) =>
                                        s.startsWith('Sele'),
                                    onChanged: (a) {
                                      setState(() {
                                        _strFuste = a.toString();
                                      });
                                    },
                                    selectedItem: "Seleccione Opción"),
                              ),
                            ]),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: DropdownSearch<String>(
                                    mode: Mode.MENU,
                                    showSelectedItems: true,
                                    items: listFructuacion,
                                    label: "Estado de Fructificación*",
                                    hint: "country in menu mode",
                                    popupItemDisabled: (String s) =>
                                        s.startsWith('Sele'),
                                    onChanged: (a) {
                                      setState(() {
                                        _strFructuacion = a.toString();
                                      });
                                    },
                                    selectedItem: "Seleccione Opción"),
                              ),
                            ]),
                        RoundNumDecimalInput(
                          icon: FontAwesomeIcons.sourcetree,
                          hint: 'CAP* (cm)',
                          obtenerDatos: getTextCap,
                          suffixText: "cm",
                          helperText: "Circunferencia de fuste",
                          caracteres: 1,
                        ),
                        RoundNumDecimalInput(
                          icon: FontAwesomeIcons.drumSteelpan,
                          hint: 'DAP* (cm)',
                          obtenerDatos: getTextDap,
                          suffixText: "cm",
                          helperText: "Diámetro",
                          caracteres: 1,
                        ),
                        RoundNumDecimalInput(
                          icon: FontAwesomeIcons.campground,
                          hint: 'HT* (m)',
                          obtenerDatos: getTextHt,
                          suffixText: "m",
                          helperText: "Altura Total",
                          caracteres: 1,
                        ),
                        RoundNumDecimalInput(
                          icon: FontAwesomeIcons.trello,
                          hint: 'HC* (m)',
                          obtenerDatos: getTextHc,
                          suffixText: "m",
                          helperText: "Altura Comercial",
                          caracteres: 1,
                        ),
                        RoundNumDecimalInput(
                          icon: FontAwesomeIcons.teethOpen,
                          hint: 'Promedio copa* (m)',
                          obtenerDatos: getTextTamCopaPro,
                          suffixText: "m",
                          helperText: "Tamaño Copa Promedio",
                          caracteres: 1,
                        ),
                        RoundNumDecimalInput(
                          icon: FontAwesomeIcons.percentage,
                          hint: 'Porcentaje hojas*',
                          obtenerDatos: getTextPorcentajeHojas,
                          suffixText: "%",
                          helperText: "",
                          caracteres: 1,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ]),
                    ),
                    InputContainer(
                      child: Column(children: <Widget>[
                        const Text('Geo Ubicación'),
                        const SizedBox(
                          height: 10,
                        ),
                        RoundTextInput(
                          icon: FontAwesomeIcons.streetView,
                          hint: 'Sector*',
                          obtenerDatos: getTextSector,
                          tipoEscritura: TextCapitalization.words,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        RoundNumInput(
                          icon: FontAwesomeIcons.locationArrow,
                          hint: 'Altitud*',
                          obtenerDatos: getTextAltitud,
                        ),
                        RoundNumInput(
                          icon: FontAwesomeIcons.locationArrow,
                          hint: 'Logitud*',
                          obtenerDatos: getTextLogitud,
                        ),
                        RoundNumInput(
                          icon: FontAwesomeIcons.locationArrow,
                          hint: 'Latitud*',
                          obtenerDatos: getTextLatitud,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            const Icon(FontAwesomeIcons.mapMarkerAlt),
                            FlatButton(
                              onPressed: () {
                                _getUbicacionActual();
                                //Navigator.pushNamed(context, "YourRoute");
                              },
                              //icon: Icons.add_location,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  color: Colors.red,
                                  child: const Text(
                                    "Obtener ubicación actual",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: MaterialButton(
                        onPressed: () {
                          try {
                            print("señor");
                            if (globalFormkey_Arbol.currentState!.validate()) {
                              if (_ImagenBase64Aux.length > 10) {
                                if (getTextNomComun.text.length > 3 &&
                                    getTextNomCientifico.text.length > 3 &&
                                    getTextLogitud.text.length > 3 &&
                                    getTextLatitud.text.length > 3 &&
                                    getTextAltitud.text.length > 3 &&
                                    getTextCap.text.isNotEmpty &&
                                    getTextDap.text.isNotEmpty &&
                                    getTextHt.text.isNotEmpty &&
                                    getTextHc.text.isNotEmpty &&
                                    getTextTamCopaPro.text.isNotEmpty &&
                                    getTextPorcentajeHojas.text.isNotEmpty &&
                                    getTextDescricion.text.length > 2 &&
                                    getTextFamilia.text.length > 3 &&
                                    getTextSector.text.length > 3 &&
                                    getTextProyecto.text.length > 3) {
                                  if (_strMadurez != "Seleccione Opción" &&
                                      _strFloracion != "Seleccione Opción" &&
                                      _strCrecimiento != "Seleccione Opción" &&
                                      _strFuste != "Seleccione Opción" &&
                                      _strFructuacion != "Seleccione Opción") {
                                    setState(() async {
                                      _cargarDatos(context);
                                      Arboles obj = Arboles(
                                          0,
                                          getTextNomComun.text,
                                          getTextNomCientifico.text,
                                          getTextLogitud.text,
                                          getTextLatitud.text,
                                          getTextAltitud.text,
                                          double.parse(getTextCap.text),
                                          double.parse(getTextDap.text),
                                          double.parse(getTextHt.text),
                                          double.parse(getTextHc.text),
                                          double.parse(getTextTamCopaPro.text),
                                          int.parse(
                                              getTextPorcentajeHojas.text),
                                          _strMadurez,
                                          _strFloracion,
                                          _strFructuacion,
                                          _strFuste,
                                          _strCrecimiento,
                                          getTextDescricion.text,
                                          "A",
                                          _ImagenBase64Aux,
                                          getTextFamilia.text,
                                          getTextSector.text,
                                          getTextProyecto.text);
                                      ArbolesDB objBD = ArbolesDB();
                                      String accion =
                                          await objBD.Agregar_A(obj);

                                      Navigator.pop(context);
                                      if (accion == "ACCIÓN CORRECTA") {
                                        _Mensaje(
                                            "Dato Registrado");
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pushNamed(
                                            "/inicio_screen",
                                            arguments: objUsuario);
                                      } else {
                                        _Mensaje(
                                            "Error al Agregar: Revise su conexion de Internet");
                                      }
                                    });
                                    //print("guardar");
                                  } else {
                                    _Mensaje(
                                        "Error: Verificar Campos de Informacamción General");
                                  }
                                } else {
                                  _Mensaje(
                                      "Error: Verificar campos que esten llenos");
                                }
                              } else {
                                _Mensaje("Error: Debe ingresar imagen");
                              }
                            }
                          } on Exception catch (exception) {
                            _Mensaje(
                                "Error on server-> " + exception.toString());
                            //throw Exception("Error on server");
                          } catch (error) {
                            //_Mensaje("Error-> " + error.toString());
                          }
                        },
                        child: Container(
                          //width: 200.0,
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: kPrimaryColor,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          alignment: Alignment.center,
                          //child: Row(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          child: const Text(
                            "Guardar",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const RoundeButtonCancelar(
                      title: "Cancelar",
                      ubicacion: "",
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  void _Mensaje(String testo) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(testo)));
  }

  void _getUbicacionActual() async {
    //print('getLocation');
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    //print(position);

    getTextLatitud.text = (position.latitude.toString());
    getTextLogitud.text = (position.longitude.toString());
    getTextAltitud.text = (position.altitude.toString());
  }

  /*Metodos camara*/
  _imgFromCamera() async {
    XFile? image = await _ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);
    setState(() {
      _FileImage = File(image!.path);
    });
    final bytes = Io.File(image!.path).readAsBytesSync();
    _ImagenBase64Aux = base64Encode(bytes);
  }

  _imgFromGallery() async {
    XFile? image = await _ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _FileImage = File(image!.path);
    });
    final bytes = Io.File(image!.path).readAsBytesSync();
    _ImagenBase64Aux = base64Encode(bytes);
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Libreria de Fotos'),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Cámara'),
                  onTap: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }
}

void _cargarDatos(context) {
  showDialog<String>(
    barrierDismissible: false,
    //barrierColor: Colors.green,
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: kTreeColor,
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7),
              child: const Text("Cargando...")),
        ],
      ),
      actions: <Widget>[],
    ),
  );
}
