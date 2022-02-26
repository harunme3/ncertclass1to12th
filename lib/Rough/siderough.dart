import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:ncertclass1to12th/Rough/sideroughstatus.dart';
import 'package:provider/provider.dart';

class SideRough extends StatefulWidget {
  const SideRough({Key? key}) : super(key: key);

  @override
  _SideRoughState createState() => _SideRoughState();
}

class DrawingArea {
  DrawingArea({required this.point, required this.areaPaint});

  Paint areaPaint;
  Offset point;
}

class _SideRoughState extends State<SideRough>
    with SingleTickerProviderStateMixin<SideRough> {
  List<DrawingArea> points = [];
  Color selectedColor = Colors.black;
  double strokeWidth = 2.0;

  late AnimationController _animationController;
  final _animationDuration = const Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Provider.of<SideRoughStatus>(context, listen: false).setisSideBarstatus =
          false;
      _animationController =
          AnimationController(vsync: this, duration: _animationDuration);
    });
  }

  void onIconPressed() {
    print('========================================');
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      Provider.of<SideRoughStatus>(context, listen: false).setisSideBarstatus =
          false;

      _animationController.reverse();
    } else {
      Provider.of<SideRoughStatus>(context, listen: false).setisSideBarstatus =
          true;

      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    void selectColor() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Color Chooser'),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: selectedColor,
              onColorChanged: (color) {
                setState(() {
                  selectedColor = color;
                });
              },
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Close"))
          ],
        ),
      );
    }

    return AnimatedPositioned(
        duration: _animationDuration,
        bottom: 0,
        left: Provider.of<SideRoughStatus>(context, listen: false)
                .getisSideBarstatus
            ? 0
            : width - 25,
        right: Provider.of<SideRoughStatus>(context, listen: false)
                .getisSideBarstatus
            ? 0
            : -width + 25,
        child: Row(
          children: [
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  onIconPressed();
                },
                child: ClipPath(
                  clipper: CustomMenuClipper(),
                  child: Container(
                    width: 25,
                    height: 50,
                    decoration: BoxDecoration(
                      backgroundBlendMode: BlendMode.darken,
                      gradient: LinearGradient(colors: const [
                        Color(0xFF2f5fe8),
                        Color(0xFF5b59ec),
                        Color(0xFF7d50ed),
                        Color(0xFF9c43ec),
                        Color(0xFFb82fe8),
                      ], begin: Alignment.topRight, end: Alignment.bottomLeft),
                    ),
                    alignment: Alignment.center,
                    child: Provider.of<SideRoughStatus>(context, listen: false)
                            .getisSideBarstatus
                        ? Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.white,
                          )
                        : Icon(
                            Icons.arrow_back_ios_outlined,
                            color: Colors.white,
                          ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  backgroundBlendMode: BlendMode.darken,
                  gradient: LinearGradient(colors: const [
                    Color(0xFF2f5fe8),
                    Color(0xFF5b59ec),
                    Color(0xFF7d50ed),
                    Color(0xFF9c43ec),
                    Color(0xFFb82fe8),
                  ], begin: Alignment.topRight, end: Alignment.bottomLeft),
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: width - 25,
                          height: height,
                          child: GestureDetector(
                            onPanDown: (details) {
                              setState(() {
                                points.add(DrawingArea(
                                    point: details.localPosition,
                                    areaPaint: Paint()
                                      ..strokeCap = StrokeCap.round
                                      ..isAntiAlias = true
                                      ..color = selectedColor
                                      ..strokeWidth = strokeWidth));
                              });
                            },
                            onPanUpdate: (details) {
                              setState(() {
                                points.add(
                                  DrawingArea(
                                      point: details.localPosition,
                                      areaPaint: Paint()
                                        ..strokeCap = StrokeCap.round
                                        ..isAntiAlias = true
                                        ..color = selectedColor
                                        ..strokeWidth = strokeWidth),
                                );
                              });
                            },
                            onPanEnd: (details) {
                              setState(() {
                                points.add(
                                  DrawingArea(
                                      point: Offset(0, 0),
                                      areaPaint: Paint()
                                        ..strokeCap = StrokeCap.round
                                        ..isAntiAlias = true
                                        ..color = selectedColor
                                        ..strokeWidth = strokeWidth),
                                );
                              });
                            },
                            child: SizedBox(
                              child: CustomPaint(
                                painter: MyCustomPainter(points: points),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: width - 25,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: <Widget>[
                                  IconButton(
                                      icon: Icon(
                                        Icons.color_lens,
                                        color: selectedColor,
                                      ),
                                      onPressed: () {
                                        selectColor();
                                      }),
                                  Expanded(
                                    child: Slider(
                                      min: 1.0,
                                      max: 5.0,
                                      label: "Stroke $strokeWidth",
                                      activeColor: selectedColor,
                                      value: strokeWidth,
                                      onChanged: (double value) {
                                        setState(() {
                                          strokeWidth = value;
                                        });
                                      },
                                    ),
                                  ),
                                  IconButton(
                                      icon: Icon(
                                        Icons.layers_clear,
                                        color: Colors.black,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          points.clear();
                                        });
                                      }),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}

class MyCustomPainter extends CustomPainter {
  MyCustomPainter({required this.points});

  List<DrawingArea> points;

  @override
  void paint(Canvas canvas, Size size) {
    for (int x = 0; x < points.length - 1; x++) {
      if (points[x].point != Offset(0, 0) &&
          points[x + 1].point != Offset(0, 0)) {
        canvas.drawLine(
            points[x].point, points[x + 1].point, points[x].areaPaint);
      } else if (points[x].point != Offset(0, 0) &&
          points[x + 1].point == Offset(0, 0)) {
        canvas.drawPoints(
            PointMode.points, [points[x].point], points[x].areaPaint);
      }
    }
  }

  @override
  bool shouldRepaint(MyCustomPainter oldDelegate) {
    return true;
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(width, 0);
    path.lineTo(0, height / 2);
    path.lineTo(width, height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
