import '../superlabs_interview.dart';

Locale getLanStrToLocale(String lan) {
  if (lan.isEmpty) {
    return const Locale("en", "US");
  }
  String lanCode = lan.split('_').first;
  String countryCode = lan.split('_').last;
  return Locale(lanCode, countryCode);
}

String getLanLocaleToStr(Locale locale) {
  return "${locale.languageCode}_${locale.countryCode}";
}

Future<void> loadImage(ImageProvider provider) {
  final config = ImageConfiguration(
    bundle: rootBundle,
    devicePixelRatio: 1,
    platform: defaultTargetPlatform,
  );
  final Completer<void> completer = Completer();
  final ImageStream stream = provider.resolve(config);

  late final ImageStreamListener listener;

  listener = ImageStreamListener((ImageInfo image, bool sync) {
    debugPrint("Image ${image.debugLabel} finished loading");
    completer.complete();
    stream.removeListener(listener);
  }, onError: (dynamic exception, StackTrace? stackTrace) {
    completer.complete();
    stream.removeListener(listener);
    FlutterError.reportError(FlutterErrorDetails(
      context: ErrorDescription('image failed to load'),
      library: 'image resource service',
      exception: exception,
      stack: stackTrace,
      silent: true,
    ));
  });

  stream.addListener(listener);
  return completer.future;
}

Future<void> loadSvgImage(String image) async {
  final loader = SvgAssetLoader(image);
  svg.cache.putIfAbsent(loader.cacheKey(null), () => loader.loadBytes(null));
}

void hideKeyboard({BuildContext? context}) {
  context ??= navigatorKey.currentContext;
  if (context == null) {
    return;
  }
  if (FocusScope.of(context).hasFocus) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}

String getPriceString(double? amount, {int fixedDecimal = 2}) {
  if (amount == null) return "";
  try {
    final intData = int.tryParse(amount.toString().split(".").last);
    if (intData == 0) {
      return int.tryParse(amount.toString().split(".").first).toString();
    }

    return amount.toStringAsFixed(fixedDecimal);
  } catch (e) {
    debugPrint(e.toString());
  }
  return "";
}
