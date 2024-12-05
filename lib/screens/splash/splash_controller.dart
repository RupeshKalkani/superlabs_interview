import 'package:superlabs_interview/screens/search/search_product_screen.dart';
import 'package:superlabs_interview/superlabs_interview.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    navigatePage();
    super.onInit();
  }

  Future<void> navigatePage() async {
    await Future.delayed(2.seconds);
    Get.off(
      () => const SearchProductScreen(),
      transition: Transition.rightToLeftWithFade,
      duration: 500.milliseconds,
    );
  }
}
