import 'package:agriclaim/ui/constants/enums.dart';
import 'package:intl/intl.dart';

String convertPhoneToEmail(String phoneNumber) {
  return "$phoneNumber@gmail.com";
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
