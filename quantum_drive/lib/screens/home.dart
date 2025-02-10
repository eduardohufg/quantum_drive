// home.dart
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import 'package:quantum_drive/widgets/joystick.dart';
import 'package:quantum_drive/widgets/web_socket_connection.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Offset _leftJoystick = Offset.zero;
  Offset _rightJoystick = Offset.zero;

  WebSocketChannel? _webSocketChannel;
  bool _isConnected = false;

  // Función para conectar al WebSocket
  void _connectToWebSocket(String ip, String port) {
    final String url = "ws://$ip:$port/ws/connection/joy";

    try {
      setState(() {
        _webSocketChannel = IOWebSocketChannel.connect(url);
        _isConnected = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Conectado a $url")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al conectar: $e")),
      );
    }
  }

  // Función para desconectar del WebSocket
  void _disconnectFromWebSocket() {
    if (_webSocketChannel != null) {
      _webSocketChannel!.sink.close();
      setState(() {
        _webSocketChannel = null;
        _isConnected = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Desconectado")),
      );
    }
  }

  // Función para enviar las coordenadas de los joysticks
  void _sendJoystickData() {
    if (_webSocketChannel != null && _isConnected) {
      final Map<String, dynamic> data = {
        "left_joystick": {"x": _leftJoystick.dx, "y": _leftJoystick.dy},
        "right_joystick": {"x": _rightJoystick.dx, "y": _rightJoystick.dy},
      };
      _webSocketChannel!.sink.add(data.toString());
    }
  }

  @override
  void dispose() {
    _webSocketChannel?.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double joystickSize = 15.w; // Tamaño del joystick
    final double margin = 4.w; // Margen desde los bordes

    return Scaffold(
      appBar: AppBar(
        title: const Text("Quantum Robotics Drive App"),
        actions: [
          IconButton(
            icon: Icon(_isConnected ? Icons.link : Icons.link_off),
            onPressed: () {
              if (_isConnected) {
                _disconnectFromWebSocket();
              } else {
                showDialog(
                  context: context,
                  builder: (context) => WebSocketConnection(
                    onConnect: _connectToWebSocket,
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            // Joystick izquierdo
            Positioned(
              bottom: margin,
              left: margin,
              child: Joystick(
                size: joystickSize,
                baseColor: Theme.of(context).colorScheme.primaryContainer,
                stickColor: Theme.of(context).colorScheme.primary,
                activeStickColor: Theme.of(context).colorScheme.primary,
                onChanged: (offset) {
                  setState(() => _leftJoystick = offset);
                  _sendJoystickData(); // Enviar datos al mover el joystick
                },
              ),
            ),

            // Joystick derecho
            Positioned(
              bottom: margin,
              right: margin,
              child: Joystick(
                size: joystickSize,
                baseColor: Theme.of(context).colorScheme.primaryContainer,
                stickColor: Theme.of(context).colorScheme.primary,
                activeStickColor: Theme.of(context).colorScheme.primary,
                onChanged: (offset) {
                  setState(() => _rightJoystick = offset);
                  _sendJoystickData(); // Enviar datos al mover el joystick
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
