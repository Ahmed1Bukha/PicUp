import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:picup/features/my_courses/data/repository/my_courses_repo_impl.dart';
import 'package:picup/features/schedule/domain/entity/coures.dart';

final getCoursesProvider = FutureProvider<List<Course>>((ref) async {
  return await ref.read(myCourseRepositoryProvider).getCourses();
});
