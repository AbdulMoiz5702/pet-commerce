import 'package:animals/core/constants/presentation/font_manager.dart';
import 'package:animals/core/utils/helper_fuctions/date_formatter.dart';
import 'package:animals/view/common/custom_sizedBox.dart';
import 'package:animals/view/common/image_widget.dart';
import 'package:animals/view/screens/home_screens/widgets/list_card_UI_row.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/presentation/app_colors.dart';
import '../../../../models/animal_models/animal_models.dart';
import '../../../common/text_widgets.dart';

class AnimalListCard extends StatelessWidget {
  final AnimalModels animal;
  const AnimalListCard({super.key, required this.animal});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      color: AppColor.whiteColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Container(
               clipBehavior: Clip.antiAlias,
               decoration:BoxDecoration(borderRadius: BorderRadius.circular(10)) ,
               height: MediaQuery.sizeOf(context).height * 0.22,
               width: MediaQuery.sizeOf(context).width * 0.4,
               child: ImageWidget(imageUrl: animal.images[0].url,)),
            const Sized(width: 0.02,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  boldText(title: animal.name,color: AppColor.mediumGrey,fontSize: AppTextSize.regular,fontWeight: AppTextWeight.medium),
                  const Sized(height: 0.01,),
                  boldText(title: '${animal.price} Rs',color: AppColor.primaryColor,fontSize: AppTextSize.medium,fontWeight: AppTextWeight.bold),
                  const Sized(height: 0.01,),
                  ListCardUiRow(title: animal.location, iconData: Icons.place_outlined),
                  const Sized(height: 0.01,),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: AppColor.disableColor,
                        child: boldText(title: animal.sellerName[0], color: AppColor.blackColor,fontSize: AppTextSize.light),
                      ),
                      const Sized(width: 0.02),
                      lightText(title: animal.sellerName,color: AppColor.mediumGrey),
                    ],
                  ),
                  const Sized(height: 0.01,),
                  Row(
                    children: [
                      ListCardUiRow(title: animal.impressions.length.toString(), iconData: Icons.visibility),
                      const Sized(width: 0.04),
                      ListCardUiRow(title: animal.wishList.length.toString(), iconData: Icons.favorite),
                    ],
                  ),
                  const Sized(height: 0.01,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      lightText(title: DateHelperFunctions.formatTimestamp(animal.createdAt.toString()),color: AppColor.mediumGrey,fontWeight: AppTextWeight.medium),
                      lightText(title: DateHelperFunctions.timeAgo(animal.createdAt.toString()), color: AppColor.mediumGrey,fontWeight: AppTextWeight.medium,fontSize: AppTextSize.thin),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimalGridCard extends StatelessWidget {
  final AnimalModels animal;
  const AnimalGridCard({super.key, required this.animal});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      color: AppColor.whiteColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                clipBehavior: Clip.antiAlias,
                decoration:BoxDecoration(borderRadius: BorderRadius.circular(10)) ,
                height: MediaQuery.sizeOf(context).height * 0.23,
                width: MediaQuery.sizeOf(context).width * 0.43,
                child: ImageWidget(imageUrl: animal.images[0].url,)),
            const Sized(height: 0.01,),
            boldText(title: animal.name, color: AppColor.mediumGrey, fontSize: 14, fontWeight: AppTextWeight.medium,),
            const Sized(height: 0.005,),
            boldText(title: '${animal.price} Rs', color: AppColor.primaryColor, fontSize: AppTextSize.medium, fontWeight: AppTextWeight.bold,),
            const Sized(height: 0.005,),
            ListCardUiRow(title: animal.location, iconData: Icons.place_outlined,),
            const Sized(height: 0.005,),
            lightText(
              title: animal.sellerName,
              color: AppColor.mediumGrey,
            ),
            const Sized(height: 0.005,),
            Row(
              children: [
                ListCardUiRow(
                  title: animal.impressions.length.toString(),
                  iconData: Icons.visibility,
                ),
                const SizedBox(width: 8),
                ListCardUiRow(
                  title: animal.wishList.length.toString(),
                  iconData: Icons.favorite,
                ),
              ],
            ),
            const Sized(height: 0.005,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                lightText(
                  title: DateHelperFunctions.formatTimestamp(animal.createdAt.toString()),
                  color: AppColor.mediumGrey,
                  fontWeight: AppTextWeight.medium,
                ),
                lightText(
                  title: DateHelperFunctions.timeAgo(animal.createdAt.toString()),
                  color: AppColor.mediumGrey,
                  fontWeight: AppTextWeight.medium,
                  fontSize: AppTextSize.thin,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


