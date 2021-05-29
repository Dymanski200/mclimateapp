import 'package:flutter/material.dart';
import '../../constants.dart';
import 'components/login_card.dart';
import 'components/registration_card.dart';
import 'package:provider/provider.dart';
import 'data.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<RegistrationData>().clear();
    context.read<LoginData>().clear();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: secondaryColor,
          appBar: AppBar(
            elevation: 0,
            title: Text("Добро пожаловать"),
            bottom: TabBar(
              tabs: [
                Tab(
                  text: "Авторизация",
                ),
                Tab(
                  text: "Регистрация",
                ),
              ],
            ),
          ),
          body: TabBarView(
            physics: BouncingScrollPhysics(),
            children: [
              Center(
                child: SingleChildScrollView(
                  child: LoginCard(),
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  child: RegistrationCard(),
                ),
              ),
            ],
          ),
        ));
  }
}
