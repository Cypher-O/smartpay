import '../../../utilities/imports/generalImport.dart';

class SuccessWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final Function? callback;
  final String? navigateTo;
  const SuccessWidget(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.buttonText,
      this.navigateTo,
      this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BaseModel>.reactive(
      viewModelBuilder: () => BaseModel(),
      onViewModelReady: (model) async {},
      disposeViewModel: false,
      builder: (context, model, child) => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          body: SafeArea(
            child: Container(
                width: double.infinity,
                height: double.infinity,
                padding:
                    EdgeInsets.symmetric(horizontal: sS(context).cW(width: 16)),
                color: AppColors.white(),
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 36,
                      backgroundColor: AppColors.darkGreen(),
                      child: Icon(Icons.check_rounded,
                          color: AppColors.white(), size: 48),
                    ),
                    S(h: 24),
                    GeneralTextDisplay(
                      title,
                      AppColors.black(),
                      2,
                      20,
                      FontWeight.w500,
                      '',
                      textAlign: TextAlign.center,
                    ),
                    S(h: 12),
                    GeneralTextDisplay(
                      subtitle,
                      AppColors.gray3(),
                      5,
                      14,
                      FontWeight.w400,
                      '',
                      textAlign: TextAlign.center,
                    ),
                    S(h: 30),
                    buttonNoPositioned(context,
                        text: buttonText,
                        navigateTo: navigateTo,
                        navigator: callback == null
                            ? null
                            : () {
                                callback!();
                              }),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
