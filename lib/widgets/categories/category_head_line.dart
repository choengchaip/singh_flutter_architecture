import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/cores/context.dart';
import 'package:singh_architecture/repositories/category_repository.dart';
import 'package:singh_architecture/styles/fonts.dart';

class CategoryHeadLine extends StatefulWidget {
  final IContext context;
  final IConfig config;
  final EdgeInsets? margin;

  CategoryHeadLine({
    required this.context,
    required this.config,
    this.margin,
  });

  @override
  State<StatefulWidget> createState() {
    return CategoryHeadLineState();
  }
}

class CategoryHeadLineState extends State<CategoryHeadLine> {
  late CategoryRepository categoryRepository;

  @override
  void initState() {
    super.initState();

    this.categoryRepository =
        widget.context.repositories().categoryRepository();
    this.categoryRepository.fetch(isMock: true);
  }

  @override
  void dispose() {
    super.dispose();

    this.categoryRepository.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double categoryWidth = ((MediaQuery.of(context).size.width) - 32) / 5;

    return StreamBuilder<bool>(
      stream: this.categoryRepository.isLoadingSC.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == true) {
          return Container();
        }

        return Container(
          alignment: Alignment.center,
          margin: widget.margin,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              ((this.categoryRepository.items?.length ?? 0) < 5
                  ? this.categoryRepository.items!.length
                  : 5),
              (index) {
                return Container(
                  width: categoryWidth - 8,
                  margin: EdgeInsets.all(4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: categoryWidth - 8,
                        width: categoryWidth - 8,
                        margin: EdgeInsets.only(
                          bottom: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.scaleDown,
                            image: CachedNetworkImageProvider(
                              this.categoryRepository.items![index].ImageURL,
                            )
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          this.categoryRepository.items![index].Title,
                          style: TextStyle(fontSize: s3),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
