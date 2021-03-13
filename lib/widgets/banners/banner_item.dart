import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singh_architecture/models/banner_model.dart';

class BannerItem extends StatefulWidget {
  final BannerModel? banner;

  BannerItem({
    required this.banner,
  });

  @override
  State<StatefulWidget> createState() {
    return BannerItemState();
  }
}

class BannerItemState extends State<BannerItem> {
  @override
  Widget build(BuildContext context) {
    print(widget.banner?.ImageURL);

    // return Container(
    //   child: Image.network(widget.banner!.ImageURL),
    // );

    return widget.banner != null
        ? CachedNetworkImage(
            imageUrl: "http://via.placeholder.com/350x150",
            progressIndicatorBuilder: (context, url, downloadProgress) {
              return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(value: downloadProgress.progress),
              );
            },
            errorWidget: (context, url, error) => Icon(Icons.error))
        : Container();
  }
}
