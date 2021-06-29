import 'package:flutter/widgets.dart';

class ProviderData extends ChangeNotifier {
  Future<bool>? _ans;

  Future<bool>? get ans => _ans;

  set ans(Future<bool>? value) {
    _ans = value;
    notifyListeners();
  }

  int? _pageSet = 0;

  int? get pageSet => _pageSet;

  set pageSet(int? value) {
    _pageSet = value;
    notifyListeners();
  }
}
