import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertDialogApp{

  String message = "";

  void buildAlertDialog(BuildContext context , String _message) {
    this.message = _message;
    if (Platform.isAndroid) {
      _materialAlertDialog(context);
    } else if (Platform.isIOS) {
      _cupertinoDialog(context);
    } else {
      _materialAlertDialog(context);
    }
  }

  Future<void> _materialAlertDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (_) => _showMaterialDialog(context),
    );
  }

  Widget _showMaterialDialog(BuildContext context) {
    return AlertDialog(
      title: _dialogTitle(),
      content: _contentText(),
      actions: _buildActions(context),
    );
  }

  Future<void> _cupertinoDialog(BuildContext context) async {
    return showCupertinoDialog<void>(
      context: context,
      builder: (_) => _showCupertinoDialog(context),
    );
  }

  Widget _showCupertinoDialog(BuildContext context) {
    return CupertinoAlertDialog(
      title: _dialogTitle(),
      content: _contentText(),
      actions: _buildActions(context),
    );
  }

  Widget _dialogTitle() {
    return Text('Notificaciones');
  }

  List<Widget> _buildActions(BuildContext context) {
    return [
      _buildActionButton(context, "Cancelar", Colors.redAccent)
    ];
  }

  Widget _contentText() {
    return Text(this.message);
  }


  Widget _buildActionButton(BuildContext context , String title, Color color) {
    return FlatButton(
      child: Text(title),
      textColor: color,
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}