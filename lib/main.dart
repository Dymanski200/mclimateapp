import 'package:flutter/material.dart';
import 'package:mclimate/pages/loading/page.dart';
import 'package:mclimate/pages/rooms/data.dart';
import 'pages/home/page.dart';
import 'constants.dart';
import 'package:provider/provider.dart';
import 'pages/home/data.dart';
import 'services/storage.dart' as storage;
import 'pages/loading/data.dart';
import 'pages/activation/data.dart';
import 'pages/password_change/data.dart';

void main() async {
  runApp(MyApp());
  storage.setUrl("https://mclimate.somee.com");
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PasswordChangeData>(
            create: (_) => PasswordChangeData()),
        ChangeNotifierProvider<LoginData>(create: (_) => LoginData()),
        ChangeNotifierProvider<RegistrationData>(
            create: (_) => RegistrationData()),
        ChangeNotifierProvider<ActivationData>(create: (_) => ActivationData()),
        ChangeNotifierProvider<RoomsData>(create: (_) => RoomsData()),
        ChangeNotifierProvider<MyRoomsData>(create: (_) => MyRoomsData()),
        ChangeNotifierProvider<LoadingData>(create: (_) => LoadingData()),
      ],
      child: MaterialApp(
        title: "MClimate",
        theme: ThemeData(
          primaryColor: primaryColor,
          accentColor: Colors.white,
        ),
        home: LoadingPage(),
      ),
    );
  }
}
