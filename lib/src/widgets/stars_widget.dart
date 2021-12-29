import 'package:flutter/material.dart';

class StarsWidget extends StatefulWidget {
  final int length;
  final String? title;
  final bool enabled;
  final double iconSize;
  final int selectedLenght;
  final Color? selectedColor;
  final Color? unselectedColor;
  final void Function(int selectedLenght)? onChanged;

  const StarsWidget({
    Key? key,
    this.title,
    required this.length,
    this.enabled = true,
    this.selectedLenght = 0,
    this.selectedColor,
    this.unselectedColor,
    this.onChanged,
    this.iconSize = 28,
  })  : assert(length > 0),
        assert(length >= selectedLenght),
        super(key: key);

  @override
  _StarsWidgetState createState() => _StarsWidgetState();
}

class _StarsWidgetState extends State<StarsWidget> {
  @override
  Widget build(BuildContext context) {
    var selectedLenght = widget.selectedLenght;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (widget.title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              widget.title!,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            widget.length,
            (index) {
              final selected = selectedLenght > index;
              return GestureDetector(
                onTap: () {
                  if (widget.enabled) {
                    var isRepeat = selectedLenght != index + 1;
                    if (isRepeat) {
                      if (selectedLenght == 1 && index == 0) {
                        setState(() => selectedLenght = 0);
                      } else {
                        setState(() => selectedLenght = index + 1);
                      }
                      if (widget.onChanged != null) {
                        widget.onChanged?.call(selectedLenght);
                      }
                    }
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Icon(
                    Icons.star_rounded,
                    size: widget.iconSize,
                    color: selected
                        ? (widget.selectedColor ?? Theme.of(context).colorScheme.secondary)
                        : widget.unselectedColor ?? Theme.of(context).textTheme.headline5?.color,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
