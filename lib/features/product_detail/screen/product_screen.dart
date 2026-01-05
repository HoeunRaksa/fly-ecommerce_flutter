import 'package:flutter/material.dart';
import 'package:fly/features/product_detail/widget/detail_footer.dart';
import '../widget/detail_body.dart';
import '../widget/detail_header.dart';
import '../../../model/product.dart';

class ProductScreen extends StatefulWidget {
  final Product product;

  const ProductScreen({super.key, required this.product});

  @override
  State<ProductScreen> createState() => _ProductScreen();
}

class _ProductScreen extends State<ProductScreen> {
  int count = 1;
  late double amount;

  @override
  void initState() {
    super.initState();
    amount = widget.product.price;
  }

  @override
  Widget build(BuildContext context) {
    const double footerHeight = 150;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          DetailBody(product: widget.product),
          Positioned(
            top: 5,
            left: 10,
            right: 10,
            child: const DetailHeader(),
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: footerHeight,
        child: DetailFooter(
          count: count,
          amount: amount,
          onAdded: () => setState(() {
            count++;
            amount = widget.product.price * count;
          }),
          onRemoved: () => setState(() {
            if (count > 0) count--;
            amount = widget.product.price * count;
          }),
        ),
      ),
    );
  }
}