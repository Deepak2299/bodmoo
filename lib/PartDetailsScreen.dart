import 'package:bodmoo/models/partsModel.dart';
import 'package:flutter/material.dart';

class PartDetailsScren extends StatefulWidget {
  PartsModel partModel;
  int pos;
  PartDetailsScren({@required this.partModel, @required this.pos});
  @override
  _PartDetailsScrenState createState() => _PartDetailsScrenState();
}

class _PartDetailsScrenState extends State<PartDetailsScren> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.partModel.details[widget.pos].partName),
      ),
    );
  }
}
