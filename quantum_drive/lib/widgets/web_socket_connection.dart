import 'package:flutter/material.dart';

class WebSocketConnection extends StatefulWidget {
  final Function(String ip, String port) onConnect;

  const WebSocketConnection({super.key, required this.onConnect});

  @override
  _WebSocketConnectionState createState() => _WebSocketConnectionState();
}

class _WebSocketConnectionState extends State<WebSocketConnection> {
  final TextEditingController _ipController = TextEditingController();
  final TextEditingController _portController = TextEditingController();

  @override
  void dispose() {
    _ipController.dispose();
    _portController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(
          horizontal: 50, vertical: 20), // Más estrecho
      child: Container(
        constraints: const BoxConstraints(maxWidth: 300), // Limita el ancho
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Conectar al WebSocket",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _ipController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "IP",
                    hintText: "Ej: 192.168.0.12",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: _portController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Puerto",
                    hintText: "Ej: 8000",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancelar"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        final String ip = _ipController.text.trim();
                        final String port = _portController.text.trim();
                        if (ip.isNotEmpty && port.isNotEmpty) {
                          widget.onConnect(ip, port);
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Ingresa IP y puerto")),
                          );
                        }
                      },
                      child: const Text("Conectar"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
