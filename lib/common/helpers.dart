import 'package:superlabs_interview/superlabs_interview.dart';
import 'package:superlabs_interview/superlabs_interview_extra.dart';

void showErrorMsg(String msg, {BuildContext? context}) {
  showCustomToast(msg, error: true);
  debugPrint("Error: $msg");
}

Future<void> showCatchToast(
    String msg, dynamic exception, StackTrace? stack) async {
  bool isInternetOn = false;
  try {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      isInternetOn = true;
      debugPrint('connected');
    }
  } on SocketException catch (_) {
    debugPrint('not connected');
  }
  String content = "";
  if (!isInternetOn) {
    content = "Check you Internet connection !";
  } else if (kDebugMode) {
    content = msg;
  } else {
    content = "Something went wrong !";
  }
  showCustomToast(content, error: true);
  debugPrint("Error: $msg");
}

void showSuccessToast(String msg) {
  showCustomToast(msg);
}

bool isEnglishSelected() {
  return (PrefService.getString(PrefKeys.localLanguage) == "English") ||
      (PrefService.getString(PrefKeys.localLanguage).isEmpty);
}
