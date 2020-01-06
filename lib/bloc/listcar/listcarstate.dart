import 'package:flutter/cupertino.dart';
import 'package:pickcar/models/motorcycle.dart';

class ListCarState {}

class ListCarStartState extends ListCarState {
  ListCarStartState();
}

class ListCarShowData extends ListCarState {
  List<Motorcycle> motorcyclelist;
  ListCarShowData({@required this.motorcyclelist});
}
