import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/presentation/app_colors.dart';
import '../../../../models/animal_models/animal_models.dart';
import '../../../../providers/home_providers/view_type_provider.dart';
import '../../../common/custom_button.dart';
import '../../../common/custom_sizedBox.dart';
import '../../../common/text_widgets.dart';
import 'listing_cards.dart';


Widget toggleListAndGrid(){
  return  Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      mediumText(title: 'Recent Listings'),
      Consumer(builder: (context, reference, _) {
        var state = reference.watch(homeViewTypeProvider.select((state) => state.isGridView));
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            mediumText(title: state == true ? 'Grid View' : 'List View'),
            Sized(width: 0.05,),
            TapIcon(iconData: state == true ? Icons.grid_view : Icons.list, color: AppColor.secondaryColor, onTap: () {
              reference.read(homeViewTypeProvider.notifier).changeViewType();
                }),
          ],
        );
      }),
    ],
  );
}

Widget buildListOrGrid(List<AnimalModels> data) {
  return Consumer(builder: (context, ref, _) {
    bool isGrid = ref.watch(homeViewTypeProvider.select((state) => state.isGridView));
    return isGrid
        ? GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: data.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 5,
        childAspectRatio: 4 / 8.5,
      ),
      itemBuilder: (context, index) => AnimalGridCard(animal: data[index]),
    )
        : ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (context, index) => AnimalListCard(animal: data[index]),
    );
  });
}
