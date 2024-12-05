import 'package:superlabs_interview/screens/splash/splash_screen.dart';
import 'package:superlabs_interview/superlabs_interview.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Future.wait([
      PrefService.init(),
    ]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  } catch (e) {
    debugPrint(e.toString());
  }

  runApp(const MyApp());
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
String? redirectVideoUrl;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Constants.safeArea = MediaQuery.of(context).padding;
    return GestureDetector(
      onTap: () => hideKeyboard(context: context),
      child: OKToast(
        child: GetMaterialApp(
          title: 'Más Latino',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: const ColorScheme.light().copyWith(
              primary: ColorRes.primaryColor,
              secondary: ColorRes.secondaryColor,
            ),
            fontFamily: AssetRes.publicSans,
          ),
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(1.0)),
              child: child ?? const SizedBox(),
            );
          },
          navigatorKey: navigatorKey,
          locale:
              getLanStrToLocale(PrefService.getString(PrefKeys.localLanguage)),
          translations: AppLocalization(),
          fallbackLocale: const Locale('en', 'US'),
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
