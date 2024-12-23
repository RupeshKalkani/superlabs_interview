import 'package:superlabs_interview/apis/product_api.dart';
import 'package:superlabs_interview/screens/filter/filter_dialog.dart';
import 'package:superlabs_interview/superlabs_interview.dart';

class SearchProductController extends GetxController {
  bool loader = false;
  bool paginationLoader = false;
  final TextEditingController searchFieldController = TextEditingController();
  FilterState filterState = FilterState();
  int currentPage = 1;
  bool isApiCalling = false;
  Timer? timer;
  SearchProductRes? searchProductRes;
  bool backToTopBtnVisible = false;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    getSearchData(
      resetData: true,
      fromOnInit: true,
    );
    scrollController.addListener(() {
      onScrollPositionChange();
    });
    super.onInit();
  }

  void onScrollPositionChange() {
    try {
      bool flag = backToTopBtnVisible;
      backToTopBtnVisible = (scrollController.position.pixels > 300.ww);
      if (flag != backToTopBtnVisible) {
        update(['loader']);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void onClearQueryTap() {
    searchFieldController.clear();
    onSearchChange();
  }

  void onSearchChange() {
    timer?.cancel();
    timer = Timer(
      300.milliseconds,
      () {
        getSearchData(resetData: true);
      },
    );
  }

  Future<void> onFilterBtnTap() async {
    final state = await openFilterDialog(
      filterState,
      searchProductRes?.data,
    );
    if (state != null) {
      filterState = state;
      getSearchData(resetData: true);
    }
  }

  Future<void> getSearchData({
    bool resetData = false,
    bool fromOnInit = false,
  }) async {
    try {
      if (resetData) {
        loader = true;
        if (!fromOnInit) {
          onBackToTopTap();
        }
        searchProductRes = searchProductRes?.copyWith(
          data: searchProductRes?.data?.copyWith(
            products: [],
          ),
        );
        update(['loader']);
        currentPage = 1;
        isApiCalling = false;
      } else {
        paginationLoader = true;
        update(['loader']);
      }
      if (isApiCalling) return;
      isApiCalling = true;
      final model = await ProductApi.getSearchDataAPI(
        query: searchFieldController.text,
        currentPage: currentPage,
        limit: 20,
        maxPrice: filterState.maxPrice,
        minPrice: filterState.minPrice,
        attributes: filterState.attributes,
        brands: filterState.brands,
        minRating: filterState.rating,
        sortBy: filterState.sortBy,
      );
      if (model != null) {
        if (resetData || searchProductRes == null) {
          searchProductRes = model.copyWith();
        } else {
          final List<Product> oldList =
              List.from(searchProductRes?.data?.products ?? []);
          searchProductRes = searchProductRes?.copyWith(
            data: searchProductRes?.data?.copyWith(
              products: oldList + (model.data?.products ?? []),
            ),
          );
        }
        currentPage++;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    isApiCalling = false;
    loader = false;
    paginationLoader = false;
    update(['loader']);
  }

  void onRatingChange(int? rating) {
    filterState = filterState.copyWith(
      rating: rating,
      ratingForceSet: true,
    );
    getSearchData(resetData: true);
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
    getSearchData(resetData: true);
  }

  void onAttributeSelect(Attribute attribute, SearchValue searchValue) {
    final List<Attribute> list = List.from(filterState.attributes);

    if (!list.any((e) => e.code == attribute.code)) {
      list.add(attribute.copyWith(
        values: [searchValue],
      ));
    } else {
      for (var model in list) {
        if (model.code == attribute.code) {
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
    getSearchData(resetData: true);
  }

  void onPriceSelect(PriceModel? priceModel) {
    filterState = filterState.copyWith(
      minPrice: priceModel?.minPrice,
      maxPrice: priceModel?.maxPrice,
      minPriceForceSet: true,
      maxPriceForceSet: true,
    );
    getSearchData(resetData: true);
  }

  void onSortByChange(SortDataModel? value) {
    filterState = filterState.copyWith(
      sortBy: value,
    );
    getSearchData(resetData: true);
  }

  void onClearAllTap() {
    filterState = FilterState();
    getSearchData(resetData: true);
  }

  void onBackToTopTap() {
    try {
      backToTopBtnVisible = false;
      scrollController.animateTo(
        0,
        duration: 200.milliseconds,
        curve: Curves.linear,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void onFavoriteBtnTap(int index) {
    final List<Product> updatedList =
        List.from(searchProductRes?.data?.products ?? []);
    updatedList[index] = updatedList[index].copyWith(
      isFavorite: !updatedList[index].isFavorite,
    );
    searchProductRes = searchProductRes?.copyWith(
      data: searchProductRes?.data?.copyWith(
        products: updatedList,
      ),
    );
    update(['loader']);
  }
}
