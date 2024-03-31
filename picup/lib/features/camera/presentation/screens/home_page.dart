import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:picup/features/camera/presentation/controllers/camera_controller.dart';
import 'package:picup/util/constants.dart';

late List<CameraDescription> _cameras;

final camereDescProvider = Provider<List<CameraDescription>?>((ref) {
  return null;
});

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(
        ref.read(camereDescProvider)![0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      body: Stack(
        children: [
          Align(alignment: Alignment.center, child: CameraPreview(controller)),
          Align(
            alignment: Alignment(0, 0.8),
            child: BlurryContainer(
              color: ColorConstants.PRIMARY_400.withOpacity(0.4),
              height: 110,
              width: MediaQuery.of(context).size.width - 15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        padding: EdgeInsets.all(0),
                        icon: SvgPicture.asset(
                          "assets/icons/Group.svg",
                          width: 45,
                        ),
                        onPressed: () {
                          context.go("/schedule");
                        },
                      ),
                      Text(
                        "Schedule",
                        style: TextBodyConstants.bold12
                            .copyWith(color: ColorConstants.PRIMARY_50),
                      )
                    ],
                  ),
                  IconButton(
                    icon: Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorConstants.PRIMARY_50,
                        ),
                        child: Center(
                            child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorConstants.PRIMARY_400,
                          ),
                        ))),
                    onPressed: () async {
                      final file = await controller.takePicture();

                      ref
                          .read(camerControllerProvider.notifier)
                          .savePhoto(path: file.path);
                    },
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        padding: EdgeInsets.all(0),
                        icon: SvgPicture.asset(
                          "assets/icons/Group (1).svg",
                          width: 45,
                        ),
                        onPressed: () {
                          context.go("/pictures");
                        },
                      ),
                      Text(
                        "My Folders",
                        style: TextBodyConstants.bold12
                            .copyWith(color: ColorConstants.PRIMARY_50),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
