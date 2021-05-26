import 'package:flutter/material.dart';
import 'package:mclimate/pages/profiles/data.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import 'profile_card.dart';

class ProfilesList extends StatefulWidget {
  @override
  _ProfilesListState createState() => _ProfilesListState();
}

class _ProfilesListState extends State<ProfilesList> {
  @override
  void initState() {
    super.initState();
    context.read<ProfilesData>().currentContext = context;
    context.read<ProfilesData>().refresh(context);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: secondaryColor,
      onRefresh: () async {
        context.read<ProfilesData>().refresh(context);
      },
      child: Stack(
        children: [
          ListView.builder(
              itemCount: context.read<ProfilesData>().profiles.length,
              itemBuilder: (context, i) {
                return ProfileCard(context.read<ProfilesData>().profiles[i]);
              }),
          if (context.watch<ProfilesData>().isBusy)
            Center(
              child: CircularProgressIndicator(),
            ),
          if (context.watch<ProfilesData>().isNotFound)
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
