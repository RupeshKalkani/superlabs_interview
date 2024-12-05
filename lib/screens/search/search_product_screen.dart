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
          return StackedLoader(
            loading: controller.loader,
            child: SafeArea(
              top: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SearchAppbar(),
                  const FilterInfoCell(),
                  dataList(controller),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget dataList(SearchProductController controller) {
    return Expanded(
      child: AppRefreshIndicator(
        onRefresh: controller.getSearchData,
        child: DynamicHeightGridView(
          crossAxisSpacing: 15.46.ww,
          mainAxisSpacing: 14.92.ww,
          crossAxisCount: 2,
          padding: EdgeInsets.fromLTRB(
            15.46.ww,
            15.hh,
            15.46.ww,
            10.hh,
          ),
          itemCount: controller.searchProductRes?.data?.products?.length ?? 0,
          lastWidget:
              ((controller.searchProductRes?.data?.products?.length ?? 0) >=
                      (controller.searchProductRes?.meta?.total ?? 0))
                  ? null
                  : Builder(builder: (con) {
                      if (!controller.isApiCalling) {
                        controller.getSearchData();
                      }
                      return Visibility(
                        visible: !controller.loader,
                        child: const SizedBox(
                          height: 200,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      );
                    }),
          builder: (con, index) {
            return ProductCell(
              product: controller.searchProductRes?.data?.products?[index],
            );
          },
        ),
      ),
    );
  }
}
