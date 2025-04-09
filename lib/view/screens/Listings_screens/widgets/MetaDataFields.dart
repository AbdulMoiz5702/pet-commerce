import 'package:animals/view/common/custom_sizedBox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/enum/animals_categpry_enum.dart';
import '../../../../providers/Listing_provider/add_listing_provider.dart';
import '../../../common/custom_textfeild.dart';


class MetaDataFields extends StatelessWidget {
  const MetaDataFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context,ref,_){
      var state = ref.watch(addListingProvider.select((state)=> state.category));
      var provider = ref.watch(addListingProvider.notifier);
      return Column(
        children: [
          if (state == AnimalsCategoryEnum.dogs) ...[
            CustomTextField(controller: provider.breedController, hintText: 'Breed',validate: (value){}),
            Sized(height: 0.02,),
            CustomTextField(controller: provider.sizeController, hintText: 'Size',validate: (value){}),
          ],
          if (state == AnimalsCategoryEnum.cats) ...[
            CustomTextField(controller: provider.breedController, hintText: 'Breed',validate: (value){}),
            Sized(height: 0.02,),
            CustomTextField(controller: provider.colorController, hintText: 'Color',validate: (value){}),
          ],
          if (state == AnimalsCategoryEnum.birds) ...[
            CustomTextField(controller: provider.speciesController, hintText: 'Species',validate: (value){}),
            Sized(height: 0.02,),
            CustomTextField(controller: provider.wingspanController, hintText: 'Wingspan',validate: (value){}),
          ],
          if (state == AnimalsCategoryEnum.goats) ...[
            CustomTextField(controller: provider.breedController, hintText: 'Breed',validate: (value){}),
          ],
          if (state == AnimalsCategoryEnum.chickens) ...[
            CustomTextField(controller: provider.breedController, hintText: 'Breed',validate: (value){}),
            Sized(height: 0.02,),
            CustomTextField(controller: provider.colorController, hintText: 'Color',validate: (value){}),
          ],
          if (state == AnimalsCategoryEnum.cows) ...[
            CustomTextField(controller: provider.milkProductionController, hintText: 'Milk Production',validate: (value){}),
            Sized(height: 0.02,),
            CustomTextField(controller: provider.breedController, hintText: 'Breed',validate: (value){}),
          ],
          if (state == AnimalsCategoryEnum.sheep) ...[
            CustomTextField(controller: provider.breedController, hintText: 'Breed',validate: (value){}),
          ],
          if (state == AnimalsCategoryEnum.others) ...[
            CustomTextField(controller: provider.otherDescriptionController, hintText: 'Description',validate: (value){}),
          ],
        ],
      );
    });
  }
}
