import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_bag_app/data/api/result.dart';
import 'package:shop_bag_app/data/model.dart/product.dart';
import 'package:shop_bag_app/screens/my_cart.dart';
import 'package:shop_bag_app/state/app_state.dart';
import 'package:shop_bag_app/utils/text_styles.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.productId});

  final String productId;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late Future<Object> getProductDetail;

  @override
  void initState() {
    super.initState();
    getProduct();
  }

  void getProduct() {
    getProductDetail = AppStateWidget.of(context)
        .apiClient
        .getProduct(productId: widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Product Detail',
          style: pageTitleStyle,
        ),
      ),
      body: FutureBuilder(
        future: getProductDetail,
        builder: (context, snapshot) {
          return switch (snapshot.connectionState) {
            // TODO: Handle this case.
            ConnectionState.active => const Center(
                child: CircularProgressIndicator(),
              ),

            // TODO: Handle this case.
            ConnectionState.none => const Center(
                child: CircularProgressIndicator(),
              ),
            // TODO: Handle this case.
            ConnectionState.waiting => const Center(
                child: CircularProgressIndicator(),
              ),
            // TODO: Handle this case.
            ConnectionState.done => () {
                if (snapshot.hasData) {
                  if (snapshot.data is Failure) {
                    return const Center(
                      child: Text('Unable to get product'),
                    );
                  } else {
                    final result = snapshot.data as Success;

                    final data = result.data as Product;

                    final bool isInCart =
                        AppStateScope.of(context).cartItems.any(
                              (element) => element.product == data,
                            );
                    return ProductDetailView(
                      image: data.image,
                      name: data.name,
                      price: '${data.price}',
                      description: data.description,
                      onAddToCart: () {
                        if (!isInCart) {
                          AppStateWidget.of(context).addToCart(data);
                        } else {
                          AppStateWidget.of(context).deleteFromCart(data);
                        }
                      },
                      isInCart: isInCart,
                    );
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }(),
          };
        },
      ),
    );
  }
}

class ProductDetailView extends StatelessWidget {
  const ProductDetailView({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.description,
    required this.onAddToCart,
    required this.isInCart,
  });

  final String image;
  final String name;
  final String price;
  final String description;
  final VoidCallback onAddToCart;
  final bool isInCart;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 7,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).height / 2,
                  child: Builder(builder: (context) {
                    if (!image.startsWith('http')) {
                      return Image.asset(
                        width: double.infinity,
                        key: ValueKey(image),
                        image,
                        fit: BoxFit.cover,
                      );
                    } else {
                      return CachedNetworkImage(
                        key: ValueKey(image),
                        width: double.infinity,
                        imageUrl: image,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  }),
                ),
                const SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              name,
                              style: black24500,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Text(
                            '₦$price',
                            style: black24500,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        description,
                        style: black16400,
                      ),
                      const SizedBox(
                        height: 24,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1), // Shadow color
                spreadRadius: 1, // How much the shadow spreads
                blurRadius: 10, // The blur radius of the shadow
                offset: const Offset(0, -5), // Offset of the shadow (x, y)
              ),
            ]),
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height / 40,
                    ),
                    PrimaryButton(
                      label: isInCart ? 'REMOVE FROM CART' : 'ADD TO CART',
                      onPressed: onAddToCart,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
