import '../../../utilities/imports/generalImport.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ThemeSettingsViewModel>.reactive(
      viewModelBuilder: () => ThemeSettingsViewModel(),
      onViewModelReady: (model) async {
        model.setTheme(context);
      },
      disposeViewModel: false,
      builder: (context, model, child) => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: FutureBuilder(
            future: Future.delayed(const Duration(seconds: 2)),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                WidgetsBinding.instance
                    .addPostFrameCallback((_) => context.goNamed(mainAppRoute));
              }
              return SafeArea(
                bottom: false,
                top: false,
                child: Scaffold(
                  body: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: AppColors.white(),
                    child: Image.asset("assets/pcash_logo_splash.png"),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
