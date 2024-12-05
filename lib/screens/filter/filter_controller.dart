import 'package:superlabs_interview/superlabs_interview.dart';

class FilterController extends GetxController {
  FilterState filterState = FilterState();
  bool sortByAccordion = false;
  bool ratingAccordion = false;
  bool brandAccordion = false;
  List<bool> attributesAccordion = [];
  bool priceAccordion = false;
  SearchData? searchData;
  Duration animationDuration = 100.milliseconds;
  final TextEditingController brandTextController = TextEditingController();
  final TextEditingController minPriceController = TextEditingController();
  final TextEditingController maxPriceController = TextEditingController();

  List<PriceModel> get priceModelList {
    return [
      PriceModel(
        title: "Under ₹250",
        maxPrice: 250,
      ),
      PriceModel(
        title: "₹250 to ₹500",
        minPrice: 250,
        maxPrice: 500,
      ),
      PriceModel(
        title: "₹500 to ₹1000",
        minPrice: 500,
        maxPrice: 1000,
      ),
      PriceModel(
        title: "₹1000 and above",
        minPrice: 1000,
      ),
    ];
  }

  List<BrandElement> get filteredBrands {
    return searchData?.brands
            ?.where((e) => (e.name ?? '')
                .toLowerCase()
                .contains(brandTextController.text.toLowerCase()))
            .toList() ??
        [];
  }

  void init(
    FilterState state,
    SearchData? searchData,
  ) {
    filterState = state.copyWith();
    this.searchData = searchData;
    attributesAccordion = List.generate(
      searchData?.attributes?.length ?? 0,
      (index) => false,
    );
    brandTextController.clear();
    minPriceController.text = getPriceString(filterState.minPrice);
    maxPriceController.text = getPriceString(filterState.maxPrice);
  }

  void onSortByAccordionChange() {
    sortByAccordion = !sortByAccordion;
    update(['loader']);
  }

  void onRatingAccordionChange() {
    ratingAccordion = !ratingAccordion;
    update(['loader']);
  }

  void onBrandAccordionChange() {
    brandAccordion = !brandAccordion;
    update(['loader']);
  }

  void onPriceAccordionChange() {
    priceAccordion = !priceAccordion;
    update(['loader']);
  }

  void onAttributeAccordionChange(int index) {
    attributesAccordion[index] = !attributesAccordion[index];
    update(['loader']);
  }

  void onSortByChange(SortDataModel value) {
    filterState = filterState.copyWith(
      sortBy: value,
    );
    update(['loader']);
  }

  void onRatingChange(int? rating) {
    filterState = filterState.copyWith(
      rating: rating,
      ratingForceSet: true,
    );
    update(['loader']);
  }

  void onBrandTextFieldChange(String value) {
    update(['loader']);
  }

  void onBrandSelect(BrandElement brand) {
    final List<BrandElement> list = List.from(filterState.brands);
    if (list.contains(brand)) {
      list.remove(brand);
    } else {
      list.add(brand);
    }

    filterState = filterState.copyWith(
      brands: list,
    );
    update(['loader']);
  }

  void onAttributeSelect(Attribute attribute, SearchValue searchValue) {
    final List<Attribute> list = List.from(filterState.attributes);

    if (!list.any((e) => e.code == attribute.code)) {
      list.add(attribute.copyWith(
        values: [searchValue],
      ));
    } else {
      for (var model in list) {
        if(model.code == attribute.code){
          if (model.values?.contains(searchValue) ?? false) {
            model.values?.remove(searchValue);
          } else {
            model.values?.add(searchValue);
          }
        }
      }
    }

    filterState = filterState.copyWith(
      attributes: list,
    );
    update(['loader']);
  }

  bool isAttributeSelected(Attribute attribute, SearchValue searchValue) {
    final List<Attribute> list = List.from(filterState.attributes);

    for (var model in list) {
      if (model.values?.contains(searchValue) ?? false) {
        return true;
      }
    }
    return false;
  }

  void onPriceSelect(PriceModel? priceModel) {
    minPriceController.text = getPriceString(priceModel?.minPrice);
    maxPriceController.text = getPriceString(priceModel?.maxPrice);
    filterState = filterState.copyWith(
      minPrice: priceModel?.minPrice,
      maxPrice: priceModel?.maxPrice,
      minPriceForceSet: true,
      maxPriceForceSet: true,
    );
    update(['loader']);
  }

  void onMinPriceFieldChange(String value) {
    filterState = filterState.copyWith(
      minPrice: double.tryParse(value),
      minPriceForceSet: true,
    );
    update(['loader']);
  }

  void onMaxPriceFieldChange(String value) {
    filterState = filterState.copyWith(
      maxPrice: double.tryParse(value),
      maxPriceForceSet: true,
    );
    update(['loader']);
  }

  bool isPriceSelected(PriceModel model) {
    return filterState.minPrice == model.minPrice &&
        filterState.maxPrice == model.maxPrice;
  }

  void onClearAllTap() {
    init(FilterState(), searchData);
    update(['loader']);
  }

  void onShowResultTap() {
    Get.back(result: filterState);
  }
}
