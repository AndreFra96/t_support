import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:support/models/rca_user.dart';
import 'package:support/pages/chat/chat.dart';
import 'package:support/pages/news/news.dart';
import 'package:support/pages/profile/profile.dart';

class Index extends StatelessWidget {
  final List<Widget> _pages = <Widget>[
    CustomCupertinoPageScaffold(
      child: Chat(),
    ),
    CustomCupertinoPageScaffold(
      child: News(),
    ),
    CustomCupertinoPageScaffold(
      child: Profile(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    print("WIDGET BUILTED");
    return CupertinoApp(
        color: Colors.white,
        home: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            items: [
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.chat_bubble), label: "Chat"),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.news), label: "News"),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.person), label: "Profilo")
            ],
          ),
          tabBuilder: (BuildContext context, int index) {
            return _pages[index];
          },
        ));
  }
}

class CustomCupertinoPageScaffold extends StatelessWidget {
  final Widget child;
  CustomCupertinoPageScaffold({this.child});

  @override
  Widget build(BuildContext context) {
    print("WIDGET INDEX BUILTED");
    RcaUser user = Provider.of<RcaUser>(context);
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Image.asset(
            "assets/images/logorcatrasp.png",
            fit: BoxFit.contain,
            height: 64,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: FlatButton(
                      onPressed: () {
                        showCupertinoModalBottomSheet(
                          context: context,
                          builder: (context) => Material(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  leading: Text(
                                    user.ragsoc != null
                                        ? user.ragsoc.length > 25
                                            ? user.ragsoc.replaceRange(
                                                25, user.ragsoc.length, '...')
                                            : user.ragsoc
                                        : "Caricamento...",
                                    style: TextStyle(fontSize: 19),
                                  ),
                                  trailing: GestureDetector(
                                    onTap: () => user.logOut(),
                                    child: Icon(Icons.logout),
                                  ),
                                ),
                                Divider(
                                  height: 1,
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height - 300,
                                  child: ListView(
                                    children: [
                                      ...user.locations.entries
                                          .map((e) => ListTile(
                                                title: Text(e.value.address),
                                                leading:
                                                    Icon(Icons.my_location),
                                                onTap: () {
                                                  user.changeActiveLocation(
                                                      e.value.locationID);
                                                  Navigator.of(context).pop();
                                                },
                                              ))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 6.0, right: 6.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              CupertinoIcons.location,
                              color: Colors.white,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  user.ragsoc != null
                                      ? user.ragsoc.length > 15
                                          ? user.ragsoc.replaceRange(
                                              15, user.ragsoc.length, '...')
                                          : user.ragsoc
                                      : "Caricamento...",
                                  style: TextStyle(color: Colors.white),
                                ),
                                user.locations != null &&
                                        user.locations[user.activeLocationID] !=
                                            null
                                    ? Text(
                                        user.locations[user.activeLocationID]
                                                    .address.length >
                                                30
                                            ? user
                                                .locations[
                                                    user.activeLocationID]
                                                .address
                                                .replaceRange(
                                                    30,
                                                    user
                                                        .locations[user
                                                            .activeLocationID]
                                                        .address
                                                        .length,
                                                    '...')
                                            : user
                                                .locations[
                                                    user.activeLocationID]
                                                .address,
                                        style: TextStyle(color: Colors.white),
                                      )
                                    : Text(
                                        "Click per connettere un locale!",
                                        style: TextStyle(color: Colors.white),
                                      )
                              ],
                            ),
                            Icon(
                              Icons.control_point,
                              color: Colors.blue,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: child,
              )
            ],
          ),
        ));
  }
}
