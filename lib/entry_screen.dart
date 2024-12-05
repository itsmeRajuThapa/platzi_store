import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:platzi_store/auth/loginScreen.dart';
import 'package:platzi_store/common/interne_connection_widget.dart';
import 'package:platzi_store/home/screen/homeScreen.dart';
import 'package:platzi_store/services/service_locator.dart';
import 'package:platzi_store/services/shared_preference_service.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({super.key});

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  @override
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? token = locator<SharedPrefsServices>().getString(key: 'token');

    return Stack(
      children: [
        token == null ? const LoginScreen() : const HomeScreen(),
        InternatConnectionWidget(
            offlineWidget: Align(
              alignment: Alignment.center,
              child: Container(
                  decoration: const BoxDecoration(color: Colors.red),
                  child: const Text('No Internet',
                      style: TextStyle(fontSize: 20))),
            ),
            onlineWidget: const SizedBox()),
      ],
    );
  }
}
