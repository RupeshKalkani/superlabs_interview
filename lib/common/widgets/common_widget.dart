import 'package:superlabs_interview/packages/custom_rating_bar/custom_rating_bar.dart';
import 'package:superlabs_interview/superlabs_interview.dart';

class ErrorText extends StatelessWidget {
  final String? text;
  final bool topPadding;
  final bool isCenterAlign;

  const ErrorText({
    super.key,
    this.text,
    this.topPadding = false,
    this.isCenterAlign = false,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: (text ?? '').isNotEmpty,
      child: Padding(
        padding: EdgeInsets.only(top: topPadding ? 5 : 0),
        child: Row(
          mainAxisAlignment: isCenterAlign
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            /// Error Icon
            SvgAsset(
              imagePath: AssetRes.errorIcon,
              height: 16.ww,
            ),

            /// Space
            SizedBox(width: 4.ww),

            /// Error Text
            Flexible(
              fit: isCenterAlign ? FlexFit.loose : FlexFit.tight,
              child: Text(
                text ?? '',
                style: styleW500S12.copyWith(
                  color: ColorRes.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SvgAsset extends StatelessWidget {
  final String imagePath;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit? fit;
  final double? borderRadius;
  final Alignment? alignment;

  const SvgAsset({
    super.key,
    required this.imagePath,
    this.height,
    this.width,
    this.color,
    this.fit,
    this.borderRadius,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      child: SvgPicture.asset(
        imagePath,
        height: height,
        width: width,
        fit: fit ?? BoxFit.contain,
        alignment: alignment ?? Alignment.center,
        colorFilter: color == null
            ? null
            : ColorFilter.mode(
                color!,
                BlendMode.srcIn,
              ),
      ),
    );
  }
}

class AssetsImg extends StatelessWidget {
  final String imagePath;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit? fit;
  final double? borderRadius;

  const AssetsImg({
    super.key,
    required this.imagePath,
    this.height,
    this.width,
    this.color,
    this.fit,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      child: Image.asset(
        imagePath,
        height: height,
        width: width,
        fit: fit ?? BoxFit.contain,
        color: color,
      ),
    );
  }
}

class CachedImage extends StatelessWidget {
  final String? url;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final double? borderRadius;
  final Widget? errorWidget;
  final bool skipBaseUrl;
  final ProgressIndicatorBuilder? progressIndicatorBuilder;

  const CachedImage(
    this.url, {
    super.key,
    this.height,
    this.width,
    this.fit,
    this.borderRadius,
    this.errorWidget,
    this.skipBaseUrl = false,
    this.progressIndicatorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      child: url == null
          ? _errorWidgetBox()
          : CachedNetworkImage(
              imageUrl: skipBaseUrl
                  ? url.toString()
                  : "https://wsrv.nl/?"
                      "url=https://eu2.contabostorage.com/eabb361130e04e0c98e8b88a22721601:bb2/$url"
                      "&width=$width"
                      "&quality=75"
                      "&height=$height"
                      "&output=webp",
              height: height,
              width: width,
              fit: fit ?? BoxFit.cover,
              errorWidget: (con, str, obj) {
                return _errorWidgetBox();
              },
              progressIndicatorBuilder: progressIndicatorBuilder ??
                  (con, str, progress) {
                    return CustomShimmer(
                      height: height,
                      width: width,
                    );
                  },
            ),
    );
  }

  Widget _errorWidgetBox() {
    if (errorWidget != null) {
      return errorWidget!;
    }
    return Container(
      height: height,
      width: width,
      color: ColorRes.grey4.withOpacity(0.5),
      padding: EdgeInsets.all(5.ww),
      alignment: Alignment.center,
      child: const Icon(Icons.error_outline),
    );
  }
}

class AppRefreshIndicator extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;

  const AppRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      backgroundColor: ColorRes.white,
      color: ColorRes.primaryColor,
      child: child,
    );
  }
}

class RadioBtn extends StatelessWidget {
  final bool value;
  final VoidCallback? onChange;

  const RadioBtn({
    super.key,
    required this.value,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onChange,
      child: Container(
        height: 22,
        width: 22,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: value
              ? Border.all(
                  color: ColorRes.primaryColor,
                  width: 7,
                )
              : Border.all(
                  color: ColorRes.grey2,
                ),
        ),
      ),
    );
  }
}

class CheckBoxBtn extends StatelessWidget {
  final bool value;
  final VoidCallback? onChange;

  const CheckBoxBtn({
    super.key,
    required this.value,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onChange,
      child: AnimatedContainer(
        duration: 200.milliseconds,
        height: 22,
        width: 22,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: value
              ? null
              : Border.all(
                  color: ColorRes.grey2,
                ),
          color: value ? ColorRes.primaryColor : null,
        ),
        alignment: Alignment.center,
        child: value
            ? const Icon(
                Icons.check,
                color: ColorRes.white,
                size: 16,
              )
            : const SizedBox(),
      ),
    );
  }
}

class AppRatingBar extends StatelessWidget {
  final double rating;

  const AppRatingBar({
    super.key,
    this.rating = 0,
  });

  @override
  Widget build(BuildContext context) {
    return RatingBar.readOnly(
      filledIcon: Icons.star,
      emptyIcon: Icons.star,
      filledColor: ColorRes.primaryColor,
      halfFilledColor: ColorRes.primaryColor,
      emptyColor: ColorRes.grey4,
      halfFilledIcon: Icons.star_half,
      initialRating: rating,
      isHalfAllowed: true,
      size: 17,
    );
  }
}
