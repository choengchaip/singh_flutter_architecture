import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/cores/context.dart';
import 'package:singh_architecture/repositories/banner_repository.dart';
import 'package:singh_architecture/styles/colors.dart';
import 'package:singh_architecture/widgets/banners/banner_item.dart';

class BannerHeadLine extends StatefulWidget {
  final IContext context;
  final IConfig config;

  BannerHeadLine({
    required this.context,
    required this.config,
  });

  @override
  State<StatefulWidget> createState() {
    return BannerHeadLineState();
  }
}

class BannerHeadLineState extends State<BannerHeadLine> {
  late StreamController<int> currentPageSC;
  late BannerRepository bannerRepository;

  @override
  void initState() {
    super.initState();

    this.currentPageSC = StreamController<int>();
    this.currentPageSC.add(0);

    this.bannerRepository = widget.context.repositories().bannerRepository();
    this.bannerRepository.fetch(isMock: true);
  }

  @override
  void dispose() {
    super.dispose();
    this.currentPageSC.close();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: this.bannerRepository.isLoadingSC.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == true) {
          return Container(
            height: 175,
            decoration: BoxDecoration(
              color: colorSecondary,
              borderRadius: BorderRadius.circular(16),
            ),
          );
        }

        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 175,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: PageView.builder(
                  onPageChanged: (currentPage) {
                    this.currentPageSC.add(currentPage);
                  },
                  itemCount: this.bannerRepository.items?.length ?? 0,
                  itemBuilder: (context, index) {
                    return BannerItem(
                      banner: this.bannerRepository.items?[index],
                    );
                  },
                ),
              ),
            ),
            StreamBuilder<int>(
              stream: this.currentPageSC.stream,
              builder: (context, snapshot) {
                return Container(
                  margin: EdgeInsets.only(
                    bottom: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        this.bannerRepository.items?.length ?? 0, (index) {
                      return AnimatedContainer(
                        duration: Duration(milliseconds: 250),
                        margin: EdgeInsets.only(
                          left: 8,
                          right: 8,
                        ),
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index == snapshot.data
                              ? colorPrimary
                              : colorGray,
                        ),
                      );
                    }),
                  ),
                );
              }
            )
          ],
        );
      },
    );
  }
}
