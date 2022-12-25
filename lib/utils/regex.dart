final RegExp lettersOnlyRegExp = RegExp(r'[a-zA-Z]+$');

bool lettersOnly(String text) {
  if (lettersOnlyRegExp.hasMatch(text)) {
    return true;
  }
  return false;
}
