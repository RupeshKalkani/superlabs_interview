import 'package:superlabs_interview/superlabs_interview.dart';

class ProductApi {
  static Future<SearchProductRes?> getSearchDataAPI({
    String? query,
    List<BrandElement> brands = const [],
    List<Attribute> attributes = const [],
    SortDataModel? sortBy,
    int? minRating,
    int currentPage = 1,
    int limit = 20,
    double? maxPrice,
    double? minPrice,
  }) async {
    try {
      Map<String, dynamic> attributeMap = {};
      for (var model in attributes) {
        if (model.values?.isNotEmpty ?? false) {
          attributeMap[model.code ?? ''] =
              model.values?.map((e) => e.value).toList() ?? [];
        }
      }

      final Map<String, dynamic> queryParams = {
        "q": query,
        "brands": brands.map((e) => e.handle ?? '').join(','),
        "attributes": attributeMap.isEmpty ? null : jsonEncode(attributeMap),
        "minPrice": minPrice?.toString(),
        "maxPrice": maxPrice?.toString(),
        "page": currentPage.toString(),
        "currentPage": currentPage.toString(),
        "limit": limit.toString(),
        "minRating": minRating?.toString(),
        "sortBy": sortBy?.code,
      };

      // Filter out null values to prevent unnecessary query parameters
      queryParams.removeWhere(
          (key, value) => value == null || value.toString().isEmpty);

      final response = await ApiService.getApi(
        url:
            '${EndPoints.searchProduct}?${Uri(queryParameters: queryParams).query}',
      );

      if (response != null && response.statusCode == 200) {
        return searchProductResFromJson(response.body);
      } else {
        showErrorMsg("Something went wrong in Search");
      }
    } catch (e, stack) {
      debugPrint(e.toString());
      showCatchToast(e.toString(), e, stack);
    }
    return null;
  }
}
