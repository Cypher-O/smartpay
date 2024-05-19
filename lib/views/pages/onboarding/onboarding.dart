import '../../../utilities/imports/generalImport.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OnboardingViewModel>.reactive(
      viewModelBuilder: () => OnboardingViewModel(),
      onViewModelReady: (model) async {
        List<Widget> _pages = [
          const PageWidget(
            mainText: 'Finance app the safest and most trusted',
            subText:
                'Your finance work starts here. We are here to help you track and deal with speeding up your transactions.',
            image: 'assets/onboarding_device1.png',
            icon: 'assets/images/privacy_lock.png',
          ),
          const PageWidget(
            mainText: 'The fastest transaction process only here',
            subText:
                'Get easy to pay all your bills with just a few steps. Paying your bills become fast and efficient.',
            image: 'assets/onboarding_device2.png',
            icon: 'assets/images/privacy_lock.png',
          ),
        ];
        model.setPages(_pages);
      },
      disposeViewModel: false,
      builder: (context, model, child) => PopScope(
        canPop: false,
        child: BaseUi(
            refreshedEnabled: false,
            resizeToAvoidBottomInset: false,
            children: [
              PageView.builder(
                controller: model.pageController,
                onPageChanged: (int index) {
                  model.goToNextPage(index);
                },
                itemCount: model.pages.length,
                itemBuilder: (BuildContext context, int index) {
                  return model.pages[index];
                },
              ),
              S(h: ScreenSize(context: context).cH(height: 400)),
              rowPositioned(
                  top: 700,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List<Widget>.generate(
                      model.pages.length,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: InkWell(
                          onTap: () {
                            model.pageController.animateToPage(index,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn);
                          },
                          child: model.currentPage == index
                              ? Container(
                                  width: 24,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(32.0),
                                    color: AppColors.blueDark,
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 4,
                                  backgroundColor: AppColors.gray5()),

                          // child: model.currentPage == index
                          //     ? CircleAvatar(
                          //         radius: 6,
                          //         backgroundColor: AppColors.blueDark)
                          //     : CircleAvatar(
                          //         radius: 4,
                          //         backgroundColor: AppColors.gray5()),
                        ),
                      ),
                    ),
                  )),
              rowPositioned(
                top: 740,
                child: ButtonWidget(
                  () async {
                    context.goNamed(loginRoute);
                  },
                  AppColors.blue(),
                  328,
                  60,
                  Text(
                    "Get Started",
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.white(),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Alignment.center,
                  20,
                  noElevation: 0,
                ),
              ),
            ]),
      ),
    );
  }
}
