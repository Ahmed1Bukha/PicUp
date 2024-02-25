import 'package:flutter/material.dart';
import 'package:picup/util/constants.dart';

class DayClickable extends StatefulWidget {
  final String day;
  final Function onclick;
  const DayClickable({required this.day, required this.onclick, super.key});

  @override
  State<DayClickable> createState() => _DayClickableState();
}

class _DayClickableState extends State<DayClickable> {
  bool isClicked = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onclick();
        isClicked = !isClicked;
        setState(() {});
      },
      child: AnimatedContainer(
        width: 50,
        height: 50,
        duration: Durations.short3,
        decoration: BoxDecoration(
          color: isClicked
              ? ColorConstants.PRIMARY_50
              : ColorConstants.PRIMARY_500,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Text(
            widget.day,
            style: TextBodyConstants.regular14.copyWith(
                color: isClicked
                    ? ColorConstants.PRIMARY_500
                    : ColorConstants.PRIMARY_50),
          ),
        ),
      ),
    );
  }
}
