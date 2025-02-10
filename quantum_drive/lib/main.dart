import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/services.dart';
import 'package:quantum_drive/screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: '',
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.white,
              brightness: Brightness.dark,
              primary: const Color.fromARGB(255, 104, 168, 241),
              onPrimary: Colors.black,
              secondary: const Color(0xFF112b3c),
              onSecondary: const Color.fromARGB(255, 201, 124, 124),
              tertiary: const Color(0xff5b6670),
              primaryContainer: const Color.fromARGB(82, 106, 186, 233),
              onPrimaryContainer: const Color.fromARGB(255, 224, 224, 224),
              secondaryContainer: const Color.fromARGB(255, 84, 118, 250),
              onSecondaryContainer: const Color.fromARGB(255, 168, 167, 167),
              surface: const Color.fromARGB(255, 255, 255, 255),
              error: Colors.red,
              onError: Colors.white,
            ),
          ),
          home: Home()),
    );
  }
}
