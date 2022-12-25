import 'package:agriclaim/ui/constants/enums.dart';
import 'package:intl/intl.dart';

String convertPhoneToEmail(String phoneNumber) {
  return "$phoneNumber@gmail.com";
}

String convertEmailToPhone(String? email) {
  return email == null ? "" : email.split("@")[0];
}

String getClaimPageName(ClaimStates type) {
  String claimType;
  if (type == ClaimStates.inReview) {
    claimType = "In Review";
  } else {
    final temp = type.name;
    claimType = temp[0].toUpperCase() + temp.substring(1);
  }

  return "$claimType Claims";
}

String getCurrentDate() {
  DateTime now = DateTime.now();
  return DateFormat('dd-MM-yyyy').format(now);
}

String getClaimStatus(String type) {
  String claimType;
  if (type == ClaimStates.inReview.name) {
    claimType = "In Review";
  } else {
    final temp = type;
    claimType = temp[0].toUpperCase() + temp.substring(1);
  }

  return claimType;
}

Map<String, dynamic> getDifferenceOfTwoMaps(
    {required Map<String, dynamic> oldMap,
    required Map<String, dynamic> newMap}) {
  Map<String, dynamic> finalMap = {};
  newMap.forEach((key, value) {
    if (oldMap[key] != value) {
      finalMap[key] = value;
    }
  });

  return finalMap;
}
