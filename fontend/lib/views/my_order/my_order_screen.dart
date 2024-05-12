import 'package:flutter/material.dart';
import 'package:fontend/constant/color.dart';
import 'package:fontend/constant/dimen.dart';
import 'package:fontend/constant/heading.dart';
import 'package:fontend/controller/order_controller.dart';
import 'package:fontend/controller/theme_controller.dart';
import 'package:fontend/models/order.dart';
import 'package:fontend/models/order_item.dart';
import 'package:fontend/models/product.dart';
import 'package:fontend/views/detail_order/detail_order_screen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  final _orderController = Get.put(OrderController());
  final _themeController = Get.put(ThemeController());
  final List<String> statuses = [
    'All',
    "Pending",
    "In progress",
    "Success",
    "Canceled"
  ];
  late String selectedStatus;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedStatus = "All";
  }

  @override
  Widget build(BuildContext context) {
    AppDimen.init(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _header(),
            SizedBox(
              height: AppDimen.screenWidth * 0.13,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: statuses.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedStatus = statuses[index];
                      });
                      _orderController.fetchOrder(selectedStatus);
                    },
                    child: Card(
                      color: selectedStatus == statuses[index]
                          ? primaryColor
                          : _themeController.isDarkMode.value
                              ? null
                              : Colors.white,
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        constraints: BoxConstraints(
                            minWidth: AppDimen.screenWidth * 0.15),
                        child: Center(
                          child: Text(
                            statuses[index],
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w500,
                              fontSize: H6,
                              color: selectedStatus == statuses[index]
                                  ? Colors.white
                                  : null,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: Obx(
                () => _orderController.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : _orderController.orders.isEmpty
                        ? Center(
                            child: Text(
                              "No orders",
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w500, fontSize: H3),
                            ),
                          )
                        : ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: _orderController.orders.length,
                            itemBuilder: (context, index) {
                              Order order = _orderController.orders[index];
                              List<OrderItem>? orderItems = order.productOrder;
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Get.to(() => DetailOrderScreen(
                                                  order: order,
                                                ));
                                          },
                                          child: Row(
                                            children: [
                                              Text(
                                                "${index + 1}",
                                                style: GoogleFonts.roboto(
                                                  fontSize: H4,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5.0),
                                                child: Container(
                                                  width: 1,
                                                  height: AppDimen.screenWidth *
                                                      0.2,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      'Order Id: ${order.id}',
                                                      style: GoogleFonts.roboto(
                                                          fontSize: H6,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Order Product: ",
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontSize: H6),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            orderItems!
                                                                .map((item) {
                                                              OrderItem
                                                                  orderItem =
                                                                  item;
                                                              Product product =
                                                                  orderItem
                                                                      .product!;
                                                              return product
                                                                  .name;
                                                            }).join(' - '),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: GoogleFonts
                                                                .roboto(
                                                                    fontSize:
                                                                        H6),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      "Total price: \$ ${order.totalPrice}",
                                                      style: GoogleFonts.roboto(
                                                          fontSize: H6),
                                                    ),
                                                    Text(
                                                      "Status: ${order.status}",
                                                      style: GoogleFonts.roboto(
                                                        fontSize: H6,
                                                        color: order.status ==
                                                                "Success"
                                                            ? Colors.green
                                                            : null,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const Icon(Icons.arrow_right)
                                            ],
                                          ),
                                        ),
                                        // button confirm success
                                        if (order.status == "In progress")
                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 5.0),
                                            width: double.infinity,
                                            padding: const EdgeInsets.all(10.0),
                                            decoration: BoxDecoration(
                                              color: _themeController
                                                      .isDarkMode.value
                                                  ? const Color(0xff8BC34A)
                                                  : const Color(0xff4CAF50),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                            ),
                                            child: InkWell(
                                              child: Center(
                                                child: Text(
                                                  "Confirm success",
                                                  style: GoogleFonts.roboto(
                                                      fontSize: H6,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              onTap: () {
                                                _orderController
                                                    .changeStatusOrder(
                                                        order.id!, "Success");
                                              },
                                            ),
                                          ),
                                        if (order.status == "Pending")
                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 5.0),
                                            width: double.infinity,
                                            padding: const EdgeInsets.all(10.0),
                                            decoration: const BoxDecoration(
                                              color: Colors.redAccent,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                            ),
                                            child: InkWell(
                                              child: Center(
                                                child: Text(
                                                  "Cancel order",
                                                  style: GoogleFonts.roboto(
                                                      fontSize: H6,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              onTap: () {
                                                _orderController
                                                    .changeStatusOrder(
                                                        order.id!, "Canceled");
                                              },
                                            ),
                                          )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => Get.back(),
              child: const Icon(
                Icons.arrow_back_ios,
                size: 25.0,
              ),
            ),
          ),
          Text(
            'Order history',
            style: GoogleFonts.roboto(
              fontSize: H4,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
