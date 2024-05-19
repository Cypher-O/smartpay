import 'package:smartpay/utilities/imports/flutterImport.dart';

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

class ErrorDialog extends StatefulWidget {
  final String text;
  final IconData icon;
  final VoidCallback? onDismissed;

  ErrorDialog({required this.text, required this.icon, this.onDismissed});

  @override
  _ErrorDialogState createState() => _ErrorDialogState();
}

class _ErrorDialogState extends State<ErrorDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    BuildContext? context;

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _controller.forward();

    // Automatically dismiss after 3 seconds
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        _controller.reverse().then((_) {
          if (mounted) {
            // Navigator.pop(context!);
            widget.onDismissed!();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: SafeArea(
        child: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              color: AppColors.blue(),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: [
                Container(
                  width: 4.0, // Adjust the width of the vertical line
                  height: 48.0, // Adjust the height of the vertical line
                  color: Colors.red,
                ),
                Icon(widget.icon, color: Colors.white, size: 36.0),
                SizedBox(width: 16.0),
                Expanded(
                  child: Text(
                    widget.text,
                    style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void errorDialogWithClose(
  BuildContext context, {
  required String text,
  IconData? icon,
  String? buttonText,
  Function? onTap,
  Function? retry,
  String? title,
  Color? iconColor,
  bool removePage = true,
}) {
  SchedulerBinding.instance.addPostFrameCallback(
    (_) => showGeneralDialog(
      barrierColor: transparent,
      barrierDismissible: false,
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return Align(
          alignment: Alignment.topCenter,
          child: ErrorDialog(
            text: text,
            icon: icon ?? Icons.error_outline_sharp,
            onDismissed: () {
              if (onTap != null) {
                onTap(); // Trigger the onTap callback
              }

              Navigator.pop(context);
            },
          ),
        );
      },
      transitionBuilder: (context, animation1, animation2, child) {
        return FadeTransition(
          opacity: animation1,
          child: child,
        );
      },
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

