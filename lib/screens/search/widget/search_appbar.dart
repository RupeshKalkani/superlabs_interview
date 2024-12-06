import 'package:superlabs_interview/screens/search/search_product_controller.dart';
import 'package:superlabs_interview/superlabs_interview.dart';

class SearchAppbar extends StatelessWidget {
  const SearchAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SearchProductController>();
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 10.hh,
          horizontal: Constants.horizontalPadding,
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(500),
                  border: Border.all(color: ColorRes.grey),
                  color: ColorRes.grey3.withOpacity(0.1),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 10.ww,
                        right: 5.ww,
                      ),
                      child: SvgAsset(
                        imagePath: AssetRes.searchIcon,
                        height: 30.ww,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: controller.searchFieldController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search",
                          hintStyle: styleW500S16.copyWith(
                            color: ColorRes.grey2,
                          ),
                        ),
                        onChanged: (value) => controller.onSearchChange(),
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(500),
                      onTap: controller.onClearQueryTap,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.ww,
                          vertical: 5,
                        ),
                        child: SvgAsset(
                          imagePath: AssetRes.closeIcon,
                          height: 30.ww,
                          color: ColorRes.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 10.ww),
            Material(
              color: ColorRes.primaryColor,
              borderRadius: BorderRadius.circular(500),
              child: InkWell(
                onTap: controller.onFilterBtnTap,
                borderRadius: BorderRadius.circular(500),
                child: const Padding(
                  padding: EdgeInsets.all(12),
                  child: AssetsImg(
                    imagePath: AssetRes.filterIcon,
                    height: 24,
                    width: 24,
                    color: ColorRes.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
