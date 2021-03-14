import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/cores/context.dart';
import 'package:singh_architecture/repositories/product_repository.dart';
import 'package:singh_architecture/styles/colors.dart';
import 'package:singh_architecture/styles/fonts.dart';

class ProductHeadLine extends StatefulWidget {
  final IContext context;
  final IConfig config;
  final EdgeInsets? margin;
  final String title;
  final ProductRepository productRepository;

  ProductHeadLine({
    required this.context,
    required this.config,
    required this.title,
    required this.productRepository,
    this.margin,
  });

  @override
  State<StatefulWidget> createState() {
    return ProductHeadLineState();
  }
}

class ProductHeadLineState extends State<ProductHeadLine> {
  @override
  void initState() {
    super.initState();

    widget.productRepository.fetch(isMock: true);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: widget.productRepository.isLoadingSC.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == true) {
          return Container();
        }

        return Container(
          padding: EdgeInsets.only(
            top: 12,
            bottom: 12,
            left: 16,
            right: 16,
          ),
          margin: widget.margin,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  bottom: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: h6,
                          color: colorPrimary,
                          fontWeight: fontWeightBold,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        "ดูเพิ่มเติม >",
                        style: TextStyle(
                          fontSize: s2,
                          color: colorGray,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.productRepository.items?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              left: 8,
                              right: 8,
                            ),
                            height: 125,
                            width: 125,
                            child: CachedNetworkImage(
                                imageUrl: widget.productRepository.items![index]
                                    .ThumbnailURL,
                                imageBuilder: (context, image) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: image,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  );
                                },
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) {
                                  return Container(
                                    alignment: Alignment.center,
                                    child: CircularProgressIndicator(
                                        value: downloadProgress.progress),
                                  );
                                },
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error)),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              bottom: 8,
                            ),
                            height: 45,
                            width: 125,
                            child: Text(
                              widget.productRepository.items![index].Title,
                              style: TextStyle(
                                fontSize: h6,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            width: 125,
                            child: Text(
                              widget.productRepository.items![index].Price,
                              style: TextStyle(
                                color: colorSecondary,
                                fontSize: p,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
