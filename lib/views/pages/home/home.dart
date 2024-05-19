// import 'dart:ui';
// import '../../../utilities/imports/generalImport.dart';

// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder<HomeViewModel>.reactive(
//       viewModelBuilder: () => HomeViewModel(),
//       onViewModelReady: (model) async {
//         model.fetchSecretQuote(context);
//       },
//       disposeViewModel: false,
//       builder: (context, model, child) => PopScope(
//         canPop: true,
//         child: BaseUi(
//           refreshedEnabled: true,
//           onRefreshFunction: () {},
//           children: [
//             Stack(
//               fit: StackFit.expand,
//               children: [
//                 Center(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                     child: Container(
//                       width: 400,
//                       height: 210,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         image: DecorationImage(
//                           image: AssetImage(
//                               mainContentImageUrls[currentImageIndex]),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(20),
//                         child: Stack(
//                           children: [
//                             // Author Image aligned to the left with fade-out effect on the right 25%
//                             Positioned(
//                               left: 0,
//                               top: 0,
//                               bottom: 0,
//                               child: Container(
//                                 width: 100,
//                                 child: Stack(
//                                   children: [
//                                     Image.asset(
//                                       authorImageUrls[currentAuthorIndex],
//                                       fit: BoxFit.cover,
//                                       width: 200,
//                                       height: 230,
//                                     ),
//                                     Positioned.fill(
//                                       child: BackdropFilter(
//                                         filter: ImageFilter.blur(
//                                             sigmaX: 2.0, sigmaY: 1.0),
//                                         child: Container(
//                                           color: Colors.black.withOpacity(0),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             // Gradient fade effect on the right 25% of the author image
//                             Positioned(
//                               left: 80, // 75% of 200px
//                               top: 0,
//                               bottom: 0,
//                               right: 0,
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   gradient: LinearGradient(
//                                     begin: Alignment.centerLeft,
//                                     end: Alignment.centerRight,
//                                     colors: [
//                                       Colors.transparent,
//                                       Colors.black.withOpacity(0.5),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 // Text Stack
//                 Positioned.fill(
//                   child: Align(
//                     alignment: Alignment.center,
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 20.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: GeneralTextDisplay(
//                               secretQuoteString ?? '',
//                               AppColors.white(),
//                               5,
//                               24,
//                               FontWeight.bold,
//                               "",
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                           SizedBox(height: 20),
//                           // Row of icons (WhatsApp, download, share, recycle)
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               // WhatsApp icon
//                               Container(
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color: Colors.black.withOpacity(0.5),
//                                 ),
//                                 child: IconButton(
//                                   onPressed: () {
//                                     // Handle WhatsApp icon tap
//                                   },
//                                   icon: Icon(Icons.message),
//                                   color: AppColors.white(),
//                                 ),
//                               ),
//                               SizedBox(width: 20),
//                               // Download icon
//                               Container(
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color: Colors.black.withOpacity(0.5),
//                                 ),
//                                 child: IconButton(
//                                   onPressed: () {
//                                     // Handle download icon tap
//                                   },
//                                   icon: Icon(Icons.download),
//                                   color: AppColors.white(),
//                                 ),
//                               ),
//                               SizedBox(width: 20),
//                               // Share icon
//                               Container(
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color: Colors.black.withOpacity(0.5),
//                                 ),
//                                 child: IconButton(
//                                   onPressed: () {
//                                     // Handle share icon tap
//                                   },
//                                   icon: Icon(Icons.share),
//                                   color: AppColors.white(),
//                                 ),
//                               ),
//                               SizedBox(width: 20),
//                               // Recycle icon
//                               Container(
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color: Colors.black.withOpacity(0.5),
//                                 ),
//                                 child: IconButton(
//                                   onPressed: () {
//                                     setState(() {
//                                       // Perform regeneration here
//                                       currentImageIndex =
//                                           (currentImageIndex + 1) %
//                                               mainContentImageUrls.length;
//                                       currentAuthorIndex =
//                                           (currentAuthorIndex + 1) %
//                                               authorImageUrls.length;
//                                       model.fetchSecretQuote(context);
//                                     });
//                                   },
//                                   icon: Icon(Icons.refresh),
//                                   color: AppColors.white(),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 54,
//                   left: 0,
//                   right: 0,
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: sS(context).cW(width: hPadding)),
//                     child: GeneralTextDisplay(
//                       "Hi ${capitalize(newUserUserNameBucket ?? "")}",
//                       AppColors.black(),
//                       1,
//                       20,
//                       FontWeight.w500,
//                       "username",
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 20,
//                   left: 0,
//                   right: 0,
//                   child: pageTab(context, tabEnum: TabEnum.home),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:ui';
import '../../../utilities/imports/generalImport.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onViewModelReady: (model) async {
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          model.fetchSecretQuote(context, noLoading: true);
        });
        // Set the GlobalKey in the ViewModel
        model.globalKey = _globalKey;
      },
      disposeViewModel: false,
      builder: (context, model, child) => PopScope(
        canPop: true,
        child: BaseUi(
          refreshedEnabled: true,
          onRefreshFunction: () {},
          children: [
            RepaintBoundary(
              key: _globalKey,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Background image and content
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        width: 400,
                        height: 210,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: AssetImage(
                                mainContentImageUrls[currentImageIndex]),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Stack(
                            children: [
                              // Author Image aligned to the left with fade-out effect on the right 25%
                              Positioned(
                                left: 0,
                                top: 0,
                                bottom: 0,
                                child: Container(
                                  width: 100,
                                  child: Stack(
                                    children: [
                                      Image.asset(
                                        authorImageUrls[currentAuthorIndex],
                                        fit: BoxFit.cover,
                                        width: 200,
                                        height: 230,
                                      ),
                                      Positioned.fill(
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 2.0, sigmaY: 1.0),
                                          child: Container(
                                            color: Colors.black.withOpacity(0),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Gradient fade effect on the right 25% of the author image
                              Positioned(
                                left: 80, // 75% of 200px
                                top: 0,
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withOpacity(0.5),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Text Stack
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GeneralTextDisplay(
                                secretQuoteString ?? '',
                                AppColors.white(),
                                5,
                                20,
                                FontWeight.bold,
                                "",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: 20),
                            // Row of icons (WhatsApp, download, share, recycle)
                            Visibility(
                              visible: !model.captureEnabled,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Download icon
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        model.toggleCaptureEnabled();
                                        // model.captureAndSaveImage();
                                      },
                                      icon: Icon(Icons.download),
                                      color: AppColors.white(),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  // Share icon
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        model.shareUi();
                                      },
                                      icon: Icon(Icons.share),
                                      color: AppColors.white(),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  // Recycle icon
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          // Perform regeneration here
                                          currentImageIndex =
                                              (currentImageIndex + 1) %
                                                  mainContentImageUrls.length;
                                          currentAuthorIndex =
                                              (currentAuthorIndex + 1) %
                                                  authorImageUrls.length;
                                          model.fetchSecretQuote(context,
                                              noLoading: true);
                                        });
                                      },
                                      icon: Icon(Icons.refresh),
                                      color: AppColors.white(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Name
                  Positioned(
                    top: 54,
                    left: 0,
                    right: 0,
                    child: Visibility(
                      visible: !model.captureEnabled,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: sS(context).cW(width: hPadding)),
                        child: GeneralTextDisplay(
                          "Hi ${capitalize(newUserUserNameBucket ?? "")}",
                          AppColors.black(),
                          1,
                          20,
                          FontWeight.w500,
                          "username",
                        ),
                      ),
                    ),
                  ),
                  // Page tab
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Visibility(
                      visible: !model.captureEnabled,
                      child: pageTab(
                        context,
                        tabEnum: TabEnum.home,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
