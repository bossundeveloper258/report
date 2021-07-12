import 'dart:async';
import 'package:flutter/material.dart';
import 'package:presentacion/core/utilities/constanst.dart';
import 'package:presentacion/core/providers/provider.dart';
import 'package:presentacion/core/model/reporte.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  static String id = 'all_products';

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final entryProvider = Provider.of<ReportProvider>(context);
    print(entryProvider.reports.length);
    print("eeeeee");
    return Scaffold(
        body: StreamBuilder(
            stream: entryProvider.reports,
          builder: (BuildContext context, AsyncSnapshot<List<Report>> snapshot) {
              print(snapshot.data);
            if (snapshot.data == null)
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.red,
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.teal),
                ),
              );
            return Container(
                child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Report _repo = snapshot.data![index];
                      return Card(
                          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                          child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  isThreeLine: true,
                                  title: Text(
                                    _repo.date ,
                                    style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "ID: " + _repo.id,
                                        style: TextStyle(fontSize: 15.0),
                                      ),
                                      SizedBox(height: 15.0,),
                                      Text(
                                        "Ubicacion del caso: " + _repo.placeIncident,
                                        style: TextStyle(fontSize: 15.0),
                                      )
                                    ],
                                  )
                                ),
                              )
                          )
                      );
                    }
                )
            );
          },

        )
    );
  }

  @override
  void dispose() {

    super.dispose();
  }

}