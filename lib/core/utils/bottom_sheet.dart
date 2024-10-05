import 'package:car_rental/features/presentation/extension/dimension.dart';
import 'package:car_rental/features/presentation/resources/app_colors.dart';
import 'package:car_rental/features/presentation/resources/app_text_styles.dart';
import 'package:car_rental/features/presentation/resources/route_manager.dart';
import 'package:flutter/material.dart';

class UBottomSheet {
  static Future<dynamic> showBottomSheet({
    String? title,
    double? height,
    bool showCloseButton = true,
    bool showDragHandle = true,
    required Widget Function(BuildContext) builder,
  }) {
    final context = Routes.rootNavigatorKey.currentContext!;
    return showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (context) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: context.percentHeight(20),
            maxHeight: context.screenHeight,
          ),
          child: SizedBox(
            height: height,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (showCloseButton || showDragHandle)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    height: 46,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        if (showDragHandle)
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.gray500,
                            ),
                            width: 32,
                            height: 4,
                          ),
                        if (showCloseButton)
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: const Icon(Icons.close),
                            ),
                          ),
                      ],
                    ),
                  ),
                if (title != null)
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    child: Text(
                      title,
                      style: AppTextStyle.textColorHeadingXSmall,
                    ),
                  ),
                Flexible(child: builder(context)),
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }
}
