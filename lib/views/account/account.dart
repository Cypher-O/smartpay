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
                  rowPositioned(
                    top: 54,
                    left: 16,
                    right: 16,
                    child: Expanded(
                      child: GeneralTextDisplay(
                        'Account',
                        AppColors.black(),
                        1,
                        22,
                        FontWeight.w500,
                        'Account',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Positioned(
                    top: sS(context).cH(height: 105),
                    left: 16,
                    right: 16,
                    bottom: sS(context).cH(height: 80),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // profile header
                          accountProfileWidget(
                            context: context,
                            fullname: newUserFullNameBucket,
                            profile: "assets/avatar/avatar_1.png",
                          ),
                          S(h: 24),

                          S(h: 16),
                          Row(
                            children: [
                              Expanded(
                                  child: logoutButton(
                                      context: context,
                                      callback: () {
                                        model.showLogoutConfirmationDialog(
                                            context);
                                      }))
                            ],
                          ),
                          S(h: 64),
                        ],
                      ),
                    ),
                  ),
                  pageTab(context, tabEnum: TabEnum.account),
                ])));
  }
}
