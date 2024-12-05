class PriceModel {
  String title;
  double? minPrice;
  double? maxPrice;

  PriceModel({
    this.title = '',
    this.minPrice,
    this.maxPrice,
  });

  PriceModel copyWith({
    String? title,
    double? minPrice,
    double? maxPrice,
  }) {
    return PriceModel(
      title: title ?? this.title,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
    );
  }
}
