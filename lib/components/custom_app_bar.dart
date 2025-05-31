import 'package:flutter/material.dart';

import '../../constants/theme_constants.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar({
    this.title,
    super.key,
    this.toolbarHeight,
    this.bottom,
    this.elevation,
    this.leadingIcon,
    this.leadingOnTap,
    this.actionIcon,
    this.actionOnTap,
    this.titleOnTap,
    this.actionWidget,
  })  : assert(elevation == null || elevation >= 0.0),
        preferredSize =
            _CustomAppBarSize(toolbarHeight, bottom?.preferredSize.height);

  final double? toolbarHeight;
  final PreferredSizeWidget? bottom;
  final double? elevation;
  final String? title;
  final IconData? leadingIcon;
  final Function? leadingOnTap;
  final IconData? actionIcon;
  final Function? actionOnTap;
  final Function? titleOnTap;
  final Widget? actionWidget;
  @override
  final Size preferredSize;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.backgroundColor,
      elevation: 0,
      centerTitle: true,
      leadingWidth: 80,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: (widget.leadingIcon != null) ? true : false,
      title: widget.title != null
          ? InkWell(
              onTap: (widget.titleOnTap != null)
                  ? () => widget.titleOnTap!()
                  : null,
              child: Text(
                widget.title!,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: AppTheme.textColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            )
          : null,
      leading: (widget.leadingIcon != null)
          ? Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: AppTheme.defaultPadding,
                    right: AppTheme.defaultPadding,
                  ),
                  child: InkWell(
                    child: Icon(
                      widget.leadingIcon!,
                      color: AppTheme.greyTint3,
                    ),
                    onTap: () => widget.leadingOnTap!(),
                  ),
                ),
              ],
            )
          : const SizedBox(),
      actions: [
        if (widget.actionWidget != null) widget.actionWidget!,
        if (widget.actionIcon != null)
          SizedBox(
            width: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: AppTheme.defaultPadding,
                    right: AppTheme.defaultPadding,
                  ),
                  child: InkWell(
                    child: Icon(
                      widget.actionIcon!,
                      color: AppTheme.greyTint3,
                    ),
                    onTap: () => widget.actionOnTap!(),
                  ),
                ),
              ],
            ),
          )
      ],
    );
  }
}

class _CustomAppBarSize extends Size {
  _CustomAppBarSize(this.toolbarHeight, this.bottomHeight)
      : super.fromHeight(
            (toolbarHeight ?? kToolbarHeight) + (bottomHeight ?? 0));

  final double? toolbarHeight;
  final double? bottomHeight;
}
