import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forestal_app/Controlador/AccionesRecomendadasDB.dart';
import 'package:forestal_app/Controlador/ArbolesDB.dart';
import 'package:forestal_app/Controlador/EstadoFitosanitarioDB.dart';
import 'package:forestal_app/Controlador/InconvenienteArbolDB.dart';
import 'package:forestal_app/Controlador/PresenciaEnfermedadesDB.dart';
import 'package:forestal_app/Controlador/PresenciaPlagasDB.dart';
import 'package:forestal_app/Controlador/ProblemasFisicosDB.dart';
import 'package:forestal_app/Controlador/RiesgosPotencialesDB.dart';
import 'package:forestal_app/Controlador/UbicacionfermedadesDB.dart';
import 'package:forestal_app/Controlador/UsuarioDB.dart';
import 'package:forestal_app/Modelo/AccionesRecomendadas.dart';
import 'package:forestal_app/Modelo/Arboles.dart';
import 'package:forestal_app/Modelo/EstadoFitosanitario.dart';
import 'package:forestal_app/Modelo/InconvenienteArbol.dart';
import 'package:forestal_app/Modelo/PresenciaEnfermedades.dart';
import 'package:forestal_app/Modelo/PresenciaPlagas.dart';
import 'package:forestal_app/Modelo/ProblemasFisicos.dart';
import 'package:forestal_app/Modelo/RiesgosPotenciales.dart';
import 'package:forestal_app/Modelo/UbicacionEnfermedades.dart';
import 'package:forestal_app/componentsGeneral/constants.dart';
import 'package:forestal_app/componentsGeneral/input_container.dart';
import 'package:forestal_app/componentsGeneral/rounded_button_cancelar.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class VerIdFromInconvenientesArbolesScreen extends StatefulWidget {
  const VerIdFromInconvenientesArbolesScreen({Key? key}) : super(key: key);

  @override
  _VerIdFromInconvenientesArbolesScreenState createState() =>
      _VerIdFromInconvenientesArbolesScreenState();
}

