import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:picup/features/schedule/domain/entity/coures.dart';
import 'package:picup/util/constants.dart';

class ShowCourseWidget extends StatelessWidget {
  const ShowCourseWidget(
      {super.key, required this.courseInfo, required this.onTap});
  final Course courseInfo;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: ColorConstants.PRIMARY_50,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  courseInfo.name,
                  style: TextHeadersContatns.h2.copyWith(
                    color: ColorConstants.PRIMARY_500,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                child: Text(
                  'Days: ${courseInfo.getDays()}',
                  style: TextHeadersContatns.h4.copyWith(
                    color: ColorConstants.PRIMARY_500,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                child: Text(
                  'Time: ${DateFormat('h:mm a').format(courseInfo.startTime)} - ${DateFormat('h:mm a').format(courseInfo.endTime)}',
                  style: TextHeadersContatns.h4.copyWith(
                    color: ColorConstants.PRIMARY_500,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
