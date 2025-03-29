import 'package:frappe_flutter_app/core/barrel_file.dart';

class CategoryProvider extends ChangeNotifier {
  final List<String> _selectedCategories = [];

  List<String> get selectedCategories => _selectedCategories;

  void toggleCategory(String category) {
    if (_selectedCategories.contains(category)) {
      _selectedCategories.remove(category);
    } else {
      _selectedCategories.add(category);
    }
    notifyListeners();
  }
}