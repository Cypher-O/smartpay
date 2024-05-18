import '../../../utilities/imports/generalImport.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
        onViewModelReady: (model) async {},
        disposeViewModel: false,
        builder: (context, model, child) => PopScope(
            canPop: true,
            child: BaseUi(
                // allowBackButton: false,
                refreshedEnabled: true,
                // safeTop: true,
                onRefreshFunction: () {},
                children: [
                  pageTab(context, tabEnum: TabEnum.home),
                ])));
  }
}
