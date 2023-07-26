import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  final message = <String>[
    'Cargando películas',
    'Comprobando palomitas de maíz',
    'Cargando populares',
    'Ya mero ...',
    'Esto esta tardando más de lo esperado :(',
  ];

  Stream<String> getLoadingMessages() {
    return Stream.periodic(const Duration(milliseconds: 1200), (int step) {
      return message[step];
    }).take(message.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Cargando películas'),
          const SizedBox(height: 10),
          const CircularProgressIndicator(),
          const SizedBox(height: 10),
          StreamBuilder<String>(
            stream: getLoadingMessages(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const SizedBox.shrink();
              return Text(snapshot.data!);
            },
          ),
        ],
      ),
    );
  }
}
