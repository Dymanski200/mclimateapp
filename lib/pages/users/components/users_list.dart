import 'package:flutter/material.dart';
import 'package:mclimate/constants.dart';
import 'package:mclimate/pages/users/components/user_card.dart';
import 'package:provider/provider.dart';
import '../data.dart';

class UsersList extends StatefulWidget {
  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  @override
  void initState() {
    super.initState();
    context.read<UsersData>().currentContext = context;
    context.read<UsersData>().refresh(context);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: secondaryColor,
      onRefresh: () async {
        context.read<UsersData>().refresh(context);
      },
      child: Stack(
        children: [
          ListView.builder(
              itemCount: context.read<UsersData>().users.length,
              itemBuilder: (context, i) {
                return UserCard(user: context.read<UsersData>().users[i]);
              }),
          if (context.watch<UsersData>().isBusy)
            Center(
              child: CircularProgressIndicator(),
            ),
          if (context.watch<UsersData>().isNotFound)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search_rounded,
                    color: Colors.white70,
                    size: 60,
                  ),
                  Text(
                    "Не найдено",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
