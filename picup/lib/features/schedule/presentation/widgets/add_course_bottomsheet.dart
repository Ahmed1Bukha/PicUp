import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:picup/common/presentation/app_button.dart';
import 'package:picup/common/presentation/app_textfield.dart';
import 'package:picup/features/schedule/domain/entity/coures.dart';
import 'package:picup/features/schedule/presentation/controllers/courses_controller.dart';
import 'package:picup/features/schedule/presentation/controllers/get_courses.dart';
import 'package:picup/features/schedule/presentation/widgets/day_clickable.dart';
import 'package:picup/util/app_spacing.dart';
import 'package:picup/util/constants.dart';
import 'package:uuid/uuid.dart';

final courseNameTextControllerProvider = Provider<TextEditingController>((ref) {
  return TextEditingController();
});

final fromTimeProvider = Provider<TextEditingController>((ref) {
  return TextEditingController();
});

final toTimeProvider = Provider<TextEditingController>((ref) {
  return TextEditingController();
});

final _formKey = GlobalKey<FormState>();

class AddCourseBottomsheet extends ConsumerStatefulWidget {
  AddCourseBottomsheet({this.id, this.initDays = const [], super.key});
  String? id;
  List<DaysCourse> initDays = [];

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddCourseBottomsheetState();
}

class _AddCourseBottomsheetState extends ConsumerState<AddCourseBottomsheet> {
  List<DaysCourse> daysSelected = [];
  bool isEmptySelected = false;
  @override
  void initState() {
    daysSelected.addAll(widget.initDays);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TimeOfDay? fromTime;
    TimeOfDay? toTime;

    var children = [
      DayClickable(
          day: "SUN",
          initValue: widget.initDays.contains(DaysCourse.sun),
          onclick: () {
            if (daysSelected.contains(DaysCourse.sun)) {
              daysSelected.remove(DaysCourse.sun);
            } else {
              daysSelected.add(DaysCourse.sun);

              setState(() {
                isEmptySelected = false;
              });
            }
          }),
      DayClickable(
          day: "MON",
          initValue: widget.initDays.contains(DaysCourse.mon),
          onclick: () {
            if (daysSelected.contains(DaysCourse.mon)) {
              daysSelected.remove(DaysCourse.mon);
            } else {
              daysSelected.add(DaysCourse.mon);
              setState(() {
                isEmptySelected = false;
              });
            }
          }),
      DayClickable(
          day: "TUE",
          initValue: widget.initDays.contains(DaysCourse.tue),
          onclick: () {
            if (daysSelected.contains(DaysCourse.tue)) {
              daysSelected.remove(DaysCourse.tue);
            } else {
              daysSelected.add(DaysCourse.tue);
              setState(() {
                isEmptySelected = false;
              });
            }
          }),
      DayClickable(
          day: "WED",
          initValue: widget.initDays.contains(DaysCourse.wed),
          onclick: () {
            if (daysSelected.contains(DaysCourse.wed)) {
              daysSelected.remove(DaysCourse.wed);
            } else {
              daysSelected.add(DaysCourse.wed);
              setState(() {
                isEmptySelected = false;
              });
            }
          }),
      DayClickable(
          day: "THU",
          initValue: widget.initDays.contains(DaysCourse.thu),
          onclick: () {
            if (daysSelected.contains(DaysCourse.thu)) {
              daysSelected.remove(DaysCourse.thu);
            } else {
              daysSelected.add(DaysCourse.thu);
              setState(() {
                isEmptySelected = false;
              });
            }
          }),
      DayClickable(
          day: "FRI",
          initValue: widget.initDays.contains(DaysCourse.fri),
          onclick: () {
            if (daysSelected.contains(DaysCourse.fri)) {
              daysSelected.remove(DaysCourse.fri);
            } else {
              daysSelected.add(DaysCourse.fri);
              setState(() {
                isEmptySelected = false;
              });
            }
          }),
      DayClickable(
          day: "SAT",
          initValue: widget.initDays.contains(DaysCourse.sat),
          onclick: () {
            if (daysSelected.contains(DaysCourse.sat)) {
              daysSelected.remove(DaysCourse.sat);
            } else {
              daysSelected.add(DaysCourse.sat);
              setState(() {
                isEmptySelected = false;
              });
            }
          })
    ];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Add Course",
              textAlign: TextAlign.center,
              style: TextHeadersContatns.h2.copyWith(
                fontWeight: FontWeight.bold,
                color: ColorConstants.PRIMARY_50,
              ),
            ),
            Center(
              child: AppTextfield(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  label: "Course Name",
                  hint: "ICS 108",
                  controller: ref.watch(courseNameTextControllerProvider)),
            ),
            AppSpacing.kSpaceY5,
            Text(
              "Repeats On",
              style: TextBodyConstants.bold14
                  .copyWith(color: ColorConstants.PRIMARY_200),
            ),
            AppSpacing.kSpaceY2,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: children,
            ),
            Visibility(
              visible: isEmptySelected,
              child: Text(
                "Please select at least one day",
                style: TextBodyConstants.bold12
                    .copyWith(color: ColorConstants.ERROR_COLOR),
              ),
            ),
            AppSpacing.kSpaceY6,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () async {
                    print("hello");
                    fromTime = await showTimePicker(
                      context: context,
                      initialTime: const TimeOfDay(hour: 8, minute: 0),
                    );
                    if (context.mounted && fromTime != null) {
                      ref.watch(fromTimeProvider).text =
                          fromTime!.format(context);
                    }
                  },
                  child: IgnorePointer(
                    child: AppTextfield(
                      enabled: false,
                      width: 100,
                      label: "From",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Select Time';
                        }
                        return null;
                      },
                      hint: "8:00 AM",
                      controller: ref.watch(fromTimeProvider),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    toTime = await showTimePicker(
                      context: context,
                      initialTime: const TimeOfDay(hour: 8, minute: 50),
                    );
                    if (context.mounted && toTime != null) {
                      ref.watch(toTimeProvider).text = toTime!.format(context);
                    }
                  },
                  child: IgnorePointer(
                    child: AppTextfield(
                      width: 100,
                      label: "To",
                      hint: "8:50 AM",
                      controller: ref.watch(toTimeProvider),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Select Time';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
            AppSpacing.kSpaceY10,
            AppButton(
              onTap: () async {
                if (daysSelected.isEmpty) {
                  setState(() {
                    isEmptySelected = true;
                  });
                } else {
                  setState(() {
                    isEmptySelected = false;
                  });
                }
                if (_formKey.currentState!.validate() &&
                    isEmptySelected == false) {
                  DateFormat format = DateFormat("hh:mm a");
                  var uuid = const Uuid();

                  final Course newCourse = Course(
                    name: ref.watch(courseNameTextControllerProvider).text,
                    days: daysSelected,
                    startTime: format.parse(ref.watch(fromTimeProvider).text),
                    endTime: format.parse(
                      ref.watch(toTimeProvider).text,
                    ),
                    id: widget.id ?? uuid.v1(),
                  );
                  final res;
                  if (widget.id != null) {
                    res = await ref
                        .watch(coursesControllerProvider.notifier)
                        .editCourse(newCourse);
                  } else {
                    res = await ref
                        .watch(coursesControllerProvider.notifier)
                        .addCourse(newCourse);
                  }

                  res.fold((l) => print(l), (r) {
                    context.pop(newCourse);

                    // return newCourse;
                  });
                }
              },
              text: "Add My Course",
            ),
            AppSpacing.kSpaceY10,
          ],
        ),
      ),
    );
  }
}
