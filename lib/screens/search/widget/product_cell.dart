import 'package:superlabs_interview/superlabs_interview.dart';

class ProductCell extends StatelessWidget {
  final Product? product;

  const ProductCell({super.key, this.product});

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
            const Positioned(
              top: 10,
              right: 10,
              child: Icon(
                Icons.favorite_border,
                color: ColorRes.primaryColor,
                size: 20,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.hh),
        Text(
          product?.title ?? '',
          style: styleW600S13,
        ),
        // SizedBox(height: 10.hh),
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
