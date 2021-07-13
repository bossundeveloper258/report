import 'dart:io';

import 'package:flutter/material.dart';
import 'package:presentacion/core/utilities/alertDialog.dart';
import 'package:presentacion/core/utilities/constanst.dart';
import 'package:presentacion/core/providers/provider.dart';
import 'package:presentacion/core/model/reporte.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:presentacion/core/model/validation_item.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';

class FrmReportScreen extends StatefulWidget {
  late final Report report;

  FrmReportScreen({ report });

  @override
  _FrmReportScreenState createState() => _FrmReportScreenState();

}

class _FrmReportScreenState extends State<FrmReportScreen>{

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _dniController = new TextEditingController();
  TextEditingController _placeIncidentController = new TextEditingController();
  TextEditingController _descriptionController = new TextEditingController();
  TextEditingController _aggressorController = new TextEditingController();

  TextEditingController _dateController = new TextEditingController();
  final AlertDialogApp alertDialogApp = new AlertDialogApp();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? _fileName;
  List<PlatformFile>? _paths;
  String? _directoryPath;
  bool _loadingPath = false;
  FileType _pickingType = FileType.custom;


  bool _addInvolved = false;
  bool _addEvidences = false;

  @override
  void initState() {
    // TODO: implement initState


    _nameController = new TextEditingController(text: '');
    _phoneController = new TextEditingController(text: '');
    _dniController = new TextEditingController(text: '');
    _placeIncidentController = new TextEditingController(text: '');
    _descriptionController = new TextEditingController(text: '');
    _aggressorController = new TextEditingController(text: '');
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _dniController.dispose();
    _placeIncidentController.dispose();
    _descriptionController.dispose();
    _aggressorController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final entryProvider = Provider.of<ReportProvider>(context);



    void _openFileExplorer() async {
      setState(() => _loadingPath = true);
      try {
        _directoryPath = null;
        _paths = (await FilePicker.platform.pickFiles(
          type: _pickingType,
          allowMultiple: true,
          allowedExtensions: ['jpg', 'png'],
        ))
            ?.files;
      } on PlatformException catch (e) {
        print("Unsupported operation" + e.toString());
      } catch (ex) {
        print(ex);
      }
      if (!mounted) return;
      setState(() {
        _loadingPath = false;
        print(_paths!.first.extension);
        _fileName =
        _paths != null ? _paths!.map((e) => e.name).toString() : '...';
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Reporte'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Card(

          child: Center(
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  onChanged: (String value) => entryProvider.changeName(value),
                  style: TextStyle(fontSize: 17.0, color: Colors.black),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nombre',
                      errorText: entryProvider.name.error
                  ),
                ),

                SizedBox(height: 10.0),
                TextField(
                  controller: _phoneController,
                  onChanged: (String value) => entryProvider.changePhone(value),
                  style: TextStyle(fontSize: 17.0, color: Colors.black),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Telefono',
                      errorText: entryProvider.phone.error
                  ),
                ),

                SizedBox(height: 10.0),
                TextField(
                  controller: _dniController,
                  keyboardType: TextInputType.number,
                  onChanged: (String value) => entryProvider.changeDNI(value),
                  style: TextStyle(fontSize: 17.0, color: Colors.black),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'DNI',
                      errorText: entryProvider.dni.error
                  ),
                ),

                SizedBox(height: 10.0),
                TextField(
                  controller: _placeIncidentController,
                  onChanged: (String value) => entryProvider.changePlaceIncident(value),
                  style: TextStyle(fontSize: 17.0, color: Colors.black),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Lugar de Incidente',
                      errorText: entryProvider.placeIncident.error
                  ),

                ),
                SizedBox(height: 10.0),
                TextField(
                  controller: _descriptionController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  onChanged: (String value) => entryProvider.changeDescription(value),
                  style: TextStyle(fontSize: 17.0, color: Colors.black),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Descripcion de lo sucedido',
                      errorText: entryProvider.description.error
                  ),

                ),

                SizedBox(height: 10.0),
                Container(
                  height: 20.0,
                  child: Row(
                    children: <Widget>[
                    Theme(
                    data: ThemeData(unselectedWidgetColor: Colors.white),
                      child: Checkbox(
                        value: _addInvolved,
                        checkColor: Colors.green,
                        activeColor: Colors.white,
                        onChanged: (value) {
                          setState(() {
                            _addInvolved = value!;
                          });
                        },
                      ),
                    ),
                    Text(
                      'Agregar Implicados',
                    ),
                    ],
                  ),
                ),

                SizedBox(height: 10.0),
                TextField(
                  controller: _aggressorController,
                  onChanged: (String value) => entryProvider.changeAggressor(value),
                  enabled: _addInvolved,
                  style: TextStyle(fontSize: 17.0, color: Colors.black),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Implicado(s)',
                      errorText: entryProvider.aggressor.error
                  ),
                ),

                SizedBox(height: 10.0),
                TextField(
                  onTap: () async {
                    final DateTime? picked  =  await showDatePicker(
                      initialDate: DateTime.now(),
                      context: context,
                      firstDate: DateTime(2019, 8),
                      lastDate: DateTime(2100)
                    );
                    if(picked != null){

                      setState(() {
                        var date =
                            "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
                        entryProvider.changeDate(date);
                        _dateController.text = date;
                      });
                    }else{
                      print("Time is not selected");
                    }

                  },
                  onChanged: (String value) => entryProvider.changeDate(value),
                  readOnly: true,
                  controller: _dateController,
                  keyboardType: TextInputType.datetime,
                  style: TextStyle(fontSize: 17.0, color: Colors.black),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Fecha',
                      errorText: entryProvider.date.error
                  ),

                ),

                SizedBox(height: 10.0),
                Container(
                  height: 20.0,
                  child: Row(
                    children: <Widget>[
                      Theme(
                        data: ThemeData(unselectedWidgetColor: Colors.white),
                        child: Checkbox(
                          value: _addEvidences,
                          checkColor: Colors.green,
                          activeColor: Colors.white,
                          onChanged: (value) {
                            setState(() {
                              _addEvidences = value!;
                            });
                          },
                        ),
                      ),
                      Text(
                        'Agregar Evidencias',
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                  child: Column(
                    children: <Widget>[
                      Text( "Evidencias: Fotos o video" ),
                      ElevatedButton.icon(
                        onPressed: () => _openFileExplorer(),
                        icon: Icon(
                          Icons.upload_file_rounded,
                          color: Colors.white,
                          size: 24.0,
                        ), label: Text('')
                      ),

                    ],
                  ),
                ),
                Builder(
                  builder: (BuildContext context) => _loadingPath
                      ? Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: const CircularProgressIndicator(),
                  )
                      : _directoryPath != null
                      ? ListTile(
                    title: const Text('Directory path'),
                    subtitle: Text(_directoryPath!),
                  )
                      : _paths != null
                      ? Container(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    height: MediaQuery.of(context).size.height * 0.50,
                    child: Scrollbar(
                        child: ListView.separated(
                          itemCount:
                          _paths != null && _paths!.isNotEmpty
                              ? _paths!.length
                              : 1,
                          itemBuilder:
                              (BuildContext context, int index) {
                            final bool isMultiPath =
                                _paths != null && _paths!.isNotEmpty;
                            final String name = 'File $index: ' +
                                (isMultiPath
                                    ? _paths!
                                    .map((e) => e.name)
                                    .toList()[index]
                                    : _fileName ?? '...');
                            final path = _paths!
                                .map((e) => e.path)
                                .toList()[index]
                                .toString();

                            return Card(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                      child:Container(
                                        child: Image.file(new File(path)),
                                    ),flex: 1,

                                  ),
                                  Expanded( child:Padding(
                                    padding: EdgeInsets.all(7.0),
                                    child: Text(  name ),
                                  ),flex: 2,)
                                ],
                              ),
                            );
                          },
                          separatorBuilder:
                              (BuildContext context, int index) =>
                          const Divider(),
                        )),
                  )
                      : const SizedBox(),
                ),


                SizedBox(height: 30.0),
                RaisedButton(
                  elevation: 5.0,
                  onPressed: ()  {
                    print(entryProvider.name.error);
                    print(entryProvider.isValid);
                    if( entryProvider.isValid ){
                      alertDialogApp.buildAlertDialog(context, "Se Grabo correctamente");
                      entryProvider.saveReport();
                      Navigator.pushNamed(context, '/welcome');
                    }else{
                      alertDialogApp.buildAlertDialog(context, "Falta rellenar algunos datos");
                    }

                  },
                  padding: EdgeInsets.all(15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: primaryColor,
                  child: Text(
                    'ENVIAR',
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1.5,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                ),
                SizedBox(height: 50.0)
              ],
            ),
          ),
        ),
      ),
    );
  }


}