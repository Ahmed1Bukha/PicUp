import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gal/gal.dart';
import 'package:intl/intl.dart';
import 'package:picup/common/presentation/app_snackbar.dart';
import 'package:picup/features/camera/data/repository/camera_repository_impl.dart';
import 'package:picup/features/schedule/domain/entity/coures.dart';

class CameraControllerNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    //Return nottihn
  }
  Future<Either<Fail, String>> savePhoto({required File file}) async {
    final resCourses = await ref.read(cameraRepositoryProvider).getCourses();
    final path = file.path;
    return resCourses.fold((l) => Left(Fail(l)), (courses) async {
      DateTime now = DateTime.now();
      String dayName = DateFormat('EEEE').format(now);

      for (Course course in courses) {
        DateTime currentStartTime = DateTime(now.year, now.month, now.day,
            course.startTime.hour, course.startTime.minute);
        DateTime currentEndTime = DateTime(now.year, now.month, now.day,
            course.endTime.hour, course.endTime.minute);

        bool isBetween =
            now.isAfter(currentStartTime) && now.isBefore(currentEndTime);
        bool isDay = course.hasDay(course.getDayName(dayName));

        if (isBetween && isDay) {
          await Gal.putImage(path, album: course.name);
          return Right(course.name);
        }
      }
      return Left(Fail("No course found"));
    });
  }
}

final camerControllerProvider =
    AsyncNotifierProvider<CameraControllerNotifier, void>(
        CameraControllerNotifier.new);
