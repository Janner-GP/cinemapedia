import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getLoadingMessage (){
    final messages = <String>[
      'Abriendo el cine...',
      'Comprando entradas...',
      'Comprando las palomitas',
      'Preparanado la sala...',
      'Acomodando las butacas...',
      'Esta tarndando un poco...',
      'Ya casi'
    ];

    return Stream.periodic(const Duration(milliseconds: 1500), (int index) {
      return messages[index % messages.length];
    });
  }

  @override
  Widget build(BuildContext context) {

    final textStyle = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 25),
        const CircularProgressIndicator(),
        const SizedBox(height: 25),
        StreamBuilder<String>(
          stream: getLoadingMessage(),
          builder: (context, snapshot) {
            return Text(snapshot.data ?? 'Cargando...', style: textStyle.titleMedium,);
          }
        ),
      ],
    );
  }
}