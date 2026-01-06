import 'package:flutter/material.dart';
import 'package:fly/core/widgets/circleIcon_button.dart';
import '../../model/product.dart';

class ProductCard extends StatefulWidget {
  final double width;
  final double height;
  final double? imageX;
  final Product product;
  final ImageProvider image;
  final bool setIcon;
  final VoidCallback onAdded;

  const ProductCard({
    super.key,
    this.height = 300,
    this.width = 200,
    this.imageX = 200,
    required this.product,
    required this.image,
    required this.onAdded,
    this.setIcon = false,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.topCenter,
          height: widget.height,
          width: widget.width,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 135,
                child: Image(
                  image: widget.image,
                  width: widget.imageX,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 8),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (widget.product.name.isNotEmpty)
                      Text(
                        widget.product.name.length > 16
                            ? '${widget.product.name.substring(0, 16)}...'
                            : widget.product.name,
                        style: Theme.of(context).textTheme.headlineSmall,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    if (widget.product.description.isNotEmpty) ...[
                      const SizedBox(height: 5),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          widget.product.description.length > 60
                              ? '${widget.product.description.substring(0, 60)}...'
                              : widget.product.description,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontSize: 10),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                    if (widget.product.price > 0) ...[
                      const SizedBox(height: 5),
                      Text(
                        "\$${widget.product.price.toStringAsFixed(2)}",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.orange),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
        if (widget.setIcon)
         Positioned(
             top: 10,
             left: 10,
             child: CircleIconButton(
               backgroundColor: Colors.grey.shade100,
               icon: isFavorite ?  Icons.favorite : Icons.favorite_border,
               iconColor: isFavorite ?  Colors.pink : Colors.grey,
               onTap: () {
                 setState(() {
                   isFavorite = !isFavorite;
                 });
                 widget.onAdded;
               },
             ),
           ),

        if (widget.product.discount > 0)
          Positioned(
            top: 14,
            right: 10,
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Text(
                "-${widget.product.discount}%",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }
}
