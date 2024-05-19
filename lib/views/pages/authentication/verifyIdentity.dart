import '../../../utilities/imports/generalImport.dart';

class VerifyIdentity extends StatelessWidget {
  const VerifyIdentity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VerifyIdentityViewModel>.reactive(
      viewModelBuilder: () => VerifyIdentityViewModel(),
      onViewModelReady: (model) async {},
      disposeViewModel: false,
      builder: (context, model, child) => BaseUi(
        children: [
          backButton(context, navigateTo: forgotPasswordRoute),
          rowPositioned(
            top: 128,
            left: 30,
            right: 30,
            child: Stack(
              // alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: iconsContainer,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: iconsContainer,
                      width: 5,
                    ),
                  ),
                  padding: EdgeInsets.all(10.0),
                  child: Image.asset(
                    "assets/icons/verify_identity.png",
                    height: 40.0,
                    width: 40.0,
                  ),
                ),
                Positioned(
                  top: 60.0,
                  left: 57.0,
                  child: Image.asset(
                    "assets/icons/verify_identity_highlight.png",
                    height: 17.0,
                    width: 17.0,
                  ),
                ),
              ],
            ),
          ),
          rowPositioned(
            top: 240,
            left: 16,
            child: GeneralTextDisplay("Verify your identity", AppColors.black(),
                1, 20, FontWeight.w700, ""),
          ),
          rowPositioned(
            top: 280,
            left: 16,
            child: Container(
              width: sS(context).w - 30,
              child: Wrap(
                alignment: WrapAlignment.start,
                //  mainAxisSize: MainAxisSize.min,
                children: [
                  GeneralTextDisplay("Where would you like ", AppColors.gray3(),
                      1, 15, FontWeight.w400, ""),
                  GeneralTextDisplay(
                    "Smartpay ",
                    blueLight,
                    1,
                    15,
                    FontWeight.w800,
                    "",
                    decorationColor: blueLight,
                  ),
                  GeneralTextDisplay("to send your security code",
                      AppColors.gray3(), 1, 15, FontWeight.w400, ""),
                ],
              ),
            ),
          ),
          Positioned(
            top: sS(context).cH(height: 360),
            left: sS(context).cW(width: 16),
            bottom: sS(context).cH(height: 0),
            right: sS(context).cW(width: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: alterWhite,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle_rounded,
                          color: blueLight,
                          size: 24,
                        ),
                        SizedBox(width: 12.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GeneralTextDisplay(
                                'Email',
                                AppColors.black(),
                                1,
                                16,
                                FontWeight.bold,
                                "",
                              ),
                              SizedBox(height: 4),
                              GeneralTextDisplay(
                                'A*********@abc.com',
                                AppColors.gray2(),
                                1,
                                14,
                                FontWeight.w400,
                                "",
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.mail_outline_rounded,
                          color: AppColors.gray2(),
                          size: 24,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          rowPositioned(
            top: 730,
            child: ButtonWidget(
              () async {
                context.goNamed(createPasswordRoute);
              },
              AppColors.blue(),
              328,
              60,
              Text(
                "Continue",
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.white(),
                  fontWeight: FontWeight.w800,
                ),
              ),
              Alignment.center,
              20,
              noElevation: 0,
            ),
          ),
        ],
      ),
    );
  }
}
