import 'package:flutter/material.dart';
import '../../../../common/widgets/image_text_widgets/vertical_image_text.dart';
import '../../../sub_category/sub_categories.dart';
import '../../logic/models/category_model.dart';

class THomeCategories extends StatelessWidget {
  const THomeCategories({
    super.key,
  });

  static final List<CategoryModel> mockCategories = [
    CategoryModel(image: 'assets/images/shoes.png', title: 'Shoes'),
    CategoryModel(image: 'assets/images/jacket.png', title: 'Jackets'),
    CategoryModel(image: 'assets/images/jeans.png', title: 'Jeans'),
    CategoryModel(image: 'assets/images/t-shirt.png', title: 'T-Shirts'),
    CategoryModel(image: 'assets/images/belt.png', title: 'Accessories'),
    CategoryModel(image: 'assets/images/bag.png', title: 'Bags'),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: mockCategories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          final category = mockCategories[index];
          return TVerticalImageText(
            image: category.image,
            title: category.title,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SubCategoriesScreen(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}