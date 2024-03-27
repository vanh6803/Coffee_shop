import 'package:flutter/material.dart';
import 'package:fontend/constant/color.dart';
import 'package:fontend/constant/dimen.dart';
import 'package:fontend/constant/heading.dart';
import 'package:fontend/controller/cart_controller.dart';
import 'package:fontend/controller/order_controller.dart';
import 'package:fontend/controller/theme_controller.dart';
import 'package:fontend/models/cart.dart';
import 'package:fontend/models/product.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _cartController = Get.put(CartController());
  final _themeController = Get.put(ThemeController());
  final _orderController = Get.put(OrderController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    AppDimen.init(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: _themeController.isDarkMode.value == false
          ? const Color(0xFFF1F4F8)
          : null,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Obx(
              () {
                double total = _calculateTotal();
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimen.screenWidth * 0.05,
                    vertical: AppDimen.screenWidth * 0.03,
                  ),
                  child: Text(
                    'Total: \$ ${total.toStringAsFixed(2)}',
                    style: GoogleFonts.roboto(
                      color: _themeController.isDarkMode.value
                          ? Colors.white
                          : Colors.black,
                      fontSize: H3,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                );
              },
            ),
            Expanded(
              child: Obx(
                () => _cartController.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : _cartController.cartItem.isEmpty
                        ? const Text("")
                        : ListView.builder(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppDimen.screenWidth * 0.03,
                            ),
                            scrollDirection: Axis.vertical,
                            itemCount: _cartController.cartItem.length + 1,
                            itemBuilder: (context, index) {
                              if (index == _cartController.cartItem.length) {
                                return _buildOrderButton(context);
                              }
                              Cart cart = _cartController.cartItem[index];
                              Product product = cart.product!;
                              return Dismissible(
                                key: Key("${cart.id}"),
                                onDismissed: (direction) {
                                  _cartController.deleteCartItem(cart.id!);
                                },
                                direction: DismissDirection.endToStart,
                                background: Container(
                                  color: Colors.red,
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.only(right: 20),
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                                child: _cartItem(cart, product),
                              );
                            },
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _calculateTotal() {
    double total = 0;
    for (var cart in _cartController.cartItem) {
      total += cart.product!.price ?? 0;
    }
    return total;
  }

  Widget _cartItem(Cart cart, Product product) {
    return Card(
      surfaceTintColor: Colors.white,
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(product.image ?? ''),
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              width: AppDimen.screenWidth * 0.2,
              height: AppDimen.screenWidth * 0.2,
              margin: const EdgeInsets.only(right: 10),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "${product.name} - ${cart.size}",
                  style: GoogleFonts.roboto(
                    color: _themeController.isDarkMode.value
                        ? Colors.white
                        : Colors.black,
                    fontSize: H6,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                ),
                Text(
                  '\$ ${product.price}' ?? '',
                  style: GoogleFonts.roboto(
                    color: _themeController.isDarkMode.value
                        ? Colors.white
                        : Colors.black,
                    fontSize: H6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderButton(context) {
    return GestureDetector(
      onTap: () => _placeOrder(context),
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: AppDimen.screenWidth * 0.1,
          vertical: AppDimen.screenWidth * 0.02,
        ),
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Center(
          child: Text(
            'Check Out',
            style: GoogleFonts.roboto(
              fontSize: H5,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void _placeOrder(context) async {
    List<Cart> carts =
        _cartController.cartItem.map((item) => item as Cart).toList();
    await _orderController.orderCoffee(carts);
    await _cartController.fetchData();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.check,
              color: Colors.greenAccent,
            ),
            Text(
              'Order successfully',
              style: GoogleFonts.roboto(
                color: Colors.greenAccent,
              ),
            ),
          ],
        ),
        backgroundColor: primaryColor,
        duration: Durations.extralong3,
      ),
    );
  }
}
