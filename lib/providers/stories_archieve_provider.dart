// Provider for managing Stories Archive View
import 'package:flutter/material.dart';

class StoriesArchiveProvider extends ChangeNotifier {
  StoriesArchiveViewType _currentView = StoriesArchiveViewType.posts;
  
  StoriesArchiveViewType get currentView => _currentView;
  
  void changeView(StoriesArchiveViewType newView) {
    _currentView = newView;
    notifyListeners();
  }
}

// Enum for view types
enum StoriesArchiveViewType {
  posts,
  calendar,
  location
}