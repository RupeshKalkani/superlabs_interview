import 'package:superlabs_interview/packages/dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:superlabs_interview/screens/search/search_product_controller.dart';
import 'package:superlabs_interview/screens/search/widget/filter_info_cell.dart';
import 'package:superlabs_interview/screens/search/widget/product_cell.dart';
import 'package:superlabs_interview/screens/search/widget/search_appbar.dart';
import 'package:superlabs_interview/superlabs_interview.dart';

class SearchProductScreen extends StatelessWidget {
  const SearchProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SearchProductController());
    return Scaffold(
      backgroundColor: ColorRes.white,
      body: GetBuilder<SearchProductController>(
        id: 'loader',
        builder: (controller) {
          return SafeArea(
            top: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SearchAppbar(),
                dataList(controller),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget dataList(SearchProductController controller) {
    if (controller.loader) {
      return loaderList();
    }
    return Expanded(
      child: Stack(
        children: [
          AppRefreshIndicator(
            onRefresh: controller.getSearchData,
            child: DynamicHeightGridView(
              crossAxisSpacing: 15.46.ww,
              mainAxisSpacing: 14.92.ww,
              crossAxisCount: 2,
              padding: EdgeInsets.fromLTRB(
                15.46.ww,
                0,
                15.46.ww,
                (controller.searchProductRes?.data?.products?.length ?? 0) > 2
                    ? 10.hh
                    : 50.h,
              ),
              controller: controller.scrollController,
              itemCount:
                  controller.searchProductRes?.data?.products?.length ?? 0,
              firstWidget: const FilterInfoCell(),
              lastWidget: !controller.loader &&
                      ((controller.searchProductRes?.data?.products?.length ??
                              0) >=
                          (controller.searchProductRes?.meta?.total ?? 0))
                  ? null
                  : Builder(
                      builder: (con) {
                        return loadMoreCell(controller);
                      },
                    ),
              builder: (con, index) {
                return ProductCell(
                  product: controller.searchProductRes?.data?.products?[index],
                  onFavoriteTap: () => controller.onFavoriteBtnTap(index),
                );
              },
            ),
          ),
          if (controller.backToTopBtnVisible)
            Positioned(
              top: 10,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  height: 35,
                  width: 115,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(500),
                    color: ColorRes.primaryColor.withOpacity(0.15),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(500),
                      onTap: controller.onBackToTopTap,
                      child: Center(
                        child: Text(
                          "Back To Top".tr,
                          style: styleW600S14.copyWith(
                            color: ColorRes.primaryColor,
                          ),
                        ),
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

  Widget loaderList() {
    return Expanded(
      child: DynamicHeightGridView(
        crossAxisSpacing: 15.46.ww,
        mainAxisSpacing: 14.92.ww,
        crossAxisCount: 2,
        padding: EdgeInsets.fromLTRB(
          15.46.ww,
          0,
          15.46.ww,
          10.hh,
        ),
        itemCount: 8,
        firstWidget: const FilterInfoCell(),
        builder: (con, index) {
          return const ProductCellShimmer();
        },
      ),
    );
  }

  Widget loadMoreCell(SearchProductController controller) {
    if (controller.paginationLoader) {
      return SizedBox(
        height: 150,
        width: 100.w,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Column(
      children: [
        SizedBox(height: 30.hh),
        Text(
          "Showing ${controller.searchProductRes?.data?.products?.length ?? 0}"
          " of ${controller.searchProductRes?.meta?.total ?? 0} results",
          style: styleW400S15.copyWith(
            color: ColorRes.grey,
          ),
        ),
        SizedBox(height: 10.hh),
        Container(
          height: 40,
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(500),
            color: ColorRes.primaryColor,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(500),
              onTap: () {
                if (!controller.isApiCalling) {
                  controller.getSearchData();
                }
              },
              child: Center(
                child: Text(
                  "load_more".tr,
                  style: styleW600S14.copyWith(
                    color: ColorRes.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 15.hh),
      ],
    );
  }
}
