import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:support/models/rca_location.dart';
import 'package:support/models/rca_user.dart';
import 'package:support/pages/common/missingLocationAlert.dart';

class News extends StatelessWidget {
  const News({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("WIDGET BUILTED");
    RcaUser user = Provider.of<RcaUser>(context);
    RcaLocation location = user == null ? null : user.activeLocation();
    if (location == null) return MissingLocationAlert();
    return Center(child: Text("NEWS - " + location.name));
  }
}
