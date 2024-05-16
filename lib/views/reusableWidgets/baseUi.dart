import '../../../utilities/imports/generalImport.dart';

class BaseUi extends StatelessWidget {
  final List<Widget> children;
  final FloatingActionButton? floatingActionButton;
  final AppBar? appBar;
  final bool? allowBackButton;
  final bool? safeTop;
  final Function? onRefreshFunction;
  final bool refreshedEnabled;
  final bool? resizeToAvoidBottomInset;

  const BaseUi(
      {Key? key,
      this.allowBackButton,
      required this.children,
      this.floatingActionButton,
      this.appBar,
      this.safeTop,
      this.refreshedEnabled = true,
      this.resizeToAvoidBottomInset = true,
      this.onRefreshFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return ViewModelBuilder<BaseModel>.reactive(
        viewModelBuilder: () => BaseModel(),
        onViewModelReady: (model) async {
        },
        onDispose: (model) {},
        disposeViewModel: false,
        builder: (context, model, child) {
          return WillPopScope(
              onWillPop: () async {
                return allowBackButton ?? true;
              },
              child: !refreshedEnabled
                  ? Scaffold(
                      appBar: appBar,
                      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
                      body: SafeArea(
                        top: safeTop ?? false,
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: AppColors.white(),
                          child: Stack(children: [
                            ...children,
                            isBusyState
                                ? Container(
                                    height: sS(context).h,
                                    width: sS(context).w,
                                    color: AppColors.black().withOpacity(0.5),
                                    child: Center(
                                      child: customDialog(
                                        Center(child: loading()),
                                        align: Alignment.center,
                                        height: 150,
                                        width: 150,
                                      ), //CircularProgressIndicator(),
                                    ))
                                : Container()
                          ]),
                        ),
                      ),
                      floatingActionButton: floatingActionButton,
                    )
                  : RefreshIndicator(
                      displacement: 100,
                      backgroundColor: AppColors.green(),
                      color: AppColors.white(),
                      strokeWidth: 3,
                      triggerMode: RefreshIndicatorTriggerMode.onEdge,
                      onRefresh: () async {
                        if (onRefreshFunction != null) {
                          return onRefreshFunction!();
                        }
                      },
                      child: Scaffold(
                        appBar: appBar,
                        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
                        body: SafeArea(
                          bottom: false,
                          top: safeTop ?? false,
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: AppColors.white(),
                            child: Stack(
                              children: [
                                ...children,
                                isBusyState
                                    ? Container(
                                        height: sS(context).h,
                                        width: sS(context).w,
                                        color:
                                            AppColors.black().withOpacity(0.5),
                                        child: Center(
                                          child: customDialog(
                                            Center(child: loading()),
                                            align: Alignment.center,
                                            height: 150,
                                            width: 150,
                                          ), //CircularProgressIndicator(),
                                        ))
                                    : Container()
                              ],
                            ),
                          ),
                        ),
                        floatingActionButton: floatingActionButton,
                      ),
                    ));
        });
  }
}
