import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:quantum_drive/widgets/joystick.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Offset _leftJoystick = Offset.zero;
  Offset _rightJoystick = Offset.zero;

  @override
  Widget build(BuildContext context) {
    double joystickSize = 15.w; // Tamaño del joystick
    double margin = 4.w; // Margen desde los bordes

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Joystick izquierdo en la esquina superior izquierda
            Positioned(
              bottom: margin,
              left: margin,
              child: Joystick(
                size: joystickSize,
                baseColor: Theme.of(context).colorScheme.primaryContainer,
                stickColor: Theme.of(context).colorScheme.primary,
                activeStickColor: Theme.of(context).colorScheme.primary,
                onChanged: (offset) => setState(() => _leftJoystick = offset),
              ),
            ),

            // Joystick derecho en la esquina superior derecha
            Positioned(
              bottom: margin,
              right: margin,
              child: Joystick(
                size: joystickSize,
                baseColor: Theme.of(context).colorScheme.primaryContainer,
                stickColor: Theme.of(context).colorScheme.primary,
                activeStickColor: Theme.of(context).colorScheme.primary,
                onChanged: (offset) => setState(() => _rightJoystick = offset),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
