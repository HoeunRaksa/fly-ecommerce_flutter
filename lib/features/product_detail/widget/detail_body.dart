import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fly/features/product_detail/widget/viewer.dart';
import '../../../config/app_config.dart';
import '../../../model/product.dart';
import 'detail_header.dart';

class DetailBody extends StatelessWidget {
  final Product product;
  const DetailBody({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 10),
      cacheExtent: 1000,
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        Container(
          padding: const EdgeInsets.only(top:70, bottom: 30),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: product.images.isNotEmpty
                ? CachedNetworkImage(
              imageUrl: AppConfig.getImageUrl(product.images[0].imageUrl),
              placeholder: (context, url) => Container(
                color: Colors.grey[200],
                height: 250,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                height: 250,
                color: Colors.grey[200],
                child: const Icon(
                  Icons.image,
                  size: 50,
                  color: Colors.grey,
                ),
              ),
              fit: BoxFit.contain,
              width: double.infinity,
              height: 250,
            )
                : Image.asset(
              "${AppConfig.imageUrl}/banner.png",
              fit: BoxFit.cover,
              width: double.infinity,
              height: 250,
            ),
          ),
        ),

        // Name & Price
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 200,
                child: Text(
                  product.name,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(
                width: 130,
                child: Text(
                  "\$${product.price.toStringAsFixed(2)}",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Colors.orange.shade700,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Viewer (views, likes, rating)
        Viewer(
          view: 20000,
          like: 3000,
          rating: 4,
        ),

        // Description
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 20, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Description",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 15),
              Text(
                product.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}