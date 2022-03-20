import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forestal_app/Controlador/AccionesRecomendadasDB.dart';
import 'package:forestal_app/Controlador/EstadoFitosanitarioDB.dart';
import 'package:forestal_app/Controlador/InconvenienteArbolDB.dart';
import 'package:forestal_app/Controlador/PresenciaEnfermedadesDB.dart';
import 'package:forestal_app/Controlador/PresenciaPlagasDB.dart';
import 'package:forestal_app/Controlador/ProblemasFisicosDB.dart';
import 'package:forestal_app/Controlador/RiesgosPotencialesDB.dart';
import 'package:forestal_app/Controlador/UbicacionfermedadesDB.dart';
import 'package:forestal_app/Modelo/AccionesRecomendadas.dart';
import 'package:forestal_app/Modelo/Arboles.dart';
import 'package:forestal_app/Modelo/EstadoFitosanitario.dart';
import 'package:forestal_app/Modelo/InconvenienteArbol.dart';
import 'package:forestal_app/Modelo/PresenciaEnfermedades.dart';
import 'package:forestal_app/Modelo/PresenciaPlagas.dart';
import 'package:forestal_app/Modelo/ProblemasFisicos.dart';
import 'package:forestal_app/Modelo/RiesgosPotenciales.dart';
import 'package:forestal_app/Modelo/UbicacionEnfermedades.dart';
import 'package:forestal_app/Modelo/Usuario.dart';
import 'package:forestal_app/componentsGeneral/constants.dart';
import 'package:forestal_app/componentsGeneral/rounded_button_cancelar.dart';
import 'package:forestal_app/componentsGeneral/rounded_text_input.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class AddFromInconvenientesArbolesScreen extends StatefulWidget {
  const AddFromInconvenientesArbolesScreen({Key? key}) : super(key: key);

  @override
  _AddFromInconvenientesArbolesScreenState createState() =>
      _AddFromInconvenientesArbolesScreenState();
}

