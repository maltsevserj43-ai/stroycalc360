import 'dart:io';

class Database {
  final String _filePath = 'app/data/calculation_data.txt';

  Future<void> save(String calculation) async {
    try {
      File file = File(_filePath);
      await file.writeAsString(calculation);
      print('Calculation saved successfully');
    } catch (e) {
      print('Error saving calculation: $e');
    }
  }

  Future<String?> load() async {
    try {
      File file = File(_filePath);
      String? content = await file.readAsString();
      return content;
    } catch (e) {
      print('Error loading calculation: $e');
      return null;
    }
  }
}
