import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:support/models/rca_article.dart';
import 'package:support/pages/common/errorHandledImage.dart';
import 'package:support/tools/tools.dart';

class ArticleInfo extends StatelessWidget {
  final RcaArticle article;
  ArticleInfo({@required this.article});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => {
        showCupertinoDialog(
          barrierDismissible: true,
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
            title: SizedBox(
              width: 100,
              height: 100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ErrorHandledImage(
                  link: "https://rca-ordini.cloud/SITO/" + article.imgPath,
                  height: 80,
                  width: 80,
                  replace: Icon(Icons.error),
                ),
              ),
            ),
            content: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    article.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                Text(article.description),
              ],
            ),
            // actions: <Widget>[
            //   CupertinoDialogAction(
            //     onPressed: () => {Navigator.of(context).pop()},
            //     isDefaultAction: true,
            //     child: Text("Chiudi"),
            //   ),
            // ],
          ),
        ),
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          children: [
            Container(
              width: 60.0,
              height: 60.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                // border: Border.all(color: Colors.grey[300]),
              ),
              child: ErrorHandledImage(
                link: "https://rca-ordini.cloud/SITO/" + article.imgPath,
                height: 80,
                width: 80,
                replace: Icon(Icons.error),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 3, top: 3),
                  child: Text(
                    article.title,
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 3, top: 3),
                  child: Text(
                    "Rinnovo: " + Tools.convertDate(article.renew),
                    style: TextStyle(fontSize: 12),
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 3, top: 3),
                  child: Text(
                    "Prezzo: " + article.price + ",00 €",
                    style: TextStyle(fontSize: 12),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
