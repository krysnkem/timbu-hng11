import 'package:flutter/material.dart';
import 'package:shop_bag_app/data/model.dart/product.dart';
import 'package:shop_bag_app/screens/products_listing.dart';
import 'package:shop_bag_app/screens/widgets/active_dot.dart';
import 'package:shop_bag_app/screens/widgets/double_product_widget.dart';
import 'package:shop_bag_app/screens/widgets/height4.dart';
import 'package:shop_bag_app/screens/widgets/height8.dart';
import 'package:shop_bag_app/utils/text_styles.dart';

class CategoryPageItems extends StatefulWidget {
  const CategoryPageItems({
    super.key,
    required this.categoryItems,
    required this.categoryName,
  });
  final List<List<Product>> categoryItems;
  final String categoryName;
  @override
  State<CategoryPageItems> createState() => _CategoryPageItemsState();
}

class _CategoryPageItemsState extends State<CategoryPageItems> {
  late final PageController pageController;
  int _activeIndex = 0;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final itemWidgets = <Widget>[];

    for (final item in widget.categoryItems) {
      itemWidgets.add(DoubleProductWidget(
        product1: item[0],
        product2: item[1],
      ));
    }
    return Builder(builder: (context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.categoryName,
            style: black20600,
          ),
          const Height8(),
          const Height4(),
          SizedBox(
            height: 320,
            child: PageView(
              controller: pageController,
              children: itemWidgets,
              onPageChanged: (value) {
                _activeIndex = value;
                setState(() {});
              },
            ),
          ),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...List.generate(
                  widget.categoryItems.length,
                  (index) {
                    return Row(
                      children: [
                        ActiveDot(
                          isActive: index == _activeIndex,
                        ),
                        const SizedBox(
                          width: 14,
                        ),
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        ],
      );
    });
  }
}
