// import 'package:smartpay/utilities/imports/generalImport.dart';

// class TabControllers extends StatefulWidget {
//   const TabControllers({Key? key}) : super(key: key);

//   @override
//   _TabControllersState createState() => _TabControllersState();
// }

// class _TabControllersState extends State<TabControllers> {
//   TabEnum _selectedTab = TabEnum.home;

//   void selectTab(TabEnum tab) {
//     setState(() {
//       _selectedTab = tab;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Pages
//           if (_selectedTab == TabEnum.home) Home(selectedTab: _selectedTab),
//           if (_selectedTab == TabEnum.account)
//             Account(selectedTab: _selectedTab),
//           // Add other pages here if needed
          
//           // Tab
//           pageTab(context, tabEnum: _selectedTab),
//         ],
//       ),
//     );
//   }
// }
