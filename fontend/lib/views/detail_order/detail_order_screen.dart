import 'package:flutter/material.dart';
import 'package:fontend/constant/dimen.dart';
import 'package:fontend/constant/heading.dart';
import 'package:fontend/models/order.dart';
import 'package:fontend/models/order_item.dart';
import 'package:fontend/models/product.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailOrderScreen extends StatelessWidget {
  Order order;

  DetailOrderScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    AppDimen.init(context);
    List<OrderItem>? orderItems = order.productOrder;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Price: \$${order.totalPrice}',
                    style: GoogleFonts.roboto(
                      fontSize: H4,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Status: ${order.status}',
                    style: GoogleFonts.roboto(
                      fontSize: H5,
                      fontWeight: FontWeight.w400,
                      color: order.status == "Success" ? Colors.green : null,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: orderItems?.length,
                itemBuilder: (context, index) {
                  OrderItem? item = orderItems?[index];
                  Product? product = item?.product;
                  return Card(
                    clipBehavior: Clip.antiAlias,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: AppDimen.screenWidth * 0.3,
                            height: AppDimen.screenWidth * 0.3,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(product!.image!),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name: ${product.name}',
                              style: GoogleFonts.roboto(
                                fontSize: H6,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'Price product: \$${product.price}',
                              style: GoogleFonts.roboto(
                                fontSize: H6,
                              ),
                            ),
                            Text(
                              'Size: ${item?.size}',
                              style: GoogleFonts.roboto(
                                fontSize: H6,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
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
          Expanded(
            child: Text(
              '${order.id}',
              style: GoogleFonts.roboto(
                fontSize: H4,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
