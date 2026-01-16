import 'package:flutter/material.dart';
import '../../config/app_color.dart';
import '../../model/product.dart';

class ProductCard extends StatelessWidget {
  final double? width;
  final double? height;
  final double? imageX;
  final Product product;
  final ImageProvider image;
  final bool setIcon;
  final VoidCallback onAdded;

  const ProductCard({
    super.key,
    this.height,
    this.width,
    this.imageX,
    required this.product,
    required this.image,
    required this.onAdded,
    this.setIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Responsive dimensions with max width of 600
    final cardWidth = width ?? (screenWidth * 0.65).clamp(0, 600);
    final cardHeight = height ?? screenHeight * 0.5;
    final imageWidth = imageX ?? cardWidth;

    return Container(
      width: cardWidth,
      height: cardHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(screenWidth * 0.04),
        color: Colors.white
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(screenWidth * 0.04),
            child: Stack(
              children: [
                Image(image: image, width: imageWidth, fit: BoxFit.contain),
                Positioned(
                  top: screenHeight * 0.025,
                  right: screenWidth * 0.05,
                  child: Container(
                    padding: EdgeInsets.all(screenWidth * 0.013),
                    decoration: BoxDecoration(
                        color: AppColors.woodLight,
                        borderRadius: BorderRadius.all(Radius.circular(screenWidth * 0.026))
                    ),
                    child: Text(
                      "- \$${product.discount}",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.012),
          Container(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.026),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (product.name.isNotEmpty)
                  Text(
                    product.name,
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w800,
                      color: AppColors.woodDark,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                  ),

                SizedBox(height: screenHeight * 0.012),

                // Description
                if (product.description.isNotEmpty)
                  Text(
                    product.description,
                    style: TextStyle(
                      fontSize: screenWidth * 0.039,
                      color: Colors.grey.shade600,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                  ),
                SizedBox(height: screenHeight * 0.015),
                if (product.price > 0)
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: screenWidth * 0.042,
                      fontWeight: FontWeight.bold,
                      color: AppColors.woodWalnut,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}