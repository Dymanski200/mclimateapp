import 'package:flutter/material.dart';
import 'package:mclimate/models/user.dart';
import '../../../constants.dart';
import 'package:provider/provider.dart';

import '../data.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    Key key,
    @required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        context.read<UsersData>().delete(user.id);
      },
      child: Container(
        constraints: BoxConstraints(maxWidth: 400),
        margin: EdgeInsets.symmetric(
          horizontal: defaultPadding,
          vertical: defaultPadding / 2,
        ),
        padding: EdgeInsets.all(defaultPadding / 4),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.person, color: Colors.blueAccent, size: 100),
            Expanded(
              child: Text(
                "${user.surname} ${user.name} ${user.patronymic}",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
