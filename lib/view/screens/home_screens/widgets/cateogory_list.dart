import 'package:flutter/material.dart';
import '../../../../core/constants/presentation/app_colors.dart';
import '../../../../core/enum/animals_categpry_enum.dart';
import '../../../../core/routes/routes.dart';
import '../../../common/text_widgets.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          AnimalsCategoryEnum.values.length,
              (index) {
            final category = AnimalsCategoryEnum.values[index];
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, Routes.categoryScreens,arguments: {
                  'category':category,
                });
              },
              child: Container(
                  alignment: Alignment.center,
                  color: AppColor.lightGrey,
                  margin: EdgeInsets.all(5),
                  child: lightText(title: category.toString().split('.').last)),
            );
          },
        ),
      ),
    );
  }
}
