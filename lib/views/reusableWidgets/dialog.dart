import '../../../utilities/imports/generalImport.dart';

Widget customDialog(child,
    {Alignment? align,
    double? x,
    double? y,
    Color? color,
    double? width,
    double? height}) {
  return WillPopScope(
    onWillPop: () async {
      return false;
    },
    child: Align(
      alignment: align ?? Alignment(x!, y!),
      // for y -1 to 1 (from top to bottom)
      // for x -1 to 1 (from left to right)
      child: S(
        h: height ?? 300,
        w: width ?? 300,
        child: Material(
          color: color ?? AppColors.white(),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: child),
        ),
      ),
    ),
  );
}

class CustomHexagonDialog extends StatelessWidget {
  final Widget child;
  final Alignment? align;
  final double? x;
  final double? y;
  final Color? color;
  final double? width;
  final double? height;

  const CustomHexagonDialog({
    Key? key,
    required this.child,
    this.align,
    this.x,
    this.y,
    this.color,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Align(
        alignment: align ?? Alignment(x ?? 0.0, y ?? 0.0),
        child: SizedBox(
          width: width ?? 300,
          height: height ?? 300,
          child: Transform.rotate(
            angle: pi / 2,
            child: Material(
              color: color ?? Colors.white,
              shape: HexagonBorder(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HexagonBorder extends ShapeBorder {
  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return getOuterPath(rect, textDirection: textDirection);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    double width = rect.width;
    double height = rect.height;

    double centerX = width / 2;
    double centerY = height / 2;

    double radius = min(width / 2, height / 2);

    final Path path = Path();
    path.moveTo(centerX + radius * cos(0), centerY + radius * sin(0));
    for (double i = 1; i <= 6; i++) {
      path.lineTo(centerX + radius * cos(2 * pi * i / 6),
          centerY + radius * sin(2 * pi * i / 6));
    }
    path.close();

    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) {
    return this;
  }
}

loadingDialog(BuildContext context,
    {required String text,
    Color? color,
    Function? onWillPop,
    int? height,
    int? width}) async {
  return SchedulerBinding.instance.addPostFrameCallback(
    (_) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ViewModelBuilder.reactive(
        viewModelBuilder: () => BaseModel(),
        onViewModelReady: (model) async {},
        disposeViewModel: false,
        builder: (context, model, child) => PopScope(
          canPop: false,
          child: Center(
            child: CustomHexagonDialog(
              child: AnimatedHourglass(),
              height: 70,
              width: 70,
              color: color ?? AppColors.white(),
            ),
          ),
        ),
      ),
    ),
  );
}

loadingNoScheduleDialog(BuildContext context,
    {required String text, Color? color, required Function? onWillPop}) async {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ViewModelBuilder<BaseModel>.reactive(
            viewModelBuilder: () => BaseModel(),
            onViewModelReady: (model) async {},
            disposeViewModel: false,
            builder: (context, model, child) => WillPopScope(
              onWillPop: () async {
                if (onWillPop == null) {
                  return true;
                } else {
                  return onWillPop();
                }
              },
              child: Center(
                child: customDialog(Center(child: loading()),
                    align: Alignment.center, height: 150, width: 150),
              ),
            ),
          ));
}

// dialog with close
loaderWithClose(
  BuildContext context, {
  required String text,
  String? buttonText,
  IconData? icon,
  Function? onTap,
  Function? retry,
  String? title,
  Color? iconColor,
  bool removePage = true,
}) {
  return SchedulerBinding.instance.addPostFrameCallback(
    (_) => showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Center(
        child: Container(
          child: customDialog(
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: sS(context).cH(height: 28),
                    backgroundColor: iconColor ?? AppColors.red(),
                    child: GeneralIconDisplay(icon ?? Icons.close_rounded,
                        AppColors.white(), UniqueKey(), 30),
                  ),
                  S(h: 16),
                  GeneralTextDisplay(
                    title == null ? "An error occured" : title,
                    AppColors.black(),
                    1,
                    20,
                    FontWeight.w500,
                    "",
                    textAlign: TextAlign.center,
                  ),
                  S(h: 8),
                  GeneralTextDisplay(
                    text,
                    AppColors.gray3(),
                    4,
                    14,
                    FontWeight.w500,
                    "",
                    textAlign: TextAlign.center,
                  ),
                  S(h: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (retry != null) const Spacer(),
                      // retry
                      if (retry != null)
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            retry();
                          },
                          child: GeneralTextDisplay(
                            buttonText ?? "Retry",
                            AppColors.green().withOpacity(0.6),
                            1,
                            14.5,
                            FontWeight.w500,
                            "retry",
                          ),
                        ),
                      if (retry != null) const Spacer(),
                    ],
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ButtonWidget(
                            () {
                              onTap == null
                                  ? {
                                      Navigator.pop(context),
                                      //if (retry != null)
                                      if (removePage) {Navigator.pop(context)}
                                    }
                                  : onTap();
                            },
                            AppColors.gray6(),
                            20,
                            48,
                            GeneralTextDisplay('Close', AppColors.gray3(), 1,
                                14, FontWeight.w500, 'Close'),
                            Alignment.center,
                            8,
                            noElevation: 0,
                            borderColor: AppColors.white(),
                          ),
                        )
                      ])
                ],
              ),
              align: Alignment.center),
        ),
      ),
    ),
  );
}

