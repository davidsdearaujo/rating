import 'package:flutter/material.dart';

import 'busy_indicator.dart';

class DefaultButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final double? height;
  final double? width;
  final bool outline;
  final Color? color;
  final Color textColor;
  final Color? outlineColor;
  final bool flat;
  final bool isLoading;
  final double radius;

  const DefaultButton({
    required this.child,
    required this.onPressed,
    Key? key,
    this.height = 50,
    this.width = 150,
    this.outline = true,
    this.color,
    this.textColor = const Color(0xFFF8D560),
    this.outlineColor,
    this.flat = false,
    this.isLoading = false,
    this.radius = 25,
  }) : super(key: key);

  DefaultButton.text(
    String text, {
    required this.onPressed,
    Key? key,
    this.height = 50,
    this.width = 150,
    this.outline = true,
    this.color,
    this.textColor = const Color(0xFFF8D560),
    this.outlineColor,
    this.flat = false,
    this.isLoading = false,
    this.radius = 25,
  })  : child = Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = ButtonStyle(
      elevation: MaterialStateProperty.all(flat ? 0 : 2),
      backgroundColor: MaterialStateProperty.all(color ?? Colors.white),
      foregroundColor: MaterialStateProperty.all(textColor),
      shape: MaterialStateProperty.all(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: (onPressed == null || !outline) ? BorderSide.none : BorderSide(color: outlineColor ?? textColor, width: 1),
      )),
    );

    final content = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Stack(
        children: [
          if (isLoading) ...{
            Positioned.fill(
              child: FittedBox(
                fit: BoxFit.none,
                child: BusyIndicator(size: 16.0, color: onPressed != null ? textColor : const Color(0xFFC5C5C5)),
              ),
            ),
          },
          Opacity(opacity: isLoading ? 0 : 1, child: child),
        ],
      ),
    );
    return Container(
      constraints: BoxConstraints(minWidth: width ?? double.infinity),
      height: height ?? 45.0,
      child: outline
          ? OutlinedButton(onPressed: onPressed, style: style, child: content)
          : TextButton(onPressed: onPressed, style: style, child: content),
    );
  }
}
