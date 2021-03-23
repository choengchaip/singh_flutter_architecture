import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/cores/constants.dart';
import 'package:singh_architecture/cores/context.dart';
import 'package:singh_architecture/pages/account_page.dart';
import 'package:singh_architecture/pages/base_page.dart';
import 'package:singh_architecture/pages/cart_page.dart';
import 'package:singh_architecture/pages/home_page.dart';
import 'package:singh_architecture/pages/notification_page.dart';
import 'package:singh_architecture/repositories/page_repository.dart';
import 'package:singh_architecture/styles/colors.dart';
import 'package:singh_architecture/styles/fonts.dart';
import 'package:singh_architecture/utils/object_helper.dart';

class MainFeature extends StatefulWidget {
  final IContext context;
  final IConfig config;

  MainFeature({
    required this.context,
    required this.config,
  });

  @override
  State<StatefulWidget> createState() {
    return MainFeatureState();
  }
}

class MainFeatureState extends State<MainFeature> {
  late PageRepository pageRepository;

  @override
  void initState() {
    super.initState();

    this.pageRepository = PageRepository();
    this.pageRepository.initial();

    widget.context.repositories().cartRepository().fetch();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: widget.context.localeRepository().isLoadingSC.stream,
      builder: (context, snapshot) {
        if (ObjectHelper.isSnapshotStateLoading(snapshot)) {
          return Center(
            child: Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(colorSecondary),
              ),
            ),
          );
        }

        return Container(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: BasePage(
                    pageRepository: this.pageRepository,
                    widgets: [
                      HomePage(
                        context: widget.context,
                        config: widget.config,
                      ),
                      CartPage(
                        onBack: () {
                          this.pageRepository.prevPage();
                        },
                        checkoutPadding: EdgeInsets.only(
                          top: 16,
                          bottom: 16,
                          left: 24,
                          right: 24,
                        ),
                        context: widget.context,
                        config: widget.config,
                      ),
                      NotificationsPage(
                        context: widget.context,
                        config: widget.config,
                      ),
                      AccountPage(
                        context: widget.context,
                        config: widget.config,
                      ),
                    ],
                  ),
                ),
              ),
              StreamBuilder<int>(
                stream: this.pageRepository.pageIndexSC.stream,
                builder: (context, snapshot) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          color: colorGrayLight,
                          offset: Offset(0, -0.5),
                          blurRadius: 2)
                    ]),
                    padding: EdgeInsets.only(
                      top: 6,
                      bottom: 12 + MediaQuery.of(context).padding.bottom,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              this.pageRepository.jumpTo(0);
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: Column(
                                children: [
                                  Container(
                                    height: 30,
                                    width: 50,
                                    child: Icon(
                                      Icons.home_filled,
                                      color: snapshot.data == 0
                                          ? colorPrimary
                                          : colorGrayDark,
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      widget.context
                                          .localeRepository()
                                          .getString(Locales.home),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: s,
                                        color: snapshot.data == 0
                                            ? colorPrimary
                                            : colorGrayDark,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              this.pageRepository.jumpTo(1);
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: Column(
                                children: [
                                  Container(
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          height: 30,
                                          width: 50,
                                          child: Icon(
                                            Icons.shopping_cart,
                                            color: snapshot.data == 1
                                                ? colorPrimary
                                                : colorGrayDark,
                                          ),
                                        ),
                                        Positioned(
                                          top: -3,
                                          right: 1,
                                          child: StreamBuilder<bool>(
                                            stream: widget.context
                                                .repositories()
                                                .cartRepository()
                                                .isLoadingSC
                                                .stream,
                                            builder: (context, snapshot) {
                                              if (widget.context
                                                      .repositories()
                                                      .cartRepository()
                                                      .data
                                                      ?.Products
                                                      .length ==
                                                  0) {
                                                return Container();
                                              }

                                              return Container(
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(6),
                                                decoration: BoxDecoration(
                                                  color: colorSecondary,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Text(
                                                  widget.context
                                                          .repositories()
                                                          .cartRepository()
                                                          .data
                                                          ?.Products
                                                          .length
                                                          .toString() ??
                                                      "0",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      widget.context
                                          .localeRepository()
                                          .getString(Locales.cart),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: s,
                                        color: snapshot.data == 1
                                            ? colorPrimary
                                            : colorGrayDark,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              this.pageRepository.jumpTo(2);
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: Column(
                                children: [
                                  Container(
                                    height: 30,
                                    width: 50,
                                    child: Icon(
                                      Icons.notifications,
                                      color: snapshot.data == 2
                                          ? colorPrimary
                                          : colorGrayDark,
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      widget.context
                                          .localeRepository()
                                          .getString(Locales.notification),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: s,
                                        color: snapshot.data == 2
                                            ? colorPrimary
                                            : colorGrayDark,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              this.pageRepository.jumpTo(3);
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: Column(
                                children: [
                                  Container(
                                    height: 30,
                                    width: 50,
                                    child: Icon(
                                      Icons.account_circle_rounded,
                                      color: snapshot.data == 3
                                          ? colorPrimary
                                          : colorGrayDark,
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      widget.context
                                          .localeRepository()
                                          .getString(Locales.account),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: s,
                                        color: snapshot.data == 3
                                            ? colorPrimary
                                            : colorGrayDark,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
