import 'package:flutter/material.dart';
import 'dart:math';

class Joystick extends StatefulWidget {
  final double size;
  final Color baseColor;
  final Color stickColor;
  final Color activeStickColor;
  final ValueChanged<Offset> onChanged;

  const Joystick({
    Key? key,
    required this.onChanged,
    this.size = 200,
    this.baseColor = Colors.grey,
    this.stickColor = Colors.blue,
    this.activeStickColor = Colors.lightBlue,
  }) : super(key: key);

  @override
  _JoystickState createState() => _JoystickState();
}

class _JoystickState extends State<Joystick> {
  double _x = 0;
  double _y = 0;
  bool _dragging = false;
  late double _radius;

  @override
  void initState() {
    super.initState();
    _radius = widget.size / 2;
  }

  void _updatePosition(Offset localPosition) {
    // Calculamos la posición desde el centro del joystick
    final dx = localPosition.dx - _radius;
    final dy = localPosition.dy - _radius;
    final distance = sqrt(dx * dx + dy * dy);

    double newX = dx;
    double newY = dy;

    // Limitamos la posición dentro del radio del joystick
    if (distance > _radius) {
      newX = (dx / distance) * _radius;
      newY = (dy / distance) * _radius;
    }

    setState(() {
      _x = newX;
      _y = newY;
    });

    // Normalizamos los valores entre -1 y 1
    widget.onChanged(Offset(
      _x / _radius,
      _y / _radius,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {
        setState(() => _dragging = true);
        _updatePosition(details.localPosition);
      },
      onPanUpdate: (details) => _updatePosition(details.localPosition),
      onPanEnd: (details) {
        setState(() {
          _dragging = false;
          _x = 0;
          _y = 0;
        });
        widget.onChanged(Offset.zero);
      },
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: widget.baseColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              spreadRadius: 2,
            )
          ],
        ),
        child: Center(
          child: Transform.translate(
            offset: Offset(_x, _y),
            child: Container(
              width: widget.size * 0.3,
              height: widget.size * 0.3,
              decoration: BoxDecoration(
                color: _dragging ? widget.activeStickColor : widget.stickColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 6,
                    spreadRadius: 2,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
