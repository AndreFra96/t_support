import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:support/models/rca_article.dart';
import 'package:support/tools/tools.dart';

class ArticleInfo extends StatelessWidget {
  final RcaArticle article;
  ArticleInfo({@required this.article});
  @override
  Widget build(BuildContext context) {
    print("https://www.rca-ordini.cloud/SITO/prev/" + article.imgPath);
    return GestureDetector(
      onTap: () => {print("tap")},
      child: Row(
        children: [
          Container(
            width: 60.0,
            height: 60.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              // border: Border.all(color: Colors.grey[300]),
            ),
            child: CachedNetworkImage(
              // imageUrl: "https://rca-ordini.cloud/SITO/" + article.imgPath,
              imageUrl:
                  "https://rca-ordini.cloud/SITO/uploads/logo-cassaincloud.png",
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
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
          )
        ],
      ),
    );
  }
}
