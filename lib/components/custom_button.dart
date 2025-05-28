import 'package:flutter/material.dart';
import '../../constants/theme_constants.dart';

enum ButtonType {
  primary,
  secondary,
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.btnHeight,
    this.btnWidth,
    this.btnColor,
    this.borderRadius,
    this.isDisabled,
    this.borderSide = BorderSide.none,
    this.textStyle,
    this.margin,
    this.inProgress,
    this.padding,
    this.splashColor,
    this.buttonType = ButtonType.primary,
  });

  final double? btnHeight;
  final double? btnWidth;
  final String text;
  final TextStyle? textStyle;
  final Color? btnColor;
  final VoidCallback? onTap;
  final BorderRadius? borderRadius;
  final bool? isDisabled;
  final BorderSide borderSide;
  final EdgeInsets? margin;
  final bool? inProgress;
  final EdgeInsetsGeometry? padding;
  final Color? splashColor;
  final ButtonType buttonType;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: btnHeight ?? (44),
      width: btnWidth ?? btnWidth,
      alignment: Alignment.center,
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: splashColor ?? Colors.white24,
          padding: padding ?? const EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ??
                BorderRadius.circular(
                  AppTheme.defaultBorderRadius,
                ),
            side: borderSide,
          ),
          backgroundColor: (onTap == null || isDisabled == false)
              ? Colors.grey[300]
              : btnColor ??
                  (buttonType == ButtonType.secondary
                      ? AppTheme.greyShade1
                      : AppTheme.grey),
        ),
        onPressed: (onTap == null || isDisabled == false)
            ? null
            : () {
                FocusManager.instance.primaryFocus?.unfocus();
                onTap!();
              },
        child: Container(
          alignment: Alignment.center,
          child: (inProgress == true)
              ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: buttonType == ButtonType.secondary
                        ? AppTheme.greyTint1
                        : AppTheme.white,
                  ),
                )
              : Text(
                  text,
                  style: textStyle ??
                      Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: buttonType == ButtonType.secondary
                                ? AppTheme.greyShade1
                                : AppTheme.white,
                            fontWeight: FontWeight.w600,
                          ),
                ),
        ),
      ),
    );
  }
}
