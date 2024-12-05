import 'package:superlabs_interview/superlabs_interview.dart';

class AppLocalization extends Translations {
  @override
  Map<String, Map<String, String>> get keys {
    return {
      'en_US': enUs,
    };
  }

  Map<String, String> enUs = {
    "super_labs": "SuperLabs",
    "filters": "Filters",
    "sort_by": "Sort By",
    "rating": "Rating",
    "brand": "Brand",
    "price_range": "Price Range",
    "clear_all": "Clear All",
    "show_results": "Show Results",
  };
}
