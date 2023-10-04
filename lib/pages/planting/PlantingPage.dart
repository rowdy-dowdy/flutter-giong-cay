import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:zoom_widget/zoom_widget.dart';

class PlantingPage extends ConsumerStatefulWidget {
  const PlantingPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PlantingPageState();
}

class _PlantingPageState extends ConsumerState<PlantingPage> {
  final _controller = TransformationController();

  static const double widgetPadding = 12;
  static const double childWidth = 50;

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
              int row = 20;
              int col = 10;
              var twoDList = List<List>.generate(row, (i) => List<dynamic>.generate(col, (index) => null, growable: false), growable: false);
              double deviceWidth = constrained.maxWidth;
              double deviceHeight = constrained.maxHeight;

              double widgetWidth = childWidth * col + widgetPadding * 2;
              double widgetHeight = childWidth * row + widgetPadding * 2;

              double scaleFactor = (deviceWidth / widgetWidth);

              _controller.value = Matrix4.identity() * scaleFactor;

              double maxHeight = widgetWidth / deviceWidth * deviceHeight;
              double boundaryMargin = 0;
              if (widgetHeight < maxHeight) {
                boundaryMargin = deviceHeight + (widgetHeight - widgetWidth).abs();
              }
              print({widgetWidth, widgetHeight, maxHeight});
              print(boundaryMargin);

              double maxSize = maxHeight;
              if (widgetHeight > maxSize) {
                maxSize = widgetHeight;
              }
              print(maxSize);

              // _controller.value.setTranslationRaw(0,100,0);
              
              return SizedBox(
                width: deviceWidth,
                height: deviceHeight,
                child: InteractiveViewer(
                  minScale: scaleFactor,
                  maxScale: scaleFactor * 10,
                  constrained: false,
                  // boundaryMargin: EdgeInsets.symmetric(vertical: boundaryMargin),
                  transformationController: _controller,
                  child: Container(
                    color: Colors.green,
                    padding: const EdgeInsets.all(widgetPadding),
                    width: widgetWidth,
                    height: maxSize,
                    child: Column(
                      children: twoDList.map((row) => 
                        Row(
                          children: row.map((e) => 
                            Container(
                              width: childWidth,
                              height: childWidth,
                              color: Colors.red,
                            )
                          ).toList(),
                        )
                      ).toList(),
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