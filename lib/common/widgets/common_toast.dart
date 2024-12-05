import 'package:superlabs_interview/superlabs_interview.dart';

void showCustomToast(String msg, {bool? error}) {
  Widget widget() {
    final topSafeArea = Constants.safeArea?.top ?? 0;

    Color toastColor = error == true ? ColorRes.red2 : ColorRes.green2;
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            top: topSafeArea + 2.hh,
            left: 10.ww,
            right: 10.ww,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: ColorRes.darkGrey2,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 16),
                blurRadius: 24,
                color: ColorRes.black.withOpacity(0.14),
              ),
              BoxShadow(
                offset: const Offset(0, 6),
                blurRadius: 30,
                color: ColorRes.black.withOpacity(0.12),
              ),
              BoxShadow(
                offset: const Offset(0, 8),
                blurRadius: 10,
                color: ColorRes.black.withOpacity(0.2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// Space
                    SizedBox(height: 15.ww),

                    Row(
                      children: [
                        /// Space
                        SizedBox(width: 16.ww),

                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorRes.darkGrey3,
                          ),
                          padding: EdgeInsets.all(4.ww),
                          child: SvgAsset(
                            imagePath: error == true
                                ? AssetRes.closeIcon2
                                : AssetRes.checkIcon,
                            height: 24.ww,
                          ),
                        ),

                        /// Space
                        SizedBox(width: 15.ww),

                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                error == true ? "Error" : "Success",
                                style: styleW700S17.copyWith(
                                    color: ColorRes.white),
                              ),

                              /// Space
                              const SizedBox(height: 2),

                              Text(
                                msg,
                                style: styleW400S13.copyWith(
                                  color: ColorRes.lightBlue,
                                ),
                              ),
                            ],
                          ),
                        ),

                        /// Space
                        SizedBox(width: 15.ww),
                      ],
                    ),

                    /// Space
                    SizedBox(height: 15.ww),

                    Container(
                      height: 3,
                      width: 100.w,
                      decoration: BoxDecoration(
                        color: toastColor,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(-5, 0),
                            blurRadius: 5,
                            spreadRadius: 1,
                            color: toastColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: -65.ww,
                  left: -74.ww,
                  child: Container(
                    height: 212.ww,
                    width: 212.ww,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: error == true
                            ? [
                                ColorRes.red2.withOpacity(0.12),
                                ColorRes.red2.withOpacity(0),
                              ]
                            : [
                                ColorRes.green2.withOpacity(0.12),
                                ColorRes.green2.withOpacity(0),
                              ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  showToastWidget(
    widget(),
    duration: const Duration(seconds: 3),
    handleTouch: true,
    dismissOtherToast: true,
  );
}
