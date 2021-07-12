import 'package:flutter/widgets.dart';

class ProviderData extends ChangeNotifier {
  int? _pageSet = 0;

  int? get pageSet => _pageSet;

  set pageSet(int? value) {
    _pageSet = value;
    notifyListeners();
  }
  bool? _cheakInternet;
  // ignore: unnecessary_getters_setters
  bool? get cheakInternet => _cheakInternet;

  // ignore: unnecessary_getters_setters
  set cheakInternet(bool? value)  {
    _cheakInternet = value;
  }
}
