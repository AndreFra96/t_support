import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ErrorHandledImage extends StatelessWidget {
  const ErrorHandledImage({
    Key key,
    @required this.link,
    @required this.replace,
    @required this.width,
    @required this.height,
  }) : super(key: key);

  final String link;
  final Widget replace;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Dio().get(
        link,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          },
        ),
      ),
      builder:
          (BuildContext context, AsyncSnapshot<Response<dynamic>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.statusCode != 404) {
            return CachedNetworkImage(
              imageBuilder: (context, imageProvider) => Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: imageProvider, fit: BoxFit.contain),
                ),
              ),
              imageUrl: link,
              placeholder: (context, url) => Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
              ),
              errorWidget: (context, url, error) => replace,
            );
          } else {
            return replace;
          }
        }

        if (snapshot.hasError) {
          return replace;
        }

        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey[100])),
        );
      },
    );
  }
}
