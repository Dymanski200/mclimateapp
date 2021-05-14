import 'package:flutter/material.dart';
import 'components/data_field.dart';
import 'data.dart';
import '../../constants.dart';
import 'package:provider/provider.dart';

class PasswordChangePage extends StatelessWidget {
  final String email;
  PasswordChangePage(this.email);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        elevation: 0,
        title: Text("Смена пароля"),
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
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
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.symmetric(vertical: defaultPadding / 4),
                  child: Text(
                    "На адрес ${email.toLowerCase()} было отправлено письмо с кодом подтверждения",
                    softWrap: true,
                    style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                DataField(
                    hint: "Код",
                    isPassword: true,
                    errorText: context.watch<PasswordChangeData>().codeError,
                    onChanged: (text) {
                      context.read<PasswordChangeData>().code = text;
                    }),
                DataField(
                    hint: "Новый пароль",
                    isPassword: true,
                    errorText:
                        context.watch<PasswordChangeData>().passwordError,
                    onChanged: (text) {
                      context.read<PasswordChangeData>().password = text;
                    }),
                DataField(
                    hint: "Повторите пароль",
                    isPassword: true,
                    errorText: context
                        .watch<PasswordChangeData>()
                        .confirmPasswordError,
                    onChanged: (text) {
                      context.read<PasswordChangeData>().confirmPassword = text;
                    }),
                InkWell(
                  onTap: () {
                    context
                        .read<PasswordChangeData>()
                        .changePassword(context, email);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    margin: EdgeInsets.only(top: defaultPadding / 2),
                    padding: EdgeInsets.all(defaultPadding / 3),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius:
                          BorderRadius.all(Radius.circular(defaultRadius)),
                    ),
                    child: Stack(
                      children: [
                        if (!context.watch<PasswordChangeData>().isBusy)
                          Text(
                            "Подтвердить",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        if (context.watch<PasswordChangeData>().isBusy)
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
          ),
        ),
      ),
    );
  }
}
