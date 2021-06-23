import 'package:flutter/widgets.dart';

class ProviderData extends ChangeNotifier {
  Future<bool>? _ans;

  Future<bool>? get ans => _ans;

  set ans(Future<bool>? value) {
    _ans = value;
    notifyListeners();
  }

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
