import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/utils/utils.dart';
import 'package:zoom_widget/zoom_widget.dart' as zoom;

class PlantingPage extends ConsumerStatefulWidget {
  const PlantingPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PlantingPageState();
}

class _PlantingPageState extends ConsumerState<PlantingPage> {
  final _controller = zoom.TransformationController();
  Key _zoomWidgetKey = UniqueKey();


  static const double widgetPadding = 12;
  static const double childWidth = 50;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: const Text('Planting').tr(),
          backgroundColor: Theme.of(context).colorScheme.background,
        ),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constrained) {
              _zoomWidgetKey = UniqueKey();
              var data = [
                ['🌱','🌱','🌱','🌱','🪴','🪴','🪴','🪴'],
                ['🌱','🌱','🌱','🌱','🌱','🌱','🌱','🌱'],
                ['🪴','🪴','🪴','🪴','🌱','🌱','🌱','🌱'],
                ['🪴','🪴','🪴','🪴','🌱','🌱','🌱','🌱'],
                ['🌱','🌱','🌱','🌱','🥀','🥀','🥀','🥀'],
                ['🌱','🌱','🌱','🌱','🥀','🥀','🥀','🥀'],
                ['🌵','🌵','🌵','🌵','🌵','🌵','🌵','🌵']
              ];

              int itemCol = data[0].length;
              int itemRow = data.length;

              double deviceWidth = constrained.maxWidth;
              double deviceHeight = constrained.maxHeight;

              double widgetWidth = childWidth * itemCol + widgetPadding * 2;
              double widgetHeight = childWidth * itemRow + widgetPadding * 2;

              double scaleFactor = (deviceWidth / widgetWidth);

              _controller.value = Matrix4.identity() * scaleFactor;

              return SizedBox(
                width: deviceWidth,
                height: deviceHeight,
                child: zoom.Zoom(
                  initTotalZoomOut: true,
                  backgroundColor: Colors.transparent,
                  // initScale: scaleFactor,
                  transformationController: _controller,
                  maxScale: 5,
                  key: _zoomWidgetKey,
                  child: Center(
                    child: Container(
                      width: widgetWidth,
                      height: widgetHeight,
                      padding: const EdgeInsets.all(widgetPadding),
                      child: Column(
                        children: data.asMap().map((i, row) {
                          return MapEntry(
                            i,
                            Row(
                              children: row.asMap().map((i2, col) {
                                return MapEntry(
                                  i2,
                                  InkWell(
                                    onTap: () => showBottomSheetCustom(
                                      context: context, 
                                      child: Center(child: Text(
                                        col,
                                        style: const TextStyle(fontSize: 100),
                                      ))
                                    ),
                                    child: Container(
                                      width: childWidth,
                                      height: childWidth,
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            width: 4,
                                            color: Theme.of(context).colorScheme.outline,
                                          ),
                                          left: (i % 2 != 0 && i2 % itemCol == 0) ? BorderSide(
                                            width: 4,
                                            color: Theme.of(context).colorScheme.outline,
                                          ) : BorderSide.none,
                                          right: (i > 0 && i % 2 == 0 && i2 - itemCol + 1 % itemCol == 0) ? BorderSide(
                                            width: 4,
                                            color: Theme.of(context).colorScheme.outline,
                                          ) : BorderSide.none,
                                        ),
                                      ),
                                      child: Text(
                                        col,
                                        style: const TextStyle(fontSize: 30),
                                      ),
                                    ),
                                  ),
                                );
                              }).values.toList(),
                            )
                          );
                        }).values.toList(),
                      ),
                    ),
                  ),
                ),
              );
            }
          )
        )
      ],
    );
  }
}

class ZoomableWidget extends StatefulWidget {
  @override
  _ZoomableWidgetState createState() => _ZoomableWidgetState();
}

class _ZoomableWidgetState extends State<ZoomableWidget> {
  double _scale = 1.0;
  double _previousScale = 1.0;

  void _onScaleStart(ScaleStartDetails details) {
    _previousScale = _scale;
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      _scale = _previousScale * details.scale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: Center(
          child: GestureDetector(
            onScaleStart: _onScaleStart,
            onScaleUpdate: _onScaleUpdate,
            child: Transform.scale(
              scale: _scale,
              child: Container(
                width: 2000,
                height: 2000,
                color: Colors.red,
              ),
            ),
          ),
        ),
      ),
    );
  }
}