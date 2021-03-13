import 'package:flutter/cupertino.dart';
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
  late BannerRepository bannerRepository;

  @override
  void initState() {
    super.initState();

    this.bannerRepository = widget.context.repositories().bannerRepository();
    this.bannerRepository.fetch(isMock: true);
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

          return Container(
            height: 175,
            decoration: BoxDecoration(
              color: colorPrimary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: PageView.builder(
              itemCount: this.bannerRepository.items?.length ?? 0,
              itemBuilder: (context, index) {
                return BannerItem(
                  banner: this.bannerRepository.items?[index],
                );
              },
            ),
          );
        });
  }
}
