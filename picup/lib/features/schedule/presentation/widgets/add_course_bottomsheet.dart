import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:picup/common/presentation/app_button.dart';
import 'package:picup/common/presentation/app_textfield.dart';
import 'package:picup/features/schedule/domain/entity/coures.dart';
import 'package:picup/features/schedule/presentation/controllers/courses_controller.dart';
import 'package:picup/features/schedule/presentation/widgets/day_clickable.dart';
import 'package:picup/util/app_spacing.dart';
import 'package:picup/util/constants.dart';

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
  const AddCourseBottomsheet({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddCourseBottomsheetState();
}

class _AddCourseBottomsheetState extends ConsumerState<AddCourseBottomsheet> {
  @override
  Widget build(BuildContext context) {
    TimeOfDay? fromTime;
    TimeOfDay? toTime;
    List<DaysCourse> daysSelected = [];
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
                  label: "Course Name",
                  hint: "ICS 108",
                  controller: ref.watch(courseNameTextControllerProvider)),
            ),
            AppSpacing.kSpaceY5,
            Text(
              "Repeats On",
              style: TextBodyConstants.bold14.copyWith(color: Colors.white),
            ),
            AppSpacing.kSpaceY2,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DayClickable(
                    day: "SUN",
                    onclick: () {
                      if (daysSelected.contains(DaysCourse.sun)) {
                        daysSelected.remove(DaysCourse.sun);
                      } else {
                        daysSelected.add(DaysCourse.sun);
                      }
                    }),
                DayClickable(
                    day: "MON",
                    onclick: () {
                      if (daysSelected.contains(DaysCourse.mon)) {
                        daysSelected.remove(DaysCourse.mon);
                      } else {
                        daysSelected.add(DaysCourse.mon);
                      }
                    }),
                DayClickable(
                    day: "TUE",
                    onclick: () {
                      if (daysSelected.contains(DaysCourse.tue)) {
                        daysSelected.remove(DaysCourse.tue);
                      } else {
                        daysSelected.add(DaysCourse.tue);
                      }
                    }),
                DayClickable(
                    day: "WED",
                    onclick: () {
                      if (daysSelected.contains(DaysCourse.wed)) {
                        daysSelected.remove(DaysCourse.wed);
                      } else {
                        daysSelected.add(DaysCourse.wed);
                      }
                    }),
                DayClickable(
                    day: "THU",
                    onclick: () {
                      if (daysSelected.contains(DaysCourse.thu)) {
                        daysSelected.remove(DaysCourse.thu);
                      } else {
                        daysSelected.add(DaysCourse.thu);
                      }
                    }),
                DayClickable(
                    day: "FRI",
                    onclick: () {
                      if (daysSelected.contains(DaysCourse.fri)) {
                        daysSelected.remove(DaysCourse.fri);
                      } else {
                        daysSelected.add(DaysCourse.fri);
                      }
                    }),
                DayClickable(
                    day: "SAT",
                    onclick: () {
                      if (daysSelected.contains(DaysCourse.sat)) {
                        daysSelected.remove(DaysCourse.sat);
                      } else {
                        daysSelected.add(DaysCourse.sat);
                      }
                    })
              ],
            ),
            AppSpacing.kSpaceY6,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AppTextfield(
                  enabled: false,
                  width: 100,
                  label: "From",
                  hint: "8:00 AM",
                  controller: ref.watch(fromTimeProvider),
                  ontab: () async {
                    print("hello");
                    fromTime = await showTimePicker(
                      context: context,
                      initialTime: const TimeOfDay(hour: 8, minute: 0),
                    );
                    if (context.mounted) {
                      ref.watch(fromTimeProvider).text =
                          fromTime!.format(context);
                    }
                  },
                ),
                AppTextfield(
                  width: 100,
                  label: "To",
                  hint: "8:50 AM",
                  controller: ref.watch(toTimeProvider),
                  ontab: () async {
                    print("hello");
                    toTime = await showTimePicker(
                      context: context,
                      initialTime: const TimeOfDay(hour: 8, minute: 50),
                    );
                    if (context.mounted) {
                      ref.watch(toTimeProvider).text = toTime!.format(context);
                    }
                  },
                ),
              ],
            ),
            AppSpacing.kSpaceY10,
            AppButton(
              onTap: () async {
                DateFormat format = DateFormat("hh:mm a");

                final Course newCourse = Course(
                    name: ref.watch(courseNameTextControllerProvider).text,
                    days: daysSelected,
                    startTime: format.parse(ref.watch(fromTimeProvider).text),
                    endTime: format.parse(ref.watch(toTimeProvider).text));

                final res = await ref
                    .watch(coursesControllerProvider.notifier)
                    .addCourse(newCourse);
                res.fold((l) => print(l), (r) {
                  setState(() {
                    context.pop(newCourse);
                    // return newCourse;
                  });
                });
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
