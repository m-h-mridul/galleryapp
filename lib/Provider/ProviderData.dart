import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';

class ProviderData extends ChangeNotifier {
  List<dynamic>? _albumData;

  List<dynamic>? get albumData => _albumData;

  set albumData(List<dynamic>? value) {
    _albumData = value;
    notifyListeners();
  }

  List<dynamic>? _imageData;
  int? _pageSet = 0;

  int? get pageSet => _pageSet;

  set pageSet(int? value) {
    _pageSet = value;
    notifyListeners();
  }

  List<dynamic>? get imageData => _imageData;

  set imageData(List<dynamic>? value) {
    _imageData = value;
    notifyListeners();
  }

}
