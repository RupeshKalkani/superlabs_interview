import 'package:superlabs_interview/superlabs_interview.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: 65.ww,
        width: 65.ww,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: ColorRes.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 0),
              color: ColorRes.black.withOpacity(0.2),
              blurRadius: 10
            )
          ],
        ),
        padding: EdgeInsets.all(16.ww),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class SmallLoader extends StatelessWidget {
  const SmallLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: AppLoader(),
    );
  }
}

class StackedLoader extends StatelessWidget {
  final Widget? child;
  final bool? loading;

  const StackedLoader({super.key, this.child, this.loading});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child ?? const SizedBox(),
        if (loading == true)
          Container(
            color: ColorRes.black.withOpacity(0.1),
            height: Get.height,
            width: Get.width,
            child: const Center(
              child: AppLoader(),
            ),
          )
        else
          const SizedBox(),
      ],
    );
  }
}

bool isLoaderDialogOpen = false;

void startLoaderDialog() {
  if (isLoaderDialogOpen) {
    return;
  }
  isLoaderDialogOpen = true;
  Get.dialog(
    Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: SizedBox(
        height: 100.h,
        width: 100.w,
        child: const SmallLoader(),
      ),
    ),
    useSafeArea: false,
    barrierDismissible: false,
    barrierColor: ColorRes.white.withOpacity(0.1),
  ).whenComplete(() {
    isLoaderDialogOpen = false;
  });
}

void closeLoaderDialog() {
  if (isLoaderDialogOpen) {
    Get.back();
  }
}
