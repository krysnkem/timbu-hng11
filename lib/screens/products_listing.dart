import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_bag_app/data/model.dart/product.dart';
import 'package:shop_bag_app/state/app_state.dart';
import 'package:shop_bag_app/utils/colors.dart';
import 'package:shop_bag_app/utils/text_styles.dart';

class ProductsListing extends StatefulWidget {
  const ProductsListing({super.key});

  @override
  State<ProductsListing> createState() => _ProductsListingState();
}

class _ProductsListingState extends State<ProductsListing>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(
        leading: Image.asset(
          'assets/images/Malltiverse Logo.png',
          width: 100,
        ),
        title: Text(
          'Product List',
          style: black19600,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 24.0),
        child: Builder(builder: (context) {
          final appState = AppStateScope.of(context);

          if (!appState.isLoading && appState.error != null) {
            return RefreshIndicator(
              onRefresh: () async =>
                  AppStateWidget.of(context).initializeData(),
              child: ListView(
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height / 3,
                  ),
                  Center(
                    child: Text('${appState.error}'),
                  )
                ],
              ),
            );
          }

          if (appState.isLoading) {
            return RefreshIndicator(
              onRefresh: () async =>
                  AppStateWidget.of(context).initializeData(),
              child: ListView(
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height / 3,
                  ),
                  const Center(child: CircularProgressIndicator())
                ],
              ),
            );
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.asset('assets/images/Big Image Card (1).png'),
                    Positioned(
                      top: 0,
                      bottom: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(26.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Premium Sound, \nPremium Savings",
                              style: white20600,
                            ),
                            const Height8(),
                            Text(
                              "Limited offer, hope on and get yours now",
                              style: white12500,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 44,
                ),
                Builder(builder: (context) {
                  final shopingList = appState.allProducts;

                  if (shopingList.isEmpty) {
                    return RefreshIndicator(
                      onRefresh: () async =>
                          AppStateWidget.of(context).initializeData(),
                      child: ListView(
                        children: [
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height / 3,
                          ),
                          const Center(
                            child: Text('No products available'),
                          ),
                        ],
                      ),
                    );
                  }
                  return RefreshIndicator(
                    onRefresh: () async =>
                        AppStateWidget.of(context).initializeData(),
                    child: ListView.builder(
                      itemCount: appState.productMapping.keys.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final key =
                            appState.productMapping.keys.toList()[index];

                        String decoded = utf8.decode(key.runes.toList());
                        // Normalize the string to remove any non-standard characters
                        String normalized =
                            decoded.replaceAll(RegExp(r'[\uFFFD]'), '');
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 60.0),
                          child: CategoryPageItems(
                            categoryItems: appState.productMapping[key]!,
                            categoryName: capitalize(normalized),
                          ),
                        );
                      },
                    ),
                  );
                })
              ],
            ),
          );
        }),
      ),
    );
  }

  String capitalize(String text) {
    if (text.isEmpty) return text; // Return empty string if input is empty

    List<String> words = text.split(' ');
    List<String> capitalizedWords = words.map((word) {
      if (word.isEmpty) return word; // Return empty word if input word is empty
      return word.substring(0, 1).toUpperCase() + word.substring(1);
    }).toList();

    return capitalizedWords.join(' ');
  }

  @override
  bool get wantKeepAlive => true;
}

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

class ActiveDot extends StatelessWidget {
  const ActiveDot({super.key, required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    if (isActive) {
      return const FilledDot();
    } else {
      return const OutineDot();
    }
  }
}

class OutineDot extends StatelessWidget {
  const OutineDot({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: accentColor),
      ),
    );
  }
}

class FilledDot extends StatelessWidget {
  const FilledDot({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: accentColor,
      ),
    );
  }
}

class DoubleProductWidget extends StatelessWidget {
  const DoubleProductWidget({
    super.key,
    required this.product1,
    required this.product2,
  });

  final Product product1;
  final Product product2;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 150,
          child: Column(
            children: [
              CachedNetworkImage(
                key: ValueKey(product1.imageUrl),
                imageUrl: product1.imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: SizedBox(
                    height: 150,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ),
              ),
              const Height8(),
              const Height4(),
              Builder(builder: (context) {
                return ProductWidget(
                  itemName: product1.name,
                  itemDescription: product1.description,
                  price: '${product1.price}',
                  onAddToCart: () {
                    AppStateWidget.of(context).addToCart(product1);
                  },
                );
              })
            ],
          ),
        ),
        SizedBox(
          width: 150,
          child: Column(
            children: [
              CachedNetworkImage(
                key: ValueKey(product2.imageUrl),
                imageUrl: product2.imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: SizedBox(
                    height: 150,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ),
              ),
              const Height8(),
              const Height4(),
              Builder(builder: (context) {
                return ProductWidget(
                  itemName: product2.name,
                  itemDescription: product2.description,
                  price: '${product2.price}',
                  onAddToCart: () {
                    AppStateWidget.of(context).addToCart(product2);
                  },
                );
              })
            ],
          ),
        ),
      ],
    );
  }
}

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    super.key,
    required this.itemName,
    required this.itemDescription,
    required this.price,
    required this.onAddToCart,
  });

  final String itemName;
  final String itemDescription;
  final String price;
  final VoidCallback onAddToCart;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          itemName,
          style: black12600,
          maxLines: 1,
        ),
        const Height4(),
        Text(
          itemDescription,
          style: black12400,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const Height4(),
        const Row(
          children: [
            Icon(
              Icons.star,
              color: starGold,
              size: 16,
            ),
            Icon(
              Icons.star_border,
              color: starGold,
              size: 16,
            ),
          ],
        ),
        const Height8(),
        Text(
          'N $price',
          style: accent13500,
        ),
        const Height8(),
        const Height4(),
        Material(
          color: Colors.transparent,
          child: InkWell(
            customBorder: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onTap: onAddToCart,
            child: Ink(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: accentColor),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                'Add to Cart',
                style: black12500,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class Height4 extends StatelessWidget {
  const Height4({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 4,
    );
  }
}

class Height8 extends StatelessWidget {
  const Height8({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 8,
    );
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    super.key,
    required this.leading,
    required this.title,
  });

  final Widget leading;

  final Widget? title;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10,
        ), //adjust the padding as you want
        child: SafeArea(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: leading,
              ),
              const Spacer(),
              title ?? const SizedBox(),
              const Spacer(
                flex: 5,
              )
            ],
          ),
        ), //or row/any widget
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
