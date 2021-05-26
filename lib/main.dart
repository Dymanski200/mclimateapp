import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mclimate/pages/create_device/data.dart';
import 'package:mclimate/pages/create_profile/data.dart';
import 'package:mclimate/pages/create_room/data.dart';
import 'package:mclimate/pages/loading/page.dart';
import 'package:mclimate/pages/room_detail/data.dart';
import 'package:mclimate/pages/rooms/data.dart';
import 'package:mclimate/pages/url/data.dart';
import 'package:mclimate/pages/users/data.dart';
import 'constants.dart';
import 'package:provider/provider.dart';
import 'pages/code/data.dart';
import 'pages/create_rule/data.dart';
import 'pages/home/data.dart';
import 'pages/profiles/data.dart';
import 'pages/rules/data.dart';
import 'services/storage.dart' as storage;
import 'pages/loading/data.dart';
import 'pages/activation/data.dart';
import 'pages/password_change/data.dart';

void main() async {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UsersData>(create: (_) => UsersData()),
        ChangeNotifierProvider<CreateProfileData>(
            create: (_) => CreateProfileData()),
        ChangeNotifierProvider<UrlData>(create: (_) => UrlData()),
        ChangeNotifierProvider<CreateRuleData>(create: (_) => CreateRuleData()),
        ChangeNotifierProvider<RulesData>(create: (_) => RulesData()),
        ChangeNotifierProvider<CodeData>(create: (_) => CodeData()),
        ChangeNotifierProvider<ProfilesData>(create: (_) => ProfilesData()),
        ChangeNotifierProvider<CreateDeviceData>(
            create: (_) => CreateDeviceData()),
        ChangeNotifierProvider<ChangesData>(create: (_) => ChangesData()),
        ChangeNotifierProvider<RoomData>(create: (_) => RoomData()),
        ChangeNotifierProvider<CreateRoomData>(create: (_) => CreateRoomData()),
        ChangeNotifierProvider<DevicesData>(create: (_) => DevicesData()),
        ChangeNotifierProvider<PasswordChangeData>(
            create: (_) => PasswordChangeData()),
        ChangeNotifierProvider<LoginData>(create: (_) => LoginData()),
        ChangeNotifierProvider<RegistrationData>(
            create: (_) => RegistrationData()),
        ChangeNotifierProvider<ActivationData>(create: (_) => ActivationData()),
        ChangeNotifierProvider<RoomsData>(create: (_) => RoomsData()),
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
