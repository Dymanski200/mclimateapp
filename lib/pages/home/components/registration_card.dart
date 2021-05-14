import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'data_field.dart';
import '../data.dart';
import 'package:provider/provider.dart';

class RegistrationCard extends StatelessWidget {
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
            errorText: context.watch<RegistrationData>().emailError,
            onChanged: (text) {
              context.read<RegistrationData>().email = text;
            },
          ),
          DataField(
            hint: "Пароль",
            isPassword: true,
            errorText: context.watch<RegistrationData>().passwordError,
            onChanged: (text) {
              context.read<RegistrationData>().password = text;
            },
          ),
          DataField(
            hint: "Повторите пароль",
            isPassword: true,
            errorText: context.watch<RegistrationData>().confirmPasswordError,
            onChanged: (text) {
              context.read<RegistrationData>().confirmPassword = text;
            },
          ),
          DataField(
            hint: "Фамилия",
            errorText: context.watch<RegistrationData>().surnameError,
            onChanged: (text) {
              context.read<RegistrationData>().surname = text;
            },
          ),
          DataField(
            hint: "Имя",
            errorText: context.watch<RegistrationData>().nameError,
            onChanged: (text) {
              context.read<RegistrationData>().name = text;
            },
          ),
          DataField(
            hint: "Отчество",
            errorText: context.watch<RegistrationData>().patronymicError,
            onChanged: (text) {
              context.read<RegistrationData>().patronymic = text;
            },
          ),
          InkWell(
            onTap: () {
              context.read<RegistrationData>().registration(context);
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
                  if (!context.watch<RegistrationData>().isBusy)
                    Text(
                      "Создать аккаунт",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  if (context.watch<RegistrationData>().isBusy)
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
