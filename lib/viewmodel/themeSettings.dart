import '../../../utilities/imports/generalImport.dart';

class ThemeSettingsViewModel extends BaseModel {
  String _currentTheme = '';
  String get currentTheme => _currentTheme;

  void setTheme(BuildContext context) async {
    String currentThemeSettings =
        await LocalStorage.getString(currentThemeString) ?? lightThemeString;
    if (currentThemeSettings == systemThemeString) {
      final Brightness brightness = MediaQuery.of(context).platformBrightness;
      // Automatically set dark mode based on the device mode
      if (brightness == Brightness.dark) {
        isDarkModeBucket = true;
        notifyListeners();
      } else if (brightness == Brightness.light) {
        isDarkModeBucket = false;
        notifyListeners();
      }
    } else {
      if (currentThemeSettings == lightThemeString) {
        isDarkModeBucket = false;
        notifyListeners();
      } else if (currentThemeSettings == darkThemeString) {
        isDarkModeBucket = true;
        notifyListeners();
      }
    }
    debugPrint('isDarkMode is set to  ----${isDarkModeBucket}----');
  }

  getThemeSettings() async {
    _currentTheme =
        await LocalStorage.getString(currentThemeString) ?? lightThemeString;
    debugPrint('current theme is  --- ${_currentTheme}');
    notifyListeners();
  }

  ThemeData getCurrentTheme() {
    if (_currentTheme == lightThemeString) {
      return ThemeData.light().copyWith(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // primarySwatch: MaterialColor(0xFF0DA75E, primarySwatchColor),
      );
    } else {
      return ThemeData.dark().copyWith(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // primarySwatch: MaterialColor(0xFF0DA75E, primarySwatchColor),
      );
    }
  }

  void automaticThemeUpdate(Brightness brightness) async {
    String currentThemeSettings =
        await LocalStorage.getString(currentThemeString) ?? lightThemeString;
    debugPrint('system string is ${currentThemeSettings}');
    if (currentThemeSettings == systemThemeString) {
      // Automatically set dark mode based on the device mode
      if (brightness == Brightness.dark) {
        isDarkModeBucket = true;
      } else if (brightness == Brightness.light) {
        isDarkModeBucket = false;
      }
      debugPrint('dark mode automatically ${isDarkModeBucket}');
    }
    notifyListeners();
  }

  changeThemeFunction(BuildContext context, String value) {
    if (value == darkThemeString) {
      isDarkModeBucket = true;
    } else if (value == lightThemeString) {
      isDarkModeBucket = false;
    } else if (value == systemThemeString) {
      final Brightness brightness = MediaQuery.of(context).platformBrightness;
      if (brightness == Brightness.dark) {
        isDarkModeBucket = true;
      } else if (brightness == Brightness.light) {
        isDarkModeBucket = false;
      }
    }
    _currentTheme = value;
    notifyListeners();
    LocalStorage.setString(currentThemeString, value).then((value) {});
    debugPrint('currentTheme is now ------ ${_currentTheme} ------');
  }
}