import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:support/models/rca_location.dart';
import 'package:support/models/rca_user.dart';
import 'package:support/pages/common/missingLocationAlert.dart';
import 'package:support/pages/profile/renew_block.dart';

class Profile extends StatelessWidget {
  const Profile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("WIDGET BUILTED");
    RcaUser user = Provider.of<RcaUser>(context);
    RcaLocation location = user == null ? null : user.activeLocation();
    if (location == null) return MissingLocationAlert();
    return Container(
      padding: EdgeInsets.all(22),
      child: ListView(
        children: [
          RenewBlock(
            user: user,
            future: user.rinnoviMensili(),
            title: 'Canoni Mensili',
            icon: Icon(Icons.calendar_view_day),
            showIfZero: false,
          ),
          RenewBlock(
            user: user,
            future: user.rinnoviAnnuali(),
            title: 'Canoni Annuali',
            icon: Icon(CupertinoIcons.tickets),
            showIfZero: false,
          ),
          RenewBlock(
            user: user,
            future: user.rinnoviBiennali(),
            title: 'Canoni Biennali',
            icon: Icon(Icons.timeline),
            showIfZero: false,
          ),
          RenewBlock(
            user: user,
            future: user.rinnoviNewYear(),
            title: 'Canoni al 31/12',
            icon: Icon(CupertinoIcons.calendar),
            showIfZero: false,
          ),
          RenewBlock(
            user: user,
            future: user.rinnoviPrestitiAnnuali(),
            title: 'Prestiti Annuali',
            icon: Icon(Icons.shopping_bag),
            showIfZero: false,
          ),
        ],
      ),
    );
  }
}
