import 'package:flutter/material.dart';
import 'package:mclimate/pages/create_profile/data.dart';
import 'package:mclimate/pages/create_profile/page.dart';
import 'package:mclimate/pages/profiles/data.dart';
import '../../constants.dart';
import 'components/profiles_list.dart';
import 'package:provider/provider.dart';

class ProfilesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: [
            Text("Выбор профиля"),
            Spacer(),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                context.read<CreateProfileData>().clear();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateProfilePage())).then(
                    (value) => context.read<ProfilesData>().refresh(context));
              },
            ),
          ],
        ),
      ),
      body: ProfilesList(),
    );
  }
}
