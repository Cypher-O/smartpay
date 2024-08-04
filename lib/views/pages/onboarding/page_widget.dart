// import '../../../utilities/imports/generalImport.dart';

// class PageWidget extends StatelessWidget {
//   final String mainText;
//   final String subText;
//   final String image;
//   // final String decoration;
//   const PageWidget({
//     Key? key,
//     required this.mainText,
//     required this.subText,
//     required this.image,
//     // required this.decoration,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         S(h: ScreenSize(context: context).cH(height: 30)),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             // Your skip button goes here
//             TextButton(
//               onPressed: () {
//                 // Add your skip logic here
//               },
//               child: Text(
//                 'Skip',
//                 style: TextStyle(
//                   color: Colors.blue, // Change color to blue
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         S(h: ScreenSize(context: context).cH(height: 55)),
//         Stack(
//           children: [
//             Container(
//               height: ScreenSize(context: context).cH(height: 488),
//               decoration: BoxDecoration(
//                   image: DecorationImage(
//                       image: AssetImage(image), fit: BoxFit.contain),
//                   borderRadius: BorderRadius.circular(16)),
//             ),
//             // Positioned(
//             //     top: ScreenSize(context: context).cH(height: 170),
//             //     child: SvgPicture.asset(
//             //       decoration,
//             //       width: sS(context).w,
//             //     )),
//           ],
//         ),
//         S(h: 24),
//         Text(
//           mainText,
//           style: TextStyle(
//             color: AppColors.black(),
//             fontSize: 20,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         S(h: 10),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 50),
//           child: Text(
//             subText,
//             style: TextStyle(
//               color: AppColors.gray3(),
//               fontSize: 14,
//               fontWeight: FontWeight.w400,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ),
//         SizedBox(height: 15),
//       ],
//     );
//   }
// }

// import '../../../utilities/imports/generalImport.dart';

// class PageWidget extends StatelessWidget {
//   final String mainText;
//   final String subText;
//   final String image;

//   const PageWidget({
//     Key? key,
//     required this.mainText,
//     required this.subText,
//     required this.image,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         // Skip button
//         Positioned(
//           top: 0,
//           right: 0,
//           child: TextButton(
//             onPressed: () {
//               // Add your skip logic here
//             },
//             child: Text(
//               'Skip',
//               style: TextStyle(
//                 color: Colors.blue,
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ),
//         // Image container
//         Positioned(
//           top: 130, // Adjust this value to move the image down
//           left: 0,
//           right: 0,
//           child: Container(
//             height: ScreenSize(context: context)
//                 .cH(height: 350), // Adjust the height of the image container
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage(image),
//                 fit: BoxFit.cover,
//               ),
//               borderRadius: BorderRadius.circular(16),
//             ),
//           ),
//         ),
//         // Text containers
//         Positioned(
//           top: 550, // Adjust this value to position the text vertically
//           left: 20,
//           right: 20,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               GeneralTextDisplay(
//                 mainText,
//                 AppColors.black(),
//                 5,
//                 28,
//                 FontWeight.w700,
//                 "",
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 10),
//               GeneralTextDisplay(
//                 subText,
//                 AppColors.gray3(),
//                 3,
//                 16,
//                 FontWeight.w400,
//                 "",
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

import '../../../utilities/imports/generalImport.dart';

class PageWidget extends StatelessWidget {
  final String mainText;
  final String subText;
  final String image;
  final String? icon;

  const PageWidget({
    Key? key,
    required this.mainText,
    required this.subText,
    required this.image,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Column(
            children: [
              S(h: ScreenSize(context: context).cH(height: 100)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: InkWell(
                      onTap: () {
                        context.goNamed(loginRoute);
                      },
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              S(h: ScreenSize(context: context).cH(height: 40)),
              Stack(
                children: [
                  // Image container
                  Container(
                    height: ScreenSize(context: context).cH(height: 550),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(image),
                        fit: BoxFit.contain,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  // Left container with icon
                  Positioned(
                    top: 45,
                    left: 50,
                    child: Container(
                      decoration: BoxDecoration(
                        color: alterWhite,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: alterWhite,
                          width: 5,
                        ),
                      ),
                      padding: EdgeInsets.all(8),
                      child: Image.asset(
                        icon!,
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ),
                  // Container below the icon
                  Positioned(
                    top: 230,
                    left: 30,
                    child: Container(
                      decoration: BoxDecoration(
                        color: alterWhite,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Direct Deposit',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              GeneralTextDisplay(
                                'Suggested split',
                                AppColors.black(),
                                1,
                                9,
                                FontWeight.w400,
                                "",
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Today',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Right container
                  Positioned(
                    top: 160,
                    right: 30,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            "assets/images/bar_chart.png",
                            width: 120,
                            height: 120,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Text containers
                  Positioned(
                    top: 295,
                    left: 20,
                    right: 20,
                    child: Container(
                      color: AppColors.white(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          S(h: ScreenSize(context: context).cH(height: 30)),
                          GeneralTextDisplay(
                            mainText,
                            AppColors.black(),
                            2,
                            28,
                            FontWeight.w700,
                            "",
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 15),
                          GeneralTextDisplay(
                            subText,
                            AppColors.gray3(),
                            3,
                            15,
                            FontWeight.w400,
                            "",
                            textAlign: TextAlign.center,
                          ),
                          S(h: ScreenSize(context: context).cH(height: 30)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
