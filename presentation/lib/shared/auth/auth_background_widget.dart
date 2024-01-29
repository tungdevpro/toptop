import 'package:core/service/app_navigator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:presentation/common/widgets/svg_viewer.dart';
import 'package:presentation/import.dart';

import '../../common/widgets/image_viewer.dart';

class AuthBackgroundWidget extends StatelessWidget {
  final List<Widget>? children;
  final String title;
  final dynamic subTitle;
  final bool hasBack;
  final VoidCallback? onBack;

  const AuthBackgroundWidget({super.key, this.children, required this.title, this.subTitle, this.hasBack = false, this.onBack});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return GestureDetector(
      onTap: context.hideKeyboard,
      child: Scaffold(
        body: Stack(
          children: [
            ImageViewer(AppImages.imgAuthBackground, height: size.height / 2.5, width: size.width, fit: BoxFit.cover),
            Container(
              margin: EdgeInsets.only(top: MediaQuery.sizeOf(context).height / 3.6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppSizings.radius),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(AppSizings.padding),
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: AppSizings.padding),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                title,
                                style: const TextStyle(
                                  color: AppColors.title2,
                                  fontSize: AppSizings.t2Lg,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (subTitle != null)
                                subTitle is Widget
                                    ? subTitle
                                    : Padding(
                                        padding: const EdgeInsets.only(top: 4),
                                        child: Text(subTitle!, style: const TextStyle(color: AppColors.subTitle2, fontWeight: FontWeight.w500)),
                                      ),
                            ],
                          ),
                        ),
                        if (hasBack)
                          Positioned(
                              left: AppSizings.padding,
                              top: 5,
                              child: InkWell(
                                  onTap: onBack,
                                  child: const CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Colors.transparent,
                                    child: SvgViewer(AppIcons.icCaretleft),
                                  ))),
                      ],
                    ),
                  ),
                  const Divider(color: AppColors.divider, height: 1),
                  Expanded(
                    child: ListView(
                      physics: const ClampingScrollPhysics(),
                      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: const EdgeInsets.all(20),
                      children: [
                        ...?children,
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppStrings.baseTermSub.tr(), style: const TextStyle(color: AppColors.subTitle, fontSize: AppSizings.tSm), textAlign: TextAlign.center),
              GestureDetector(
                onTap: _onOpenWebTerm,
                child: Text(
                  AppStrings.baseTerm.tr(),
                  style: const TextStyle(color: AppColors.title, fontSize: AppSizings.tSm, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onOpenWebTerm() => locator<AppNavigator>().push(WebViewer('${AppEnvironment.model.webUrl ?? ''}/terms'));
}
