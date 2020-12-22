import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:support/models/rca_article.dart';
import 'package:support/models/rca_user.dart';
import 'package:support/pages/common/borderedIcon.dart';
import 'package:support/pages/profile/article_info.dart';

class RenewBlock extends StatelessWidget {
  const RenewBlock(
      {Key key,
      @required this.user,
      @required this.future,
      @required this.title,
      @required this.icon})
      : super(key: key);

  final RcaUser user;
  final Future<List<RcaArticle>> future;
  final String title;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          List<RcaArticle> articles = snapshot.data;
          print(articles);
          double blockTotal = RcaArticle.calculateTotal(articles);
          if (articles.length > 0) {
            return Column(children: [
              Material(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ExpandablePanel(
                    header: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BorderedIcon(
                            icon: icon,
                            width: 35,
                            height: 35,
                          ),
                          Text(
                            title,
                            style: TextStyle(fontSize: 18),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text("  " + blockTotal.toString() + " € ")
                        ],
                      ),
                    ),
                    expanded: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          ...articles.map((e) => ArticleInfo(article: e)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              )
            ]);
          } else {
            return SizedBox.shrink();
          }
        }
        if (snapshot.hasError) return Text("ERROR");
        return Text("loading");
      },
    );
  }
}
