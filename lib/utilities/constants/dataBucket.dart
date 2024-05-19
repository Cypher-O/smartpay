import '../../../../utilities/imports/generalImport.dart';
// list of stored data bucket

// general bucket
bool isBusyState = false;
bool isSuperBusyState = false;
bool firstTryCatchBucket = false;

//authentication bucket
String? secretQuoteString;
String? newUserEmailBucket;
String? userTokenBucket;
String? newUserEmailOtpBucket;
String? newUserDevice;
String? maskedEmail;
Countries? selectedCountry;
UserModel? userBucket;
UserData? userDetailsBucket;
String? newUserFullNameBucket;
String? newUserUserNameBucket;
String? newUserCountryBucket;
String? selectedCountryString;

// storing user model data
Timer? logoutTimer;

bool isDarkModeBucket = false;

// Check if the platform is iOS
bool isIOS = Platform.isIOS;

//background image
int currentBackgroundIndex = 0;
List<String> backgroundImageUrls = [
  'assets/images/main_bg.png',
  'assets/images/main_bg2.png',
  'assets/images/main_bg3.png',
  'assets/images/main_bg4.png',
];

//quotes background image
int currentImageIndex = 0;
List<String> mainContentImageUrls = [
  'assets/images/quotesBackground-1.png',
  'assets/images/quotesBackground-2.png',
  'assets/images/quotesBackground-3.png',
];

//author profile image
int currentAuthorIndex = 0;
List<String> authorImageUrls = [
  'assets/images/charles_bukowski.png',
  'assets/images/Isak_dinesen.png',
  'assets/images/kevin_ansbro.png',
  'assets/images/malika_nawal.png',
  'assets/images/ford_maddox.png',
  'assets/images/florence_nightingale.png',
  'assets/images/katharine_hepburn.png',
  'assets/images/nelson_mandela.png',
  'assets/images/oprah_winfrey.png',
  'assets/images/tim_cook.png',
];

//Api error messages
String? loginErrorMessage;
String? logoutErrorMessage;
String? registerErrorMessage;
String? sendOtpErrorMessage;
String? verifyOtpErrorMessage;
String? secretQuoteErrorMessage;
