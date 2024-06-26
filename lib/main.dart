// import 'package:firebase_core/firebase_core.dart';

import 'utilities/imports/generalImport.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.remove();
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ViewModelBuilder<ThemeSettingsViewModel>.reactive(
        viewModelBuilder: () => ThemeSettingsViewModel(),
        onViewModelReady: (model) {},
        builder: (context, model, child) {
          return MaterialApp.router(
            title: 'Smartpay',
            debugShowCheckedModeBanner: false,
            routerConfig: router,
            theme: ThemeData(
              visualDensity: VisualDensity.adaptivePlatformDensity,
              primarySwatch: MaterialColor(0xFF0DA75E, primarySwatchColor),
            ),
          );
        });
  }
}
