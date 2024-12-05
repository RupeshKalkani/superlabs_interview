import 'package:superlabs_interview/packages/dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:superlabs_interview/screens/filter/filter_controller.dart';
import 'package:superlabs_interview/superlabs_interview.dart';

Future<FilterState?> openFilterDialog(
  FilterState filterState,
  SearchData? searchData,
) async {
  final controller = Get.put(FilterController());
  controller.init(filterState, searchData);

  final result = await Get.dialog(
    const FilterDialog(),
  );

  if (result is FilterState) {
    return result;
  }
  return null;
}

class FilterDialog extends StatelessWidget {
  const FilterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Constants.horizontalPadding,
        ),
        child: Material(
          color: ColorRes.white,
          borderRadius: BorderRadius.circular(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              header(),
              GetBuilder<FilterController>(
                id: "loader",
                builder: (controller) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 100.h * 0.65,
                    ),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.ww,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          sortByCell(controller),
                          divider(),
                          ratingCell(controller),
                          divider(),
                          brandCell(controller),
                          divider(),
                          attributeCell(controller),
                          divider(),
                          priceRangeCell(controller),
                          divider(),
                          filterChipCell(controller),
                          submitButtons(controller),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget divider() {
    return Container(
      height: 0.5,
      width: 100.w,
      color: ColorRes.grey2,
    );
  }

  Widget header() {
    return Row(
      children: [
        SizedBox(
          width: Constants.horizontalPadding,
        ),
        Expanded(
          child: Text(
            "filters".tr,
            style: styleW600S16,
          ),
        ),
        InkWell(
          onTap: Get.back,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.ww,
              vertical: 15.hh,
            ),
            child: const SvgAsset(
              imagePath: AssetRes.closeIcon,
            ),
          ),
        ),
      ],
    );
  }

  Widget titleCell(
    String title,
    bool accordion,
    VoidCallback? onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.ww, vertical: 10.hh),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title.tr,
                style: styleW500S16,
              ),
            ),
            Transform.rotate(
              angle: pi * (accordion ? 2 : 1),
              child: const Icon(
                Icons.keyboard_arrow_up,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget sortByCell(FilterController controller) {
    return AnimatedSize(
      duration: controller.animationDuration,
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          titleCell(
            "sort_by".tr,
            controller.sortByAccordion,
            controller.onSortByAccordionChange,
          ),
          if (controller.sortByAccordion)
            ListView.builder(
              itemCount: sortDataList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemBuilder: (con, index) {
                return InkWell(
                  onTap: () => controller.onSortByChange(sortDataList[index]),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.ww,
                      vertical: 5.hh,
                    ),
                    child: Row(
                      children: [
                        RadioBtn(
                          value: controller.filterState.sortBy ==
                              sortDataList[index],
                        ),
                        SizedBox(width: 10.ww),
                        Text(
                          sortDataList[index].text ?? '',
                          style: styleW400S13,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  Widget ratingCell(FilterController controller) {
    return AnimatedSize(
      duration: controller.animationDuration,
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          titleCell(
            "rating".tr,
            controller.ratingAccordion,
            controller.onRatingAccordionChange,
          ),
          if (controller.ratingAccordion)
            ListView.builder(
              itemCount: 5,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              reverse: true,
              itemBuilder: (con, index) {
                final model = controller
                    .searchData?.ratingsCounts?[(index + 1).toString()];
                if (model == null) return const SizedBox();
                return InkWell(
                  onTap: () => controller.onRatingChange(index + 1),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.ww,
                      vertical: 5.hh,
                    ),
                    child: Row(
                      children: [
                        RadioBtn(
                          value: controller.filterState.rating == (index + 1),
                        ),
                        SizedBox(width: 10.ww),
                        AppRatingBar(rating: index + 1),
                        SizedBox(width: 5.ww),
                        Text(
                          index == 4
                              ? '${index + 1} ($model)'
                              : '${index + 1} & up ($model)',
                          style: styleW400S13,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  Widget brandCell(FilterController controller) {
    return AnimatedSize(
      duration: controller.animationDuration,
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          titleCell(
            "brand".tr,
            controller.brandAccordion,
            controller.onBrandAccordionChange,
          ),
          if (controller.brandAccordion) ...[
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15.ww,
              ),
              child: TextField(
                controller: controller.brandTextController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  isDense: true,
                  prefixIconConstraints: BoxConstraints(
                    maxWidth: 40.ww,
                  ),
                  hintText: "Search Brand",
                  hintStyle: styleW400S14.copyWith(color: ColorRes.grey2),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 5.ww),
                    child: Center(
                      child: SvgAsset(
                        imagePath: AssetRes.searchIcon,
                        height: 30.ww,
                      ),
                    ),
                  ),
                ),
                onChanged: controller.onBrandTextFieldChange,
              ),
            ),
            SizedBox(height: 5.hh),
            DynamicHeightGridView(
              crossAxisSpacing: 10.ww,
              mainAxisSpacing: 1.ww,
              crossAxisCount: 2,
              padding: EdgeInsets.only(bottom: 5.hh),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.filteredBrands.length,
              builder: (con, index) {
                final model = controller.filteredBrands[index];
                return InkWell(
                  onTap: () => controller.onBrandSelect(model),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.ww,
                      vertical: 5.hh,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CheckBoxBtn(
                          value: controller.filterState.brands.contains(model),
                        ),
                        SizedBox(width: 10.ww),
                        Expanded(
                          child: Text(
                            '${model.name ?? ''} (${model.productCount ?? 0})',
                            style: styleW400S13,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ]
        ],
      ),
    );
  }

  Widget attributeCell(FilterController controller) {
    return ListView.builder(
      itemCount: controller.searchData?.attributes?.length ?? 0,
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final model = controller.searchData?.attributes?[index];
        if (model == null) return const SizedBox();
        return AnimatedSize(
          duration: controller.animationDuration,
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              titleCell(
                model.title ?? '',
                controller.attributesAccordion[index],
                () => controller.onAttributeAccordionChange(index),
              ),
              if (controller.attributesAccordion[index])
                DynamicHeightGridView(
                  crossAxisSpacing: 10.ww,
                  mainAxisSpacing: 1.ww,
                  crossAxisCount: 2,
                  padding: EdgeInsets.only(bottom: 5.hh),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: model.values?.length ?? 0,
                  builder: (con, index2) {
                    final model2 = model.values?[index2];
                    if (model2 == null) return const SizedBox();
                    return InkWell(
                      onTap: () => controller.onAttributeSelect(model, model2),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15.ww,
                          vertical: 5.hh,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CheckBoxBtn(
                              value:
                                  controller.isAttributeSelected(model, model2),
                            ),
                            SizedBox(width: 10.ww),
                            Expanded(
                              child: Text(
                                '${model2.value ?? ''} (${model2.productCount ?? 0})',
                                style: styleW400S13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              divider(),
            ],
          ),
        );
      },
    );
  }

  Widget priceRangeCell(FilterController controller) {
    return AnimatedSize(
      duration: controller.animationDuration,
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          titleCell(
            "price_range".tr,
            controller.priceAccordion,
            controller.onPriceAccordionChange,
          ),
          if (controller.priceAccordion) ...[
            ListView.builder(
              itemCount: controller.priceModelList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemBuilder: (con, index) {
                final model = controller.priceModelList[index];
                return InkWell(
                  onTap: () => controller.onPriceSelect(model),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.ww,
                      vertical: 5.hh,
                    ),
                    child: Row(
                      children: [
                        RadioBtn(
                          value: controller.isPriceSelected(model),
                        ),
                        SizedBox(width: 10.ww),
                        Text(
                          model.title,
                          style: styleW400S13,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 5.hh),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15.ww,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller.minPriceController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        isDense: true,
                        prefixIconConstraints: BoxConstraints(
                          maxWidth: 40.ww,
                        ),
                        hintText: "Min",
                        hintStyle: styleW400S14.copyWith(color: ColorRes.grey2),
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 5.ww, top: 2),
                          child: const Icon(
                            Icons.currency_rupee,
                            size: 15,
                          ),
                        ),
                      ),
                      onChanged: controller.onMinPriceFieldChange,
                    ),
                  ),
                  SizedBox(width: 10.ww),
                  Expanded(
                    child: TextField(
                      controller: controller.maxPriceController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        isDense: true,
                        prefixIconConstraints: BoxConstraints(
                          maxWidth: 40.ww,
                        ),
                        hintText: "Max",
                        hintStyle: styleW400S14.copyWith(color: ColorRes.grey2),
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 5.ww, top: 2),
                          child: const Icon(
                            Icons.currency_rupee,
                            size: 15,
                          ),
                        ),
                      ),
                      onChanged: controller.onMaxPriceFieldChange,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.hh),
          ],
        ],
      ),
    );
  }

  Widget filterChipCell(FilterController controller) {
    List<Widget> chipList = [];

    if (controller.filterState.rating != null) {
      chipList.add(chipUI(
        '',
        () => controller.onRatingChange(null),
        child: AppRatingBar(
          rating: controller.filterState.rating?.toDouble() ?? 0,
        ),
      ));
    }

    for (var model in controller.filterState.brands) {
      chipList.add(chipUI(
        model.name ?? '',
        () => controller.onBrandSelect(model),
      ));
    }

    for (var model in controller.filterState.attributes) {
      for (SearchValue attribute in model.values ?? []) {
        chipList.add(chipUI(
          attribute.value ?? '',
          () => controller.onAttributeSelect(model, attribute),
        ));
      }
    }
    if (controller.filterState.minPrice != null ||
        controller.filterState.maxPrice != null) {
      if (controller.filterState.maxPrice != null &&
          controller.filterState.minPrice == null) {
        chipList.add(chipUI(
          'Under ₹${getPriceString(controller.filterState.maxPrice ?? 0)}',
          () => controller.onPriceSelect(null),
        ));
      } else if (controller.filterState.minPrice != null &&
          controller.filterState.maxPrice == null) {
        chipList.add(chipUI(
          'Over ₹${getPriceString(controller.filterState.minPrice ?? 0)}',
          () => controller.onPriceSelect(null),
        ));
      } else {
        chipList.add(chipUI(
          '₹${getPriceString(controller.filterState.minPrice ?? 0)}'
          '-₹${getPriceString(controller.filterState.maxPrice ?? 0)}',
          () => controller.onPriceSelect(null),
        ));
      }
    }

    if (chipList.isEmpty) return const SizedBox();
    return SizedBox(
      width: 100.w,
      child: Padding(
        padding: EdgeInsets.only(top: 10.hh),
        child: Wrap(
          runSpacing: 10,
          spacing: 10,
          children: chipList,
        ),
      ),
    );
  }

  Widget chipUI(
    String title,
    VoidCallback onTap, {
    Widget? child,
  }) {
    return Material(
      color: ColorRes.grey4.withOpacity(0.4),
      borderRadius: BorderRadius.circular(500),
      child: InkWell(
        borderRadius: BorderRadius.circular(500),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.only(
            left: 13.ww,
            right: 5.ww,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              child ??
                  Text(
                    title,
                    style: styleW500S13,
                  ),
              const SvgAsset(
                imagePath: AssetRes.closeIcon,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget submitButtons(FilterController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.hh,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 40,
            width: 100,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(500),
                onTap: controller.onClearAllTap,
                child: Center(
                  child: Text(
                    "clear_all".tr,
                    style: styleW600S14.copyWith(
                      color: ColorRes.primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 40,
            width: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(500),
              color: ColorRes.primaryColor,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(500),
                onTap: controller.onShowResultTap,
                child: Center(
                  child: Text(
                    "show_results".tr,
                    style: styleW600S14.copyWith(
                      color: ColorRes.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
