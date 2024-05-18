import '../../../utilities/imports/generalImport.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AccountViewModel>.reactive(
        viewModelBuilder: () => AccountViewModel(),
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
                  pageTab(context, tabEnum: TabEnum.account),
                ])));
  }
}
