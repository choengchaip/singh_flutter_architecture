import 'package:flutter/cupertino.dart';

class CategoryItem extends StatefulWidget {
  final dynamic category;

  CategoryItem({
    required this.category,
  });

  @override
  State<StatefulWidget> createState() {
    return CategoryItemState();
  }
}

class CategoryItemState extends State<CategoryItem> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
