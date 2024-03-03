import 'package:flutter/material.dart';

class TagsProvider extends ChangeNotifier {
  List<String> _tags = [];

  List<String> get tags => _tags;

  void setTag(List<String> tag_list) {
    _tags = tag_list;
  }

  void addTag(String tag) {
    _tags.add(tag);
    notifyListeners();
  }

  void removeTag(int index) {
    _tags.removeAt(index);
    notifyListeners();
  }
}
