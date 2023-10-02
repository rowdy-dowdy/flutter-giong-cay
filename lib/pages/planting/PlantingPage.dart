import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoom_widget/zoom_widget.dart';

class PlantingPage extends ConsumerStatefulWidget {
  const PlantingPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PlantingPageState();
}

class _PlantingPageState extends ConsumerState<PlantingPage> {
  // final _controller = TransformationController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    double deviceWidth = size.width;
    double deviceHeight = size.height - kToolbarHeight;
    // double scale = _controller.value.getMaxScaleOnAxis();
    double imageWidth = 1000;
    double imageHeight = 10000;
    // //Calculate the scale factor to fit the image to the screen (based on width)
    double scaleFactor = (deviceWidth / imageWidth);

    // _controller.value = Matrix4.identity() * scaleFactor;

    //             //optional: center the image on the screen
    //             //Center the canvas on the screen
    // _controller.value.setTranslationRaw(0,100,0);


    return Column(
      children: [
        AppBar(
          title: const Text('Planting').tr(),
          backgroundColor: Theme.of(context).colorScheme.background,
        ),
        Expanded(
          child: Container(
            width: size.width,
            height: size.height - kToolbarHeight,
            child: Zoom(
              // initTotalZoomOut: true,
              backgroundColor: Colors.transparent,
              initScale: scaleFactor,
              maxScale: scaleFactor * 10,
              // minScale: scaleFactor,
              // maxScale: scaleFactor * 10,
              // constrained: false,
              // boundaryMargin: EdgeInsets.symmetric(vertical: 500),
              // // clipBehavior: Clip.none,
              // transformationController: _controller,
              child: Container(
                // margin: const EdgeInsets.all(10),
                width: imageWidth,
                height: imageHeight,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("🥬"),
                        Container(width: imageWidth / 2, height: imageHeight / 2, color: Colors.blue,),
                      ],
                    ),
                    Row(
                      children: [
                        Container(width: imageWidth / 2, height: imageHeight / 2, color: Colors.blue,),
                        Container(width: imageWidth / 2, height: imageHeight / 2, color: Colors.red,),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        )
      ],
    );
  }
}