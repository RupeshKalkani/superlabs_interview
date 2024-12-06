import 'package:superlabs_interview/superlabs_interview.dart';

class ProductCell extends StatelessWidget {
  final Product? product;
  final VoidCallback? onFavoriteTap;

  const ProductCell({
    super.key,
    this.product,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            CachedImage(
              product?.thumbnail ?? '',
              height: 55.w,
              width: 100.w,
              borderRadius: 5,
            ),
            Positioned(
              top: 0,
              right: 0,
              child: InkWell(
                onTap: onFavoriteTap,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Icon(
                    product?.isFavorite == true
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: ColorRes.primaryColor,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.hh),
        Text(
          product?.title ?? '',
          style: styleW600S13,
        ),
        Text(
          "${(product?.variants?.length ?? 1)} variants",
          style: styleW400S13,
        ),
        Row(
          children: [
            AppRatingBar(
              rating: product?.averageRating ?? 0,
            ),
            SizedBox(width: 5.ww),
            Text(
              getPriceString(
                product?.averageRating,
                fixedDecimal: 1,
              ),
              style: styleW400S13,
            ),
          ],
        ),
        Text(
          "Rs. ${(product?.priceStart ?? 0)}",
          style: styleW600S16,
        ),
      ],
    );
  }
}

class ProductCellShimmer extends StatelessWidget {
  const ProductCellShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomShimmer2(
          height: 55.w,
          width: 100.w,
          borderRadius: 5,
        ),
        SizedBox(height: 10.hh),
        CustomShimmer2(
          height: 15,
          width: 100.w,
          borderRadius: 3,
        ),
        const SizedBox(height: 5),
        CustomShimmer2(
          height: 15,
          width: 75.ww,
          borderRadius: 3,
        ),
        const SizedBox(height: 5),
        const AppRatingBar(
          rating: 0,
        ),
        const SizedBox(height: 5),
        CustomShimmer2(
          height: 20.ww,
          width: 80.ww,
          borderRadius: 3,
        ),
      ],
    );
  }
}