showAlertDialog(BuildContext context,
    {required ValueNotifier<double> progressNotifier,
    Function? cancelTap,
    Function? acceptTap,
    String? acceptText,
    String? cancelText}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => Center(
      child: Container(
        child: customDialog(
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'Downloading Update',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ValueListenableBuilder<double>(
                valueListenable: progressNotifier,
                builder: (context, progress, child) {
                  return LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey[200],
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AppColors.green()),
                  );
                },
              ),
              SizedBox(height: 16),
              ValueListenableBuilder<double>(
                valueListenable: progressNotifier,
                builder: (context, progress, child) {
                  return Text(
                    '${(progress * 100).toStringAsFixed(0)}%',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  );
                },
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Please wait...',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  S(w: 5),
                  Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.green()),
                    child: AnimatedHourglass(),
                  ),
                ],
              ),
            ],
          ),
          align: Alignment.center,
        ),
      ),
    ),
  );
}

// loader with info
loaderWithInfo(
  BuildContext context, {
  required String text,
  required String title,
  IconData? icon,
  required Function onTap,
  Function? cancelTap,
  required String? cancelText,
  required String acceptText,
  Color? acceptColor,
  Color? iconColor,
  bool removePage = true,
}) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => Center(
      child: Container(
        child: customDialog(
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                GeneralIconDisplay(icon ?? Icons.info_outline,
                    iconColor ?? AppColors.darkGreen(), UniqueKey(), 50),
                S(h: 16),
                GeneralTextDisplay(
                  title,
                  AppColors.black(),
                  1,
                  20,
                  FontWeight.w500,
                  title,
                  textAlign: TextAlign.center,
                ),
                S(h: 12),
                GeneralTextDisplay(
                  text,
                  AppColors.gray3(),
                  4,
                  14,
                  FontWeight.w400,
                  text,
                  textAlign: TextAlign.center,
                ),
                S(h: 16),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ButtonWidget(
                          // cancelTap ??
                          //     () {
                          //       Navigator.pop(context);
                          //     },
                          () {
                            cancelTap == null
                                ? {
                                    Navigator.pop(context),
                                    //if (retry != null)
                                    if (removePage) {Navigator.pop(context)}
                                  }
                                : cancelTap();
                          },
                          AppColors.gray6(),
                          20,
                          48,
                          GeneralTextDisplay(
                              cancelText ?? 'Cancel',
                              AppColors.gray2(),
                              1,
                              14,
                              FontWeight.w500,
                              'Close'),
                          Alignment.center,
                          8,
                          noElevation: 0,
                          borderColor: AppColors.white(),
                        ),
                      ),
                      S(w: 16),
                      Expanded(
                        child: ButtonWidget(
                          () {
                            onTap();
                          },
                          acceptColor ?? AppColors.green(),
                          20,
                          48,
                          GeneralTextDisplay(acceptText, AppColors.white(), 1,
                              14, FontWeight.w500, 'accept'),
                          Alignment.center,
                          8,
                          noElevation: 0,
                          borderColor: AppColors.white(),
                        ),
                      )
                    ]),
              ],
            ),
            align: Alignment.center),
      ),
    ),
  );
}

//Compulsory Download Dialog
loaderWithCompulsoryDownload(
  BuildContext context, {
  required String text,
  required String title,
  IconData? icon,
  required Function onTap,
  required String acceptText,
  Color? acceptColor,
  Color? iconColor,
  bool removePage = true,
}) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => Center(
      child: Container(
        child: customDialog(
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                GeneralIconDisplay(icon ?? Icons.info_outline,
                    iconColor ?? AppColors.darkGreen(), UniqueKey(), 50),
                S(h: 16),
                GeneralTextDisplay(
                  title,
                  AppColors.black(),
                  1,
                  20,
                  FontWeight.w500,
                  title,
                  textAlign: TextAlign.center,
                ),
                S(h: 12),
                GeneralTextDisplay(
                  text,
                  AppColors.gray3(),
                  4,
                  14,
                  FontWeight.w400,
                  text,
                  textAlign: TextAlign.center,
                ),
                S(h: 20),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Expanded(
                    child: ButtonWidget(
                      () {
                        onTap();
                      },
                      acceptColor ?? AppColors.green(),
                      20,
                      48,
                      GeneralTextDisplay(acceptText, AppColors.white(), 1, 14,
                          FontWeight.w500, 'accept'),
                      Alignment.center,
                      8,
                      noElevation: 0,
                      borderColor: AppColors.white(),
                    ),
                  )
                ]),
              ],
            ),
            align: Alignment.center),
      ),
    ),
  );
}
