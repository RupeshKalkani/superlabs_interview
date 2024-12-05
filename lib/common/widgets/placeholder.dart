import 'package:superlabs_interview/superlabs_interview.dart';

class CustomShimmer extends StatelessWidget {
  final double? height;
  final double? width;
  final double? borderRadius;

  const CustomShimmer({super.key, this.height, this.width, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      child: Shimmer.fromColors(
        baseColor: ColorRes.grey4,
        highlightColor: ColorRes.grey4.withOpacity(0.6),
        child: Container(
          height: height ?? 100.h,
          width: width ?? 100.w,
          color: ColorRes.black,
        ),
      ),
    );
  }
}

class CustomShimmer2 extends StatelessWidget {
  final double? height;
  final double? width;
  final double? borderRadius;

  const CustomShimmer2({super.key, this.height, this.width, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      child: Shimmer.fromColors(
        baseColor: ColorRes.grey3.withOpacity(0.3),
        highlightColor: ColorRes.grey3.withOpacity(0.6),
        child: Container(
          height: height ?? 100.h,
          width: width ?? 100.w,
          color: ColorRes.black,
        ),
      ),
    );
  }
}
