import 'package:app_turismo/providers/conection_status_provider.dart';
import 'package:app_turismo/utils/check_internet_connection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WarningWidgetChangeNotifier extends StatelessWidget {
  const WarningWidgetChangeNotifier({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ConnectionStatusChangeNotifier(),
        child: Consumer<ConnectionStatusChangeNotifier>(
            builder: (context, value, child) {
          return Visibility(
            visible: value.status != ConnectionStatus.online,
            child: Container(
                padding: const EdgeInsets.all(16),
                height: 60,
                color: Colors.red,
                child: Row(
                  children: const [
                    Icon(Icons.wifi_off),
                    SizedBox(width: 8),
                    Text("No hay conexion a internet")
                  ],
                )),
          );
        }));
  }
}