class _VerIdFromInconvenientesArbolesScreenState
    extends State<VerIdFromInconvenientesArbolesScreen> {
  bool boolInicio = false;
  bool boolCargarDatos = true;
  String strColector = "";

  late TextEditingController getTextDatosColector = TextEditingController();

  /** Variables para presentar datos de inconvenienets de arbol **/
  var _itemsAR_BD;
  var _itemsPE_BD;
  var _itemsPP_BD;
  var _itemsPF_BD;
  var _itemsRP_BD;
  var _itemsUE_BD;
  var _itemsEF_BD;

  List<AccionesRecomendadas> _selectedAR_BD = [];
  List<PresenciaEnfermedades> _selectedPE_BD = [];
  List<PresenciaPlagas> _selectedPP_BD = [];
  List<ProblemasFisicos> _selectedPF_BD = [];
  List<RiesgosPotenciales> _selectedRP_BD = [];
  List<UbicacionEnfermedades> _selectedUE_BD = [];
  List<EstadoFitosanitario> _selectedEF_BD = [];

  /** Obtenemos los datos para cargar los combos ***/
  void getDataInconvenienteArbobl(String idArbol) async {
    String nomColector = "";
    String emailColector = "";
    String fechaColector = "";
    try {
      List<PresenciaEnfermedades> listPE = [];
      List<UbicacionEnfermedades> listUE = [];
      List<PresenciaPlagas> listPP = [];
      List<ProblemasFisicos> listPF = [];
      List<RiesgosPotenciales> listRP = [];
      List<AccionesRecomendadas> listAR = [];
      List<EstadoFitosanitario> listEF = [];

      InconvenienteArbolDB mm = InconvenienteArbolDB();
      List? response = await mm.Ver_Id_IA(idArbol);

      for (var element in response!) {
        if (element['id_presenacia_enfermedades'].toString() != "null") {
          PresenciaEnfermedadesDB mm = PresenciaEnfermedadesDB();
          List? responsePE = await mm.Ver_Id_PE(
              element['id_presenacia_enfermedades'].toString());
          listPE.add(PresenciaEnfermedades(
              int.parse(responsePE![0]['id_pe'].toString()),
              responsePE[0]['descripcion_pe'].toString(),
              responsePE[0]['estado_pe']));
        }

        if (element['id_ubicacion_enfermedades'].toString() != "null") {
          UbicacionEnfermedadesDB mm = UbicacionEnfermedadesDB();
          List? responseUE = await mm.Ver_Id_UE(
              element['id_ubicacion_enfermedades'].toString());
          listUE.add(UbicacionEnfermedades(
              int.parse(responseUE![0]['id_ue'].toString()),
              responseUE[0]['descripcion_ue'].toString(),
              responseUE[0]['estado_ue']));
        }

        if (element['id_presencia_plagas'].toString() != "null") {
          PresenciaPlagasDB mm = PresenciaPlagasDB();
          List? responsePP =
              await mm.Ver_Id_PP(element['id_presencia_plagas'].toString());
          listPP.add(PresenciaPlagas(
              int.parse(responsePP![0]['id_pp'].toString()),
              responsePP[0]['descripcion_pp'].toString(),
              responsePP[0]['estado_pp']));
        }

        if (element['id_problema_fisico'].toString() != "null") {
          ProblemasFisicosDB mm = ProblemasFisicosDB();
          List? responsePF =
              await mm.Ver_Id_PF(element['id_problema_fisico'].toString());
          listPF.add(ProblemasFisicos(
              int.parse(responsePF![0]['id_pf'].toString()),
              responsePF[0]['descripcion_pf'].toString(),
              responsePF[0]['estado_pf']));
        }

        if (element['id_riesgos_potenciales'].toString() != "null") {
          RiesgosPotencialesDB mm = RiesgosPotencialesDB();
          List? responseRP =
              await mm.Ver_Id_RP(element['id_riesgos_potenciales'].toString());
          listRP.add(RiesgosPotenciales(
              int.parse(responseRP![0]['id_rp'].toString()),
              responseRP[0]['descripcion_rp'].toString(),
              responseRP[0]['estado_rp']));
        }

        if (element['id_acciones_recomendadas'].toString() != "null") {
          AccionesRecomendadasDB mm = AccionesRecomendadasDB();
          List? responsePE = await mm.Ver_Id_AR(
              element['id_acciones_recomendadas'].toString());
          listAR.add(AccionesRecomendadas(
              int.parse(responsePE![0]['id_ar'].toString()),
              responsePE[0]['descripcion_ar'].toString(),
              responsePE[0]['estado_ar']));
        }

        if (element['id_estado_fitosanitario'].toString() != "null") {
          EstadoFitosanitarioDB mm = EstadoFitosanitarioDB();
          List? responsePE =
              await mm.Ver_Id_EF(element['id_estado_fitosanitario'].toString());
          listEF.add(EstadoFitosanitario(
              int.parse(responsePE![0]['id_ef'].toString()),
              responsePE[0]['descripcion_ef'].toString(),
              responsePE[0]['estado_ef']));
        }

        if (element['id_usuario'].toString() != "null") {
          UsuarioDB mm = UsuarioDB();
          List? responseU = await mm.Ver_Id_U(element['id_usuario'].toString());
          nomColector = responseU![0]['nombre_u'].toString() +
              " " +
              responseU[0]['apellido_u'].toString();
          emailColector = responseU[0]['email_u'].toString();
        }
        fechaColector = element['fecha_ia'].toString();
        strColector = "Colector:\n   " +
            nomColector +
            "\nEmail:\n   " +
            emailColector +
            "\nFecha de recolección:\n   " +
            fechaColector;
      }

      setState(() {
        _selectedPE_BD = listPE;
        _selectedUE_BD = listUE;
        _selectedPP_BD = listPP;
        _selectedPF_BD = listPF;
        _selectedRP_BD = listRP;
        _selectedAR_BD = listAR;
        _selectedEF_BD = listEF;
      });

      boolCargarDatos = false;
    } catch (ex) {}
  }

  @override
  void initState() {
    super.initState();
    boolInicio = true;
  }

  @override
  void dispose() {
    //_lista1();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Arboles? objArbol = ModalRoute.of(context)!.settings.arguments
        as Arboles?; //cargamos datos del arbol
    setState(() {
      if (boolInicio) {
        getDataInconvenienteArbobl(objArbol!.getId_a.toString());
        boolInicio = false;
      }
    });

    getTextDatosColector.text = strColector;
    /** Cargamos items de BD **/
    _itemsPE_BD = _selectedPE_BD
        .map((obj) => MultiSelectItem<PresenciaEnfermedades>(
            obj, obj.getDescripcion_pe.toString()))
        .toList();

    _itemsUE_BD = _selectedUE_BD
        .map((obj) => MultiSelectItem<UbicacionEnfermedades>(
            obj, obj.getDescripcion_ue.toString()))
        .toList();

    _itemsPP_BD = _selectedPP_BD
        .map((obj) => MultiSelectItem<PresenciaPlagas>(
            obj, obj.getDescripcion_pp.toString()))
        .toList();

    _itemsPF_BD = _selectedPF_BD
        .map((obj) => MultiSelectItem<ProblemasFisicos>(
            obj, obj.getDescripcion_pf.toString()))
        .toList();

    _itemsRP_BD = _selectedRP_BD
        .map((obj) => MultiSelectItem<RiesgosPotenciales>(
            obj, obj.getDescripcion_rp.toString()))
        .toList();

    _itemsAR_BD = _selectedAR_BD
        .map((obj) => MultiSelectItem<AccionesRecomendadas>(
            obj, obj.getDescripcion_ar.toString()))
        .toList();

    _itemsEF_BD = _selectedEF_BD
        .map((obj) => MultiSelectItem<EstadoFitosanitario>(
            obj, obj.getDescripcion_ef.toString()))
        .toList();

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text("Manejo forestal"),
        ),
        body: !boolCargarDatos
            ? SingleChildScrollView(
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Información Colector",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            //ponemos en negrita el texto
                            fontSize: 24 //aumentamos letra
                            ),
                      ),
                      InputContainer(
                        child: TextFormField(
                          maxLines: 6,
                          enabled: false,
                          controller: getTextDatosColector,
                          cursorColor: kPrimaryColor,
                          /*decoration: const InputDecoration(
                                  labelText: 'Información Colector',
                                  //colocamos icono a caja de texto
                                  /*icon: Icon(
                                    FontAwesomeIcons.barcode,
                                    color: kPrimaryColor,
                                  ),*/
                                  //hintText: widget.hint, //ponemos nombre a la caja de texto
                                  border: InputBorder
                                      .none, //colocamos borde a la caja de texto

                                  enabled: true,
                                ),*/
                        ),
                      ),
                      Divider(
                        height: 5.0,
                        color: Theme.of(context).primaryColor,
                      ),
                      Container(
                        decoration: const BoxDecoration(),
                        child: Column(
                          children: <Widget>[
                            const SizedBox(height: 10),
                            Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.blueGrey.withOpacity(0.1),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(40)),
                                border: Border.all(
                                  color: Colors.blueGrey,
                                  width: 2,
                                ),
                              ),
                              child: Row(
                                children: <Widget>[
                                  const SizedBox(width: 10),
                                  const Icon(
                                    FontAwesomeIcons.virus,
                                    color: Colors.blueGrey,
                                  ),
                                  const SizedBox(width: 30),
                                  Text(
                                    "Ubicación Enfermedades",
                                    style: TextStyle(
                                      color: Colors.blueGrey[800],
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            _selectedUE_BD.isEmpty
                                ? const Center()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      const SizedBox(height: 5),
                                      MultiSelectChipDisplay(
                                        items: _itemsUE_BD,
                                        onTap: (value) {
                                          setState(() {
                                            //_selectedUE_BD.remove(value);
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                            const SizedBox(height: 40),
                            Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.orange.withOpacity(0.1),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(40)),
                                border: Border.all(
                                  color: Colors.orange,
                                  width: 2,
                                ),
                              ),
                              child: Row(
                                children: <Widget>[
                                  const SizedBox(width: 10),
                                  const Icon(
                                    FontAwesomeIcons.pagelines,
                                    color: Colors.orange,
                                  ),
                                  const SizedBox(width: 30),
                                  Text(
                                    "Estado Fitosanitario",
                                    style: TextStyle(
                                      color: Colors.orange[800],
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            _selectedEF_BD.isEmpty
                                ? const Center()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      const SizedBox(height: 5),
                                      MultiSelectChipDisplay(
                                        items: _itemsEF_BD,
                                        onTap: (value) {
                                          setState(() {
                                            //_selectedEF_BD.remove(value);
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                            const SizedBox(height: 40),
                            Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.1),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(40)),
                                border: Border.all(
                                  color: Colors.green,
                                  width: 2,
                                ),
                              ),
                              child: Row(
                                children: <Widget>[
                                  const SizedBox(width: 10),
                                  const Icon(
                                    FontAwesomeIcons.disease,
                                    color: Colors.green,
                                  ),
                                  const SizedBox(width: 30),
                                  Text(
                                    "Presencia Enfermedades",
                                    style: TextStyle(
                                      color: Colors.green[800],
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            _selectedPE_BD.isEmpty
                                ? const Center()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      const SizedBox(height: 5),
                                      MultiSelectChipDisplay(
                                        items: _itemsPE_BD,
                                        onTap: (value) {
                                          setState(() {
                                            //_selectedPE_BD.remove(value);
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                            const SizedBox(height: 40),
                            Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.indigo.withOpacity(0.1),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(40)),
                                border: Border.all(
                                  color: Colors.indigo,
                                  width: 2,
                                ),
                              ),
                              child: Row(
                                children: <Widget>[
                                  const SizedBox(width: 10),
                                  const Icon(
                                    FontAwesomeIcons.bug,
                                    color: Colors.indigo,
                                  ),
                                  const SizedBox(width: 30),
                                  Text(
                                    "Presencia Plagas",
                                    style: TextStyle(
                                      color: Colors.indigo[800],
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            _selectedPP_BD.isEmpty
                                ? const Center()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      const SizedBox(height: 5),
                                      MultiSelectChipDisplay(
                                        items: _itemsPP_BD,
                                        onTap: (value) {
                                          setState(() {
                                            //_selectedPP_BD.remove(value);
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                            const SizedBox(height: 40),
                            Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.purple.withOpacity(0.1),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(40)),
                                border: Border.all(
                                  color: Colors.purple,
                                  width: 2,
                                ),
                              ),
                              child: Row(
                                children: <Widget>[
                                  const SizedBox(width: 10),
                                  const Icon(
                                    FontAwesomeIcons.teeth,
                                    color: Colors.purple,
                                  ),
                                  const SizedBox(width: 30),
                                  Text(
                                    "Problemas Físicos",
                                    style: TextStyle(
                                      color: Colors.purple[800],
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            _selectedPF_BD.isEmpty
                                ? const Center()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      const SizedBox(height: 5),
                                      MultiSelectChipDisplay(
                                        items: _itemsPF_BD,
                                        onTap: (value) {
                                          setState(() {
                                            //_selectedPF_BD.remove(value);
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                            const SizedBox(height: 40),
                            Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.teal.withOpacity(0.1),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(40)),
                                border: Border.all(
                                  color: Colors.teal,
                                  width: 2,
                                ),
                              ),
                              child: Row(
                                children: <Widget>[
                                  const SizedBox(width: 10),
                                  const Icon(
                                    FontAwesomeIcons.asterisk,
                                    color: Colors.teal,
                                  ),
                                  const SizedBox(width: 30),
                                  Text(
                                    "Riesgos Potenciales",
                                    style: TextStyle(
                                      color: Colors.teal[800],
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            _selectedRP_BD.isEmpty
                                ? const Center()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      const SizedBox(height: 5),
                                      MultiSelectChipDisplay(
                                        items: _itemsRP_BD,
                                        onTap: (value) {
                                          setState(() {
                                            //_selectedRP_BD.remove(value);
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                            const SizedBox(height: 40),
                            Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.1),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(40)),
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 2,
                                ),
                              ),
                              child: Row(
                                children: <Widget>[
                                  const SizedBox(width: 10),
                                  const Icon(
                                    FontAwesomeIcons.pagelines,
                                    color: Colors.blue,
                                  ),
                                  const SizedBox(width: 30),
                                  Text(
                                    "Acciones Recomendadas",
                                    style: TextStyle(
                                      color: Colors.blue[800],
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            _selectedAR_BD.isEmpty
                                ? const Center()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      const SizedBox(height: 5),
                                      MultiSelectChipDisplay(
                                        items: _itemsAR_BD,
                                        onTap: (value) {
                                          setState(() {
                                            //_selectedAR_BD.remove(value);
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                            const SizedBox(
                              height: 20,
                            ),
                            const RoundeButtonCancelar(
                              title: "Cancelar",
                              ubicacion: "",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}
