import 'package:superlabs_interview/screens/search/search_product_controller.dart';
import 'package:superlabs_interview/superlabs_interview.dart';

class FilterInfoCell extends StatelessWidget {
  const FilterInfoCell({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchProductController>(
      id: "loader",
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            filterChipCell(controller),
            searchData(controller),
            SizedBox(height: 10.hh),
          ],
        );
      },
    );
  }

  Widget filterChipCell(SearchProductController controller) {
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
    chipList.add(
      SizedBox(
        height: 30,
        width: 80,
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
    );
    return SizedBox(
      width: 100.w,
      child: Padding(
        padding: EdgeInsets.only(
          top: 10.hh,
          bottom: 10.hh,
        ),
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

  Widget searchData(SearchProductController controller) {
    return Row(
      children: [
        Expanded(
          child: Text(
            '${controller.searchProductRes?.meta?.total ?? 0} result',
          ),
        ),
        DropdownButton<SortDataModel>(
          items: sortDataList.map((e) {
            return DropdownMenuItem<SortDataModel>(
              value: e,
              child: Text(e.text ?? ''),
            );
          }).toList(),
          selectedItemBuilder: (con) {
            return sortDataList.map((e) {
              return Center(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Sort By: ',
                        style: styleW600S14,
                      ),
                      TextSpan(
                        text: e.text ?? '',
                        style: styleW400S14,
                      ),
                    ],
                  ),
                ),
              );
            }).toList();
          },
          isDense: true,
          alignment: Alignment.centerRight,
          value: controller.filterState.sortBy,
          underline: const SizedBox(),
          onChanged: controller.onSortByChange,
        ),
      ],
    );
  }
}
