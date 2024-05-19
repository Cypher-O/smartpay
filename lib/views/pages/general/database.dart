
import 'package:smartpay/utilities/imports/generalImport.dart';

class DatabaseMethods{
  Future addUser(String userId, Map<String, dynamic> userInfoMap){

    return FirebaseFirestore. instance.collection("User").doc(userId).set(userInfoMap);
  }
}