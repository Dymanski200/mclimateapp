import 'package:flutter/material.dart';
import 'data_field.dart';
import '../data.dart';
import '../../../constants.dart';
import 'package:provider/provider.dart';

class LoginCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 400),
      margin: EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DataField(
              hint: "Email",
              errorText: context.watch<LoginData>().emailError,
              onChanged: (text) {
                context.read<LoginData>().email = text;
              }),
          DataField(
              hint: "Пароль",
              isPassword: true,
              errorText: context.watch<LoginData>().passwordError,
              onChanged: (text) {
                context.read<LoginData>().password = text;
              }),
          InkWell(
            onTap: () {
              context.read<LoginData>().getCode(context);
            },
            child: Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(vertical: defaultPadding / 4),
              child: Stack(
                children: [
                  if (context.watch<LoginData>().isGetCodeBusy)
                    SizedBox(
                        width: 12,
                        height: 12,
                        child: CircularProgressIndicator()),
                  if (!context.watch<LoginData>().isGetCodeBusy)
                    Text(
                      "Забыли пароль?",
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              context.read<LoginData>().login(context);
            },
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              margin: EdgeInsets.only(top: defaultPadding / 2),
              padding: EdgeInsets.all(defaultPadding / 3),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
              ),
              child: Stack(
                children: [
                  if (!context.watch<LoginData>().isBusy)
                    Text(
                      "Войти",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  if (context.watch<LoginData>().isBusy)
                    SizedBox(
                        width: 21,
                        height: 21,
                        child: CircularProgressIndicator()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
