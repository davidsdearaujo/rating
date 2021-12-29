import 'package:flutter/material.dart';

import 'default_button.dart';

class CriterionButton extends StatefulWidget {
  final String text;
  final void Function(bool isSelected)? onSelectChange;
  final bool? intialSelectedValue;

  const CriterionButton({
    Key? key,
    required this.text,
    this.intialSelectedValue,
    this.onSelectChange,
  }) : super(key: key);

  @override
  _CriterionButtonState createState() => _CriterionButtonState();
}

class _CriterionButtonState extends State<CriterionButton> {
  late bool isSelected = widget.intialSelectedValue ?? false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        DefaultButton.text(
          widget.text,
          width: double.infinity,
          outlineColor: Theme.of(context).colorScheme.secondary,
          color: isSelected ? Theme.of(context).colorScheme.secondary.withOpacity(.2) : Colors.transparent,
          textColor: isSelected ? Theme.of(context).colorScheme.secondary : const Color(0xFF2F333A),
          flat: true,
          onPressed: () {
            setState(() => isSelected = !isSelected);
            widget.onSelectChange?.call(isSelected);
          },
        ),
      ],
    );
  }
}
