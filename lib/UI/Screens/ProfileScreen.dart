import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messaging_demo_flutter/Core/ChangeNotifiers/ProfileNotifier.dart';
import 'package:messaging_demo_flutter/Core/Helpers/Enums.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  static const TAG = "ProfileScreen";
  static const Route = "ProfileScreenRoute";

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProfileNotifier>(context, listen: false).fetchUserDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileNotifier>(context);
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("List"),
        ),
        body: Builder(
          builder: (ctx) {
            if (profileProvider.dataFetchingStatus ==
                DataFetchingStatus.fetching) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (profileProvider.dataFetchingStatus ==
                DataFetchingStatus.error) {
              return Center(
                child: Text(profileProvider.errorString),
              );
            } else if (profileProvider.user == null) {
              return Center(
                child: Text(profileProvider.errorString),
              );
            } else
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    profileProvider.user.avatar ?? "",
                    width: 200,
                    height: 200,
                  ),
                  Text("Name : ${profileProvider.user.name}"),
                  Text("Email : ${profileProvider.user.email}"),
                  Text("UID : ${profileProvider.user.id}"),
                  FlatButton(
                      onPressed: () async {
                        await profileProvider.updateProfile(
                            "Sahdeep Singh", "sahdeepsingh98@gmail.com");
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text(profileProvider.updateStatus ==
                                    DataFetchingStatus.error
                                ? profileProvider.updateErrorString
                                : "Update Successful")));
                      },
                      child: Text("Simulate Update")),
                  if (profileProvider.updateStatus ==
                      DataFetchingStatus.fetching)
                    CircularProgressIndicator()
                ],
              );
          },
        ));
  }
}
