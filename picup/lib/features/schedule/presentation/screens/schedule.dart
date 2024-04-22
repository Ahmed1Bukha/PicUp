import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:picup/common/presentation/app_progress_indicator.dart';
import 'package:picup/features/schedule/domain/entity/coures.dart';
import 'package:picup/features/schedule/presentation/controllers/courses_controller.dart';
import 'package:picup/features/schedule/presentation/controllers/get_courses.dart';
import 'package:picup/features/schedule/presentation/controllers/get_days_num.dart';
import 'package:picup/features/schedule/presentation/widgets/add_course_bottomsheet.dart';

import 'package:picup/util/constants.dart';
import 'package:time_planner/time_planner.dart';

class SchedulePage extends ConsumerStatefulWidget {
  const SchedulePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SchedulePageState();
}

class _SchedulePageState extends ConsumerState<SchedulePage> {
  var headers2 = [
    TimePlannerTitle(
      title: "SUN",
      titleStyle:
          TextBodyConstants.bold14.copyWith(color: ColorConstants.PRIMARY_400),
    ),
    TimePlannerTitle(
      title: "MON",
      titleStyle:
          TextBodyConstants.bold14.copyWith(color: ColorConstants.PRIMARY_400),
    ),
    TimePlannerTitle(
      title: "TUE",
      titleStyle:
          TextBodyConstants.bold14.copyWith(color: ColorConstants.PRIMARY_400),
    ),
    TimePlannerTitle(
      title: "WED",
      titleStyle:
          TextBodyConstants.bold14.copyWith(color: ColorConstants.PRIMARY_400),
    ),
    TimePlannerTitle(
      title: "THU",
      titleStyle:
          TextBodyConstants.bold14.copyWith(color: ColorConstants.PRIMARY_400),
    ),
    TimePlannerTitle(
      title: "FRI",
      titleStyle:
          TextBodyConstants.bold14.copyWith(color: ColorConstants.PRIMARY_400),
    ),
    TimePlannerTitle(
      title: "SAT",
      titleStyle:
          TextBodyConstants.bold14.copyWith(color: ColorConstants.PRIMARY_400),
    ),
  ];
  final List<TimePlannerTask> list = [];
  @override
  Widget build(BuildContext context) {
    void deleteTask(Course course) {
      list.removeWhere((task) => task.id == course.id);
    }

    getTimeTask(Course course) {
      List<TimePlannerTask> tempo = [];
      for (DaysCourse day in course.days) {
        print(course.startTime);
        tempo.add(TimePlannerTask(
          id: course.id,
          onTap: () async {
            final res = await showDialog(
              context: context,
              builder: (context) => getDialog(
                ref,
                context,
                course,
              ),
            );
            if (res == true) {
              print('its removed');

              ref.invalidate(getCoursesProvider);
            }
            setState(() {});
          },
          color: ColorConstants.PRIMARY_400,
          minutesDuration:
              ((course.endTime.hour - course.startTime.hour) * 60) +
                  (course.endTime.minute - course.startTime.minute),
          dateTime: TimePlannerDateTime(
              day: getDayNum(day),
              hour: course.startTime.hour + 1,
              minutes: course.startTime.minute),
          child: Text(
            course.name,
            style: TextBodyConstants.bold12
                .copyWith(color: ColorConstants.PRIMARY_50),
            textAlign: TextAlign.center,
          ),
        ));
      }
      list.addAll(tempo);
      return tempo;
    }

    final coursesProvider = ref.watch(getCoursesProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: Text(
                    "Finish Term",
                    style: TextStyle(
                        color: ColorConstants.PRIMARY_50,
                        fontWeight: FontWeight.bold),
                  ),
                  value: 1,
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Text("Finish Term"),
                              content: const Text(
                                  "Are you sure you want to finish the term? This will delete all the courses."),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    context.pop();
                                  },
                                  child: const Text(
                                    "Cancel",
                                    style: TextStyle(
                                        color: ColorConstants.PRIMARY_50),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    final res = await ref
                                        .read(
                                            coursesControllerProvider.notifier)
                                        .deleteAllCourses();
                                    res.fold((l) => (l), (r) {
                                      context.pop();
                                      ref.invalidate(getCoursesProvider);
                                      setState(() {});
                                    });
                                  },
                                  child: Text(
                                    "Finish",
                                    style: TextStyle(
                                        color: ColorConstants.PRIMARY_50),
                                  ),
                                )
                              ],
                            ));
                  },
                )
              ];
            },
          )
        ],
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Schedule",
            style: TextHeadersContatns.h3.copyWith(
                color: ColorConstants.PRIMARY_50, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: coursesProvider.when(
        data: (courses) {
          list.clear();
          courses.map((course) {
            print(getTimeTask(course));
            list.addAll(getTimeTask(course));
          }).toList();
          print(list);
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                ref.invalidate(courseNameTextControllerProvider);
                ref.invalidate(fromTimeProvider);
                ref.invalidate(toTimeProvider);
                final res = await addBottomSheet(context);
                ref.invalidate(getCoursesProvider);
                setState(() {});
              },
              backgroundColor: ColorConstants.PRIMARY_400,
              tooltip: "Add Course",
              child: const Icon(
                Icons.add,
                color: ColorConstants.PRIMARY_100,
              ),
            ),
            body: TimePlanner(
              tasks: list,
              style: TimePlannerStyle(
                  cellWidth: 50,
                  cellHeight: 50,
                  backgroundColor: ColorConstants.PRIMARY_100,
                  dividerColor: ColorConstants.PRIMARY_500),
              startHour: 0,
              endHour: 23,
              headers: headers2,
            ),
          );
        },
        error: (error, stackTrace) => SizedBox(
          child: Text(error.toString()),
        ),
        loading: () => const AppProgressIndicator(),
      ),
    );
  }

  Future<Course?> addBottomSheet(BuildContext context) {
    return showModalBottomSheet<Course>(
      backgroundColor: ColorConstants.PRIMARY_400,
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: AddCourseBottomsheet(),
      ),
    );
  }

  AlertDialog getDialog(WidgetRef ref, BuildContext context, Course course) {
    return AlertDialog(
      title: Text(course.name),
      actions: [
        TextButton(
          onPressed: () async {
            final res = await ref
                .read(coursesControllerProvider.notifier)
                .deleteCourse(course);

            res.fold((l) => (l), (r) {
              context.pop(true);
              ref.invalidate(getCoursesProvider);
            });
          },
          child: Text(
            "Delete",
            style: TextStyle(color: ColorConstants.PRIMARY_50),
          ),
        ),
        TextButton(
          onPressed: () async {
            context.pop();
            String fromTime = DateFormat('h:mm a')
                .format(DateTime.parse(course.startTime.toString()));
            String toTime = DateFormat('h:mm a')
                .format(DateTime.parse(course.endTime.toString()));
            print(fromTime);

            ref.read(courseNameTextControllerProvider).text = course.name;
            ref.read(fromTimeProvider).text = fromTime;
            ref.read(toTimeProvider).text = toTime;
            final res = await showModalBottomSheet<Course>(
              backgroundColor: ColorConstants.PRIMARY_400,
              context: context,
              isScrollControlled: true,
              builder: (context) => Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: AddCourseBottomsheet(
                  initDays: course.days,
                  id: course.id,
                ),
              ),
            );
            //TODO: see how to update the thing.
            if (res != null) {
              // return res;
              ref.invalidate(getCoursesProvider);
              setState(() {});
            }
          },
          child: Text(
            "Edit",
            style: TextStyle(color: ColorConstants.PRIMARY_50),
          ),
        )
      ],
    );
  }
}
