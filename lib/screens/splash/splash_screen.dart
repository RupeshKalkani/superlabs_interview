import 'package:superlabs_interview/screens/splash/splash_controller.dart';
import 'package:superlabs_interview/superlabs_interview.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
      backgroundColor: ColorRes.bgColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "super_labs".tr,
              style: styleW500S35.copyWith(
                color: ColorRes.red,
              ),
            ),
          )
        ],
      ),
    );
  }
}
