import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String _totalCupsKey = 'total_cups';
  static const String _goalCupsKey = 'goal_cups';

  final SharedPreferencesAsync _preferences = SharedPreferencesAsync();

  Future<int> getTotalCups() async {
    return await _preferences.getInt(_totalCupsKey) ?? 0;
  }

  Future<void> saveTotalCups(int value) async {
    await _preferences.setInt(_totalCupsKey, value);
  }

  Future<int> getGoalCups() async {
    return await _preferences.getInt(_goalCupsKey) ?? 8;
  }

  Future<void> saveGoalCups(int value) async {
    await _preferences.setInt(_goalCupsKey, value);
  }
}