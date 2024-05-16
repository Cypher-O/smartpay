import '../utilities/imports/generalImport.dart';

class OnboardingViewModel extends BaseModel {
  final PageController pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  List<Widget> _pages = [];

  int get currentPage => _currentPage;
  List<Widget> get pages => _pages;

  goToNextPage(int i) {
    _currentPage = i;
    notifyListeners();
  }

  setPages(List<Widget> l) {
    _pages = l;
    notifyListeners();
  }
}