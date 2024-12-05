import 'package:superlabs_interview/superlabs_interview.dart';

List<SortDataModel> get sortDataList {
  return [
    SortDataModel(
      text: "Relevance",
      code: "relevance",
    ),
    SortDataModel(
      text: "Best Selling",
      code: "best-selling",
    ),
    SortDataModel(
      text: "Top Rated",
      code: "top-rated",
    ),
    SortDataModel(
      text: "Price: Low to High",
      code: "price-asc",
    ),
    SortDataModel(
      text: "Price: High to Low",
      code: "price-desc",
    ),
    SortDataModel(
      text: "New",
      code: "new",
    ),
  ];
}

class FilterState {
  final double? minPrice;
  final double? maxPrice;
  final int? rating;
  final List<BrandElement> brands;
  final List<Attribute> attributes;
  final SortDataModel? sortBy;

  FilterState({
    this.minPrice,
    this.maxPrice,
    this.rating,
    this.brands = const [],
    this.attributes = const [],
    SortDataModel? sortBy,
  }) : sortBy = sortBy ?? sortDataList.first;

  FilterState copyWith({
    double? minPrice,
    double? maxPrice,
    int? rating,
    List<BrandElement>? brands,
    List<Attribute>? attributes,
    SortDataModel? sortBy,
    bool minPriceForceSet = false,
    bool maxPriceForceSet = false,
    bool ratingForceSet = false,
  }) {
    return FilterState(
      minPrice: minPriceForceSet ? minPrice : minPrice ?? this.minPrice,
      maxPrice: maxPriceForceSet ? maxPrice : maxPrice ?? this.maxPrice,
      rating: ratingForceSet ? rating : rating ?? this.rating,
      brands: brands ?? this.brands,
      attributes: attributes ?? this.attributes,
      sortBy: sortBy ?? this.sortBy,
    );
  }
}
