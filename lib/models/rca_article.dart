import 'package:flutter/foundation.dart';

class RcaArticle {
  final String articleID;
  final String title;
  final String renew;
  final String price;
  final String imgPath;

  RcaArticle(
      {@required this.title,
      @required this.articleID,
      @required this.renew,
      @required this.price,
      @required this.imgPath});

  @override
  String toString() {
    String result = "RcaArticle: \n" +
        this.articleID +
        "\n" +
        this.title +
        "\n" +
        this.renew +
        "\n" +
        this.price +
        "\n";
    return result;
  }

  static double calculateTotal(List<RcaArticle> articles) {
    double total = 0;
    articles.forEach((element) {
      total += double.parse(element.price);
    });
    return total;
  }

  static RcaArticle fromMap(Map<String, dynamic> map) {
    return new RcaArticle(
        articleID: map['articleID'],
        title: map['title'],
        renew: map['renew'],
        price: map['price'],
        imgPath: map['imgPath']);
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'articleID': articleID,
      'renew': renew,
      'price': price,
      'imgPath': imgPath
    };
  }

  // Define that two Articles are equals if articleID is
  bool operator ==(other) {
    return (other is RcaArticle && other.articleID == articleID);
  }

  @override
  int get hashCode => 31 * int.parse(articleID);
}
