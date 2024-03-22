import 'package:flutter/material.dart';
import 'package:picup/util/constants.dart';

class DayClickable extends StatefulWidget {
  final String day;
  final Function onclick;
  bool initValue;
  DayClickable(
      {required this.day,
      required this.onclick,
      super.key,
      this.initValue = false});

  @override
  State<DayClickable> createState() => _DayClickableState();
}

class _DayClickableState extends State<DayClickable> {
  bool isClicked = false;
  @override
  void initState() {
    isClicked = widget.initValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onclick();
        isClicked = !isClicked;
        setState(() {});
      },
      child: AnimatedContainer(
        width: 40,
        height: 40,
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
