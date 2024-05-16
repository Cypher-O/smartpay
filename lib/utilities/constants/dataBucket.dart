import '../../../../utilities/imports/generalImport.dart';
// list of stored data bucket

// general bucket
bool isBusyState = false;
bool isSuperBusyState = false;
bool firstTryCatchBucket = false;

//authentication bucket
String? userTokenBucket;
String? newUserPhoneNumberBucket;
String? newUserEmailBucket;
String? newUserFirstNameBucket;
String? newUserLastNameBucket;
String? newUserAddressBucket;
String? newUserGenderBucket;
String? newUserNationalityBucket;
String? newUserStateBucket;
String? newUserCityBucket;
String? newUserDobBucket;
String? newUserNinBucket;
String? newUserImagePathBucket;
String? workEmailBucket;
String? newUserBvnBucket;
String? newUserPhoneBucket2;

// storing user model data
Timer? logoutTimer;

//Forgot password security data
String? securityphoneNumberBucket;
String? securityQuestionBucket;

//Notification bucket
IOWebSocketChannel?
    channelBucket; //=  IOWebSocketChannel.connect('ws://localhost:8080/ws');
bool socketConnected = false;
int punishmentNotificationActionId = 0;
List? groupsBucket;
List? otherGroupsBucket;

bool isDarkModeBucket = false;

// Check if the platform is iOS
bool isIOS = Platform.isIOS;
