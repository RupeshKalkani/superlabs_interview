import 'package:http/http.dart' as http;
import 'package:superlabs_interview/superlabs_interview.dart';
import 'package:superlabs_interview/superlabs_interview_extra.dart';

class ApiService {
  static Future<http.Response?> getApi({
    required String url,
    Map<String, String>? header,
  }) async {
    try {
      header = header ?? appHeader();
      debugPrint("Url = $url");
      debugPrint("Header = $header");
      final response = await http.get(Uri.parse(url), headers: header);
      bool isExpired = await isTokenExpire(response);
      if (!isExpired) {
        return response;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  static Future<http.Response?> postApi({
    required String url,
    Map<String, String>? header,
    dynamic body,
  }) async {
    try {
      header = header ?? appHeader();
      header.addAll({
        "Content-Type": "application/json",
      });
      debugPrint("Url = $url");
      debugPrint("Header = $header");
      debugPrint("Body = $body");

      if (body is Map) {
        body = jsonEncode(body);
      }
      final response = await http.post(
        Uri.parse(url),
        headers: header,
        body: body,
      );
      bool isExpired = await isTokenExpire(response);
      if (!isExpired) {
        return response;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  static Future<http.Response?> putApi({
    required String url,
    Map<String, String>? header,
    dynamic body,
  }) async {
    try {
      header = header ?? appHeader();
      header.addAll({
        "Content-Type": "application/json",
      });
      debugPrint("Url = $url");
      debugPrint("Header = $header");
      debugPrint("Body = $body");

      if (body is Map) {
        body = jsonEncode(body);
      }
      final response =
          await http.put(Uri.parse(url), headers: header, body: body);
      bool isExpired = await isTokenExpire(response);
      if (!isExpired) {
        return response;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  static Future<http.Response?> deleteApi({
    required String url,
    Map<String, String>? header,
    dynamic body,
  }) async {
    try {
      header = header ?? appHeader();
      header.addAll({
        "Content-Type": "application/json",
      });
      debugPrint("Url = $url");
      debugPrint("Header = $header");
      debugPrint("Body = $body");

      if (body is Map) {
        body = jsonEncode(body);
      }
      final response =
          await http.delete(Uri.parse(url), headers: header, body: body);
      bool isExpired = await isTokenExpire(response);
      if (!isExpired) {
        return response;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  static Future<http.Response?> uploadFileWithDataApi({
    required String url,
    String type = "POST",
    Map<String, String>? header,
    Map<String, String>? body,
    List<FileDataModel> fileData = const [],
  }) async {
    header ??= {};
    body ??= {};
    header.addAll(appHeader());
    debugPrint("Url = $url");
    debugPrint("Header = $header");
    debugPrint("Body = $body");
    debugPrint("fileData = $fileData");
    try {
      var request = http.MultipartRequest(type, Uri.parse(url));
      request.fields.addAll(body);
      request.headers.addAll(header);
      for (FileDataModel element in fileData) {
        if (element.filePath == null || element.keyName == null) {
          continue;
        }
        request.files.add(
          http.MultipartFile(
            element.keyName ?? '',
            File(element.filePath!).readAsBytes().asStream(),
            File(element.filePath!).lengthSync(),
          ),
        );
      }

      final http.StreamedResponse streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse)
          .timeout(const Duration(seconds: 120));
      bool isExpired = await isTokenExpire(response);
      if (!isExpired) {
        return response;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  static Map<String, String> appHeader() {
    if (PrefService.getString(PrefKeys.accessToken).isEmpty) {
      return {};
    } else {
      return {
        "Authorization":
            "${PrefService.getString(PrefKeys.tokenType)} ${PrefService.getString(PrefKeys.accessToken)}",
      };
    }
  }

  static Future<bool> isTokenExpire(http.Response response) async {
    if (response.statusCode == 401) {
      // logoutUser();
      // Get.offAll(() => const LoginScreen());
      return true;
    } else {
      return false;
    }
  }
}