class _AddFromInconvenientesArbolesScreenState
    extends State<AddFromInconvenientesArbolesScreen> {
  bool boolInicio = false;
  bool boolCargarDatos = true;

  /*   --------------- Parametros para Editar Usuario --------------*/

  /** Variables para presentar datos **/
  static List<AccionesRecomendadas> _listAR = [];
  static List<PresenciaEnfermedades> _listPE = [];
  static List<PresenciaPlagas> _listPP = [];
  static List<ProblemasFisicos> _listPF = [];
  static List<RiesgosPotenciales> _listRP = [];
  static List<UbicacionEnfermedades> _listUE = [];
  static List<EstadoFitosanitario> _listEF = [];

  var _itemsAR;
  var _itemsPE;
  var _itemsPP;
  var _itemsPF;
  var _itemsRP;
  var _itemsUE;
  var _itemsEF;

  List<AccionesRecomendadas> _selectedAR = [];
  List<PresenciaEnfermedades> _selectedPE = [];
  List<PresenciaPlagas> _selectedPP = [];
  List<ProblemasFisicos> _selectedPF = [];
  List<RiesgosPotenciales> _selectedRP = [];
  List<UbicacionEnfermedades> _selectedUE = [];
  List<EstadoFitosanitario> _selectedEF = [];

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
    getDataAR();
    getDataPE();
    getDataPF();
    getDataPP();
    getDataRP();
    getDataUE();
    getDataEF();
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
    /*Arboles? objArbol = ModalRoute.of(context)!.settings.arguments
        as Arboles?; //cargamos datos del arbol*/

    List? _listArguementos =
        ModalRoute.of(context)!.settings.arguments as List?;
    //print(_listArguementos![1]);
    Arboles? objArbol = _listArguementos![0]; //cargamos datos del arbol
    Usuario? objUsuario = _listArguementos[1]; //cargamos datos del usuario

    if (boolInicio) {
      getDataInconvenienteArbobl(objArbol!.getId_a.toString());
      boolInicio = false;
    }

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

    /** ---------------------------- **/
    _itemsAR = _listAR
        .map((obj) => MultiSelectItem<AccionesRecomendadas>(
            obj, obj.getDescripcion_ar.toString()))
        .toList();
    _itemsPE = _listPE
        .map((obj) => MultiSelectItem<PresenciaEnfermedades>(
            obj, obj.getDescripcion_pe.toString()))
        .toList();
    _itemsPP = _listPP
        .map((obj) => MultiSelectItem<PresenciaPlagas>(
            obj, obj.getDescripcion_pp.toString()))
        .toList();
    _itemsPF = _listPF
        .map((obj) => MultiSelectItem<ProblemasFisicos>(
            obj, obj.getDescripcion_pf.toString()))
        .toList();
    _itemsRP = _listRP
        .map((obj) => MultiSelectItem<RiesgosPotenciales>(
            obj, obj.getDescripcion_rp.toString()))
        .toList();
    _itemsUE = _listUE
        .map((obj) => MultiSelectItem<UbicacionEnfermedades>(
            obj, obj.getDescripcion_ue.toString()))
        .toList();
    _itemsEF = _listEF
        .map((obj) => MultiSelectItem<EstadoFitosanitario>(
            obj, obj.getDescripcion_ef.toString()))
        .toList();

    return WillPopScope(
        onWillPop: () async => willPopCallback(context),
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text("Manejo forestal"),
          ),
          body: boolCargarDatos
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Text(
                          strTituloRegistro,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              //ponemos en negrita el texto
                              fontSize: 24 //aumentamos letra
                              ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                            'Click para seleccionar o eliminar algún dato'),
                        Divider(
                          height: 5.0,
                          color: Theme.of(context).primaryColor,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              //color: Theme.of(context).primaryColor.withOpacity(.4),
                              /*border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                  ),*/
                              ),
                          child: Column(
                            children: <Widget>[
                              const SizedBox(
                                height: 10,
                              ),
                              MultiSelectBottomSheetField(
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.1),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(40)),
                                  border: Border.all(
                                    color: Colors.blue,
                                    width: 2,
                                  ),
                                ),
                                selectedColor: Colors.blue[800],
                                selectedItemsTextStyle: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                                initialChildSize: 0.4,
                                listType: MultiSelectListType.CHIP,
                                buttonIcon: const Icon(
                                  FontAwesomeIcons.pagelines,
                                  color: Colors.blue,
                                ),
                                searchable: true,
                                buttonText: Text(
                                  "Acciones Recomendadas",
                                  style: TextStyle(
                                    color: Colors.blue[800],
                                    fontSize: 16,
                                  ),
                                ),
                                title: const Text("Ingrese busqueda"),
                                items: _itemsAR,
                                onConfirm: (values) {
                                  _selectedAR =
                                      values.cast<AccionesRecomendadas>();
                                },
                                chipDisplay: MultiSelectChipDisplay(
                                  onTap: (value) {
                                    setState(() {
                                      _selectedAR.remove(value);
                                    });
                                  },
                                ),
                              ),
                              _selectedAR_BD.isEmpty
                                  ? const Text('')
                                  : _selectedAR.isEmpty
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            const SizedBox(height: 5),
                                            const Text(
                                                'Inconvenientes existentes actualmente'),
                                            MultiSelectChipDisplay(
                                              items: _itemsAR_BD,
                                              onTap: (value) {
                                                setState(() {
                                                  _selectedAR_BD.remove(value);
                                                });
                                              },
                                            ),
                                          ],
                                        )
                                      : const Text(''),
                              const SizedBox(height: 40),
                              MultiSelectBottomSheetField(
                                decoration: BoxDecoration(
                                  color: Colors.orange.withOpacity(0.1),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(40)),
                                  border: Border.all(
                                    color: Colors.orange,
                                    width: 2,
                                  ),
                                ),
                                selectedColor: Colors.orange[800],
                                selectedItemsTextStyle: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                                initialChildSize: 0.4,
                                listType: MultiSelectListType.CHIP,
                                buttonIcon: const Icon(
                                  FontAwesomeIcons.pagelines,
                                  color: Colors.orange,
                                ),
                                searchable: true,
                                buttonText: Text(
                                  "Estado Fitosanitario",
                                  style: TextStyle(
                                    color: Colors.orange[800],
                                    fontSize: 16,
                                  ),
                                ),
                                title: const Text("Ingrese busqueda"),
                                items: _itemsEF,
                                onConfirm: (values) {
                                  _selectedEF =
                                      values.cast<EstadoFitosanitario>();
                                },
                                chipDisplay: MultiSelectChipDisplay(
                                  onTap: (value) {
                                    setState(() {
                                      _selectedEF.remove(value);
                                    });
                                  },
                                ),
                              ),
                              _selectedEF_BD.isEmpty
                                  ? const Text('')
                                  : _selectedEF.isEmpty
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            const SizedBox(height: 5),
                                            const Text(
                                                'Inconvenientes existentes actualmente'),
                                            MultiSelectChipDisplay(
                                              items: _itemsEF_BD,
                                              onTap: (value) {
                                                setState(() {
                                                  _selectedEF_BD.remove(value);
                                                });
                                              },
                                            ),
                                          ],
                                        )
                                      : const Text(''),
                              const SizedBox(height: 40),
                              MultiSelectBottomSheetField(
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.1),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(40)),
                                  border: Border.all(
                                    color: Colors.green,
                                    width: 2,
                                  ),
                                ),
                                selectedColor: Colors.green[800],
                                selectedItemsTextStyle: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                                initialChildSize: 0.4,
                                listType: MultiSelectListType.CHIP,
                                buttonIcon: const Icon(
                                  FontAwesomeIcons.disease,
                                  color: Colors.green,
                                ),
                                //searchable: true,
                                buttonText: Text(
                                  "Presencia Enfermedades",
                                  style: TextStyle(
                                    color: Colors.green[800],
                                    fontSize: 16,
                                  ),
                                ),
                                title: const Text("Ingrese busqueda"),
                                items: _itemsPE,
                                onConfirm: (values) {
                                  //values = _selectedPE;
                                  _selectedPE =
                                      values.cast<PresenciaEnfermedades>();
                                },
                                //initialValue: _selectedPE,
                                chipDisplay: MultiSelectChipDisplay(
                                  onTap: (value) {
                                    setState(() {
                                      _selectedPE.remove(value);
                                    });
                                  },
                                ),
                              ),
                              _selectedPE_BD.isEmpty
                                  ? const Text('')
                                  : _selectedPE.isEmpty
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            const SizedBox(height: 5),
                                            const Text(
                                                'Inconvenientes existentes actualmente'),
                                            MultiSelectChipDisplay(
                                              items: _itemsPE_BD,
                                              onTap: (value) {
                                                setState(() {
                                                  _selectedPE_BD.remove(value);
                                                });
                                              },
                                            ),
                                          ],
                                        )
                                      : const Text(''),
                              const SizedBox(height: 40),
                              MultiSelectBottomSheetField(
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.1),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(40)),
                                  border: Border.all(
                                    color: Colors.indigo,
                                    width: 2,
                                  ),
                                ),
                                selectedColor: Colors.indigo[800],
                                selectedItemsTextStyle: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                                initialChildSize: 0.4,
                                listType: MultiSelectListType.CHIP,
                                buttonIcon: const Icon(
                                  FontAwesomeIcons.bug,
                                  color: Colors.indigo,
                                ),
                                searchable: true,
                                buttonText: Text(
                                  "Presencia Plagas",
                                  style: TextStyle(
                                    color: Colors.indigo[800],
                                    fontSize: 16,
                                  ),
                                ),
                                title: const Text("Ingrese busqueda"),
                                items: _itemsPP,
                                onConfirm: (values) {
                                  _selectedPP = values.cast<PresenciaPlagas>();
                                },
                                chipDisplay: MultiSelectChipDisplay(
                                  onTap: (value) {
                                    setState(() {
                                      _selectedPP.remove(value);
                                    });
                                  },
                                ),
                              ),
                              _selectedPP_BD.isEmpty
                                  ? const Text('')
                                  : _selectedPP.isEmpty
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            const SizedBox(height: 5),
                                            const Text(
                                                'Inconvenientes existentes actualmente'),
                                            MultiSelectChipDisplay(
                                              items: _itemsPP_BD,
                                              onTap: (value) {
                                                setState(() {
                                                  _selectedPP_BD.remove(value);
                                                });
                                              },
                                            ),
                                          ],
                                        )
                                      : const Text(''),
                              const SizedBox(height: 40),
                              MultiSelectBottomSheetField(
                                decoration: BoxDecoration(
                                  color: Colors.greenAccent.withOpacity(0.1),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(40)),
                                  border: Border.all(
                                    color: Colors.purple,
                                    width: 2,
                                  ),
                                ),
                                selectedColor: Colors.purple,
                                selectedItemsTextStyle: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                                initialChildSize: 0.4,
                                listType: MultiSelectListType.CHIP,
                                buttonIcon: const Icon(
                                  FontAwesomeIcons.teeth,
                                  color: Colors.purple,
                                ),
                                searchable: true,
                                buttonText: const Text(
                                  "Problemas Físicos",
                                  style: TextStyle(
                                    color: Colors.purple,
                                    fontSize: 16,
                                  ),
                                ),
                                title: const Text("Ingrese busqueda"),
                                items: _itemsPF,
                                onConfirm: (values) {
                                  _selectedPF = values.cast<ProblemasFisicos>();
                                },
                                chipDisplay: MultiSelectChipDisplay(
                                  onTap: (value) {
                                    setState(() {
                                      _selectedPF.remove(value);
                                    });
                                  },
                                ),
                              ),
                              _selectedPF_BD.isEmpty
                                  ? const Text('')
                                  : _selectedPF.isEmpty
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            const SizedBox(height: 5),
                                            const Text(
                                                'Inconvenientes existentes actualmente'),
                                            MultiSelectChipDisplay(
                                              items: _itemsPF_BD,
                                              onTap: (value) {
                                                setState(() {
                                                  _selectedPF_BD.remove(value);
                                                });
                                              },
                                            ),
                                          ],
                                        )
                                      : const Text(''),
                              const SizedBox(height: 40),
                              MultiSelectBottomSheetField(
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.1),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(40)),
                                  border: Border.all(
                                    color: Colors.teal,
                                    width: 2,
                                  ),
                                ),
                                selectedColor: Colors.teal[800],
                                selectedItemsTextStyle: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                                initialChildSize: 0.4,
                                listType: MultiSelectListType.CHIP,
                                buttonIcon: const Icon(
                                  FontAwesomeIcons.asterisk,
                                  color: Colors.teal,
                                ),
                                searchable: true,
                                buttonText: Text(
                                  "Riesgos Potenciales",
                                  style: TextStyle(
                                    color: Colors.teal[800],
                                    fontSize: 16,
                                  ),
                                ),
                                title: const Text("Ingrese busqueda"),
                                items: _itemsRP,
                                onConfirm: (values) {
                                  _selectedRP =
                                      values.cast<RiesgosPotenciales>();
                                },
                                chipDisplay: MultiSelectChipDisplay(
                                  onTap: (value) {
                                    setState(() {
                                      _selectedRP.remove(value);
                                    });
                                  },
                                ),
                              ),
                              _selectedRP_BD.isEmpty
                                  ? const Text('')
                                  : _selectedRP.isEmpty
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            const SizedBox(height: 5),
                                            const Text(
                                                'Inconvenientes existentes actualmente'),
                                            MultiSelectChipDisplay(
                                              items: _itemsRP_BD,
                                              onTap: (value) {
                                                setState(() {
                                                  _selectedRP_BD.remove(value);
                                                });
                                              },
                                            ),
                                          ],
                                        )
                                      : const Text(''),
                              const SizedBox(height: 40),
                              MultiSelectBottomSheetField(
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.1),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(40)),
                                  border: Border.all(
                                    color: Colors.blueGrey,
                                    width: 2,
                                  ),
                                ),
                                selectedColor: Colors.blueGrey[800],
                                selectedItemsTextStyle: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                                initialChildSize: 0.4,
                                listType: MultiSelectListType.CHIP,
                                buttonIcon: const Icon(
                                  FontAwesomeIcons.virus,
                                  color: Colors.blueGrey,
                                ),
                                searchable: true,
                                buttonText: Text(
                                  "Ubicación Enfermedades",
                                  style: TextStyle(
                                    color: Colors.blueGrey[800],
                                    fontSize: 16,
                                  ),
                                ),
                                title: const Text("Ingrese busqueda"),
                                items: _itemsUE,
                                onConfirm: (values) {
                                  _selectedUE =
                                      values.cast<UbicacionEnfermedades>();
                                },
                                chipDisplay: MultiSelectChipDisplay(
                                  onTap: (value) {
                                    setState(() {
                                      _selectedUE.remove(value);
                                    });
                                  },
                                ),
                              ),
                              _selectedUE_BD.isEmpty
                                  ? const Text('')
                                  : _selectedUE.isEmpty
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            const SizedBox(height: 5),
                                            const Text(
                                                'Inconvenientes existentes actualmente'),
                                            MultiSelectChipDisplay(
                                              items: _itemsUE_BD,
                                              onTap: (value) {
                                                setState(() {
                                                  _selectedUE_BD.remove(value);
                                                });
                                              },
                                            ),
                                          ],
                                        )
                                      : const Text(''),
                              const SizedBox(
                                height: 40,
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: MaterialButton(
                                  onPressed: () {
                                    _cargarDatos(context);
                                    try {
                                      /** Refrescamos las listas de obejtos **/
                                      for (var element in _selectedAR_BD) {
                                        int posision =
                                            _selectedAR.indexOf(element);
                                        if (posision < 0) {
                                          _selectedAR.add(element);
                                        }
                                        if (_selectedAR.length > 1) {
                                          _selectedAR.remove(element);
                                        }
                                      }

                                      for (var element in _selectedPE_BD) {
                                        int posision =
                                            _selectedPE.indexOf(element);
                                        if (posision < 0) {
                                          _selectedPE.add(element);
                                        }
                                        if (_selectedPE.length > 1) {
                                          _selectedPE.remove(element);
                                        }
                                      }

                                      for (var element in _selectedPP_BD) {
                                        int posision =
                                            _selectedPP.indexOf(element);
                                        if (posision < 0) {
                                          _selectedPP.add(element);
                                        }
                                        if (_selectedPP.length > 1) {
                                          _selectedPP.remove(element);
                                        }
                                      }

                                      for (var element in _selectedPF_BD) {
                                        int posision =
                                            _selectedPF.indexOf(element);
                                        if (posision < 0) {
                                          _selectedPF.add(element);
                                        }
                                        if (_selectedPF.length > 1) {
                                          _selectedPF.remove(element);
                                        }
                                      }

                                      for (var element in _selectedRP_BD) {
                                        int posision =
                                            _selectedRP.indexOf(element);
                                        if (posision < 0) {
                                          _selectedRP.add(element);
                                        }
                                        if (_selectedRP.length > 1) {
                                          _selectedRP.remove(element);
                                        }
                                      }
                                      for (var element in _selectedUE_BD) {
                                        int posision =
                                            _selectedUE.indexOf(element);
                                        if (posision < 0) {
                                          _selectedUE.add(element);
                                        }
                                        if (_selectedUE.length > 1) {
                                          _selectedUE.remove(element);
                                        }
                                      }
                                      for (var element in _selectedEF_BD) {
                                        int posision =
                                            _selectedEF.indexOf(element);
                                        if (posision < 0) {
                                          _selectedEF.add(element);
                                        }
                                        if (_selectedEF.length > 1) {
                                          _selectedEF.remove(element);
                                        }
                                      }

                                      /** Eliminar datos de tabla incomvenietes de arbol **/
                                      setState(() async {
                                        InconvenienteArbolDB _objBD =
                                            InconvenienteArbolDB();
                                        String _accion =
                                            await _objBD.Eliminar_IA(int.parse(
                                                objArbol!.getId_a.toString()));

                                        if (_accion != "ACCIÓN CORRECTA") {
                                          _Mensaje(
                                              "Error al dar de baja datos de tabla inconvenietes: Revise su conexion de Internet");
                                        } else {
                                          String fecha =
                                              DateTime.now().toString();
                                          /** Guardamos los datos de las listas **/
                                          for (var element in _selectedPE) {
                                            InconvenienteArbol obj =
                                                InconvenienteArbol(
                                                    null,
                                                    int.parse(objArbol.getId_a
                                                        .toString()),
                                                    null,
                                                    element.getId_pe,
                                                    null,
                                                    null,
                                                    null,
                                                    null,
                                                    null,
                                                    fecha,
                                                    "A",
                                                    objUsuario!.getId_u);
                                            InconvenienteArbolDB objBD =
                                                InconvenienteArbolDB();
                                            String accion =
                                                await objBD.Agregar_IA(obj);

                                            if (accion != "ACCIÓN CORRECTA") {
                                              _Mensaje(
                                                  "Error al Agregar presesencia de enfermedad " +
                                                      element.getDescripcion_pe
                                                          .toString() +
                                                      ": Revise su conexion de Internet");
                                            }
                                          }

                                          for (var element in _selectedUE) {
                                            InconvenienteArbol obj =
                                                InconvenienteArbol(
                                                    null,
                                                    int.parse(objArbol.getId_a
                                                        .toString()),
                                                    null,
                                                    null,
                                                    element.getId_ue,
                                                    null,
                                                    null,
                                                    null,
                                                    null,
                                                    DateTime.now().toString(),
                                                    "A",
                                                    objUsuario!.getId_u);
                                            InconvenienteArbolDB objBD =
                                                InconvenienteArbolDB();
                                            String accion =
                                                await objBD.Agregar_IA(obj);

                                            if (accion != "ACCIÓN CORRECTA") {
                                              _Mensaje(
                                                  "Error al Agregar ubicación de enfermedades " +
                                                      element.getDescripcion_ue
                                                          .toString() +
                                                      ": Revise su conexion de Internet");
                                            }
                                          }

                                          for (var element in _selectedPP) {
                                            InconvenienteArbol obj =
                                                InconvenienteArbol(
                                                    null,
                                                    int.parse(objArbol.getId_a
                                                        .toString()),
                                                    null,
                                                    null,
                                                    null,
                                                    element.getId_pp,
                                                    null,
                                                    null,
                                                    null,
                                                    DateTime.now().toString(),
                                                    "A",
                                                    objUsuario!.getId_u);
                                            InconvenienteArbolDB objBD =
                                                InconvenienteArbolDB();
                                            String accion =
                                                await objBD.Agregar_IA(obj);

                                            if (accion != "ACCIÓN CORRECTA") {
                                              _Mensaje(
                                                  "Error al Agregar presencia de plagas " +
                                                      element.getDescripcion_pp
                                                          .toString() +
                                                      ": Revise su conexion de Internet");
                                            }
                                          }

                                          for (var element in _selectedPF) {
                                            InconvenienteArbol obj =
                                                InconvenienteArbol(
                                                    null,
                                                    int.parse(objArbol.getId_a
                                                        .toString()),
                                                    null,
                                                    null,
                                                    null,
                                                    null,
                                                    element.getId_pf,
                                                    null,
                                                    null,
                                                    DateTime.now().toString(),
                                                    "A",
                                                    objUsuario!.getId_u);
                                            InconvenienteArbolDB objBD =
                                                InconvenienteArbolDB();
                                            String accion =
                                                await objBD.Agregar_IA(obj);

                                            if (accion != "ACCIÓN CORRECTA") {
                                              _Mensaje(
                                                  "Error al Agregar problemas físicos " +
                                                      element.getDescripcion_pf
                                                          .toString() +
                                                      ": Revise su conexion de Internet");
                                            }
                                          }

                                          for (var element in _selectedRP) {
                                            InconvenienteArbol obj =
                                                InconvenienteArbol(
                                                    null,
                                                    int.parse(objArbol.getId_a
                                                        .toString()),
                                                    null,
                                                    null,
                                                    null,
                                                    null,
                                                    null,
                                                    element.getId_rp,
                                                    null,
                                                    DateTime.now().toString(),
                                                    "A",
                                                    objUsuario!.getId_u);
                                            InconvenienteArbolDB objBD =
                                                InconvenienteArbolDB();
                                            String accion =
                                                await objBD.Agregar_IA(obj);

                                            if (accion != "ACCIÓN CORRECTA") {
                                              _Mensaje(
                                                  "Error al Agregar presesencia de enfermedad " +
                                                      element.getDescripcion_rp
                                                          .toString() +
                                                      ": Revise su conexion de Internet");
                                            }
                                          }

                                          for (var element in _selectedAR) {
                                            InconvenienteArbol obj =
                                                InconvenienteArbol(
                                                    null,
                                                    int.parse(objArbol.getId_a
                                                        .toString()),
                                                    null,
                                                    null,
                                                    null,
                                                    null,
                                                    null,
                                                    null,
                                                    element.getId_ar,
                                                    DateTime.now().toString(),
                                                    "A",
                                                    objUsuario!.getId_u);
                                            InconvenienteArbolDB objBD =
                                                InconvenienteArbolDB();
                                            String accion =
                                                await objBD.Agregar_IA(obj);

                                            if (accion != "ACCIÓN CORRECTA") {
                                              _Mensaje(
                                                  "Error al Agregar acciones recomendadas " +
                                                      element.getDescripcion_ar
                                                          .toString() +
                                                      ": Revise su conexion de Internet");
                                            }
                                          }

                                          for (var element in _selectedEF) {
                                            InconvenienteArbol obj =
                                                InconvenienteArbol(
                                                    null,
                                                    int.parse(objArbol.getId_a
                                                        .toString()),
                                                    element.getId_ef,
                                                    null,
                                                    null,
                                                    null,
                                                    null,
                                                    null,
                                                    null,
                                                    DateTime.now().toString(),
                                                    "A",
                                                    objUsuario!.getId_u);
                                            InconvenienteArbolDB objBD =
                                                InconvenienteArbolDB();
                                            String accion =
                                                await objBD.Agregar_IA(obj);

                                            if (accion != "ACCIÓN CORRECTA") {
                                              _Mensaje(
                                                  "Error al Agregar estado fitosanitario " +
                                                      element.getDescripcion_ef
                                                          .toString() +
                                                      ": Revise su conexion de Internet");
                                            }
                                          }
                                          _Mensaje("Datos Registrados");
                                          /*cerramos alerta y ventana actual*/
                                          Navigator.pop(context);

                                          Navigator.pop(context);
                                        }
                                      });
                                    } on Exception catch (exception) {
                                      // _Mensaje("Error on server-> " + exception.toString());
                                      throw Exception("Error on server");
                                    } catch (error) {
                                      //_Mensaje("Error-> " + error.toString());
                                    }
                                  },
                                  child: Container(
                                    //width: 200.0,
                                    //width: size.width * 0.8,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: kPrimaryColor,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    alignment: Alignment.center,
                                    //child: Row(
                                    //mainAxisAlignment: MainAxisAlignment.center,
                                    child: const Text(
                                      "Guardar",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
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
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ));
  }

/*Obtenemos los datos del servidor*/
  void getDataAR() async {
    List<AccionesRecomendadas> _list = [];
    AccionesRecomendadasDB mm = AccionesRecomendadasDB();
    List? response = await mm.Listar_AR();
    for (var element in response!) {
      _list.add(AccionesRecomendadas(
          int.parse(element['id_ar'].toString()),
          element['descripcion_ar'].toString(),
          element['estado_ar'].toString()));
    }
    setState(() {
      _listAR = _list;
    });
  }

  void getDataPE() async {
    List<PresenciaEnfermedades> _list = [];
    PresenciaEnfermedadesDB mm = PresenciaEnfermedadesDB();
    List? response = await mm.Listar_PE();
    for (var element in response!) {
      _list.add(PresenciaEnfermedades(
          int.parse(element['id_pe'].toString()),
          element['descripcion_pe'].toString(),
          element['estado_pe'].toString()));
    }
    setState(() {
      _listPE = _list;
    });
  }

  void getDataPP() async {
    List<PresenciaPlagas> _list = [];
    PresenciaPlagasDB mm = PresenciaPlagasDB();
    List? response = await mm.Listar_PP();
    for (var element in response!) {
      _list.add(PresenciaPlagas(
          int.parse(element['id_pp'].toString()),
          element['descripcion_pp'].toString(),
          element['estado_pp'].toString()));
    }
    setState(() {
      _listPP = _list;
    });
  }

  void getDataPF() async {
    List<ProblemasFisicos> _list = [];
    ProblemasFisicosDB mm = ProblemasFisicosDB();
    List? response = await mm.Listar_PF();
    for (var element in response!) {
      _list.add(ProblemasFisicos(
          int.parse(element['id_pf'].toString()),
          element['descripcion_pf'].toString(),
          element['estado_pf'].toString()));
    }
    setState(() {
      _listPF = _list;
    });
  }

  void getDataRP() async {
    List<RiesgosPotenciales> _list = [];
    RiesgosPotencialesDB mm = RiesgosPotencialesDB();
    List? response = await mm.Listar_RP();
    for (var element in response!) {
      _list.add(RiesgosPotenciales(
          int.parse(element['id_rp'].toString()),
          element['descripcion_rp'].toString(),
          element['estado_rp'].toString()));
    }
    setState(() {
      _listRP = _list;
    });
  }

  void getDataUE() async {
    List<UbicacionEnfermedades> _list = [];
    UbicacionEnfermedadesDB mm = UbicacionEnfermedadesDB();
    List? response = await mm.Listar_UE();
    for (var element in response!) {
      _list.add(UbicacionEnfermedades(
          int.parse(element['id_ue'].toString()),
          element['descripcion_ue'].toString(),
          element['estado_ue'].toString()));
    }
    setState(() {
      _listUE = _list;
    });
  }

  void getDataEF() async {
    List<EstadoFitosanitario> _list = [];
    EstadoFitosanitarioDB mm = EstadoFitosanitarioDB();
    List? response = await mm.Listar_EF();
    for (var element in response!) {
      _list.add(EstadoFitosanitario(
          int.parse(element['id_ef'].toString()),
          element['descripcion_ef'].toString(),
          element['estado_ef'].toString()));
    }
    setState(() {
      _listEF = _list;
    });
  }

  void _Mensaje(String testo) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(testo)));
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
              child: const Text("Loading...")),
        ],
      ),
      actions: <Widget>[],
    ),
  );
}
