



import 'package:animals/view/common/custom_sizedBox.dart';
import 'package:animals/view/common/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/enum/animals_categpry_enum.dart';
import '../../../../providers/Listing_provider/add_listing_provider.dart';

class MetadataCheck extends StatelessWidget {
  const MetadataCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context,ref,_){
      var state = ref.watch(addListingProvider.select((state)=> state.category));
      return Column(
        children: [
          if (state == AnimalsCategoryEnum.dogs || state == AnimalsCategoryEnum.cows) ...[
            Row(
              children: [
                Consumer(builder: (context,reference,_){
                  print('isVaccinated');
                  var state = reference.watch(addListingProvider.select((state)=> state.isVaccinated));
                  var provider = ref.read(addListingProvider.notifier);
                  return Checkbox(
                    value: state,
                    onChanged: (bool? newValue) {
                      provider.vaccinated(isVaccinated: newValue!);
                    },
                  );
                }),
                Sized(width: 0.03,),
                lightText(title: "Vaccinated"),
              ],
            ),
          ],
          if (state == AnimalsCategoryEnum.goats || state == AnimalsCategoryEnum.cows) ...[
            Row(
              children: [
                Consumer(builder: (context,reference,_){
                  print('isPregnant');
                  var state = reference.watch(addListingProvider.select((state)=> state.isPregnant));
                  var provider = ref.read(addListingProvider.notifier);
                  return Checkbox(
                    value: state,
                    onChanged: (bool? newValue) {
                      provider.pregnant(isPregnant: newValue!);
                    },
                  );
                }),
                Sized(width: 0.03,),
                lightText(title: "Pregnant"),
              ],
            ),
          ],
          if (state == AnimalsCategoryEnum.chickens) ...[
            Row(
              children: [
                Consumer(builder: (context,reference,_){
                  print('laysEggs');
                  var state = reference.watch(addListingProvider.select((state)=> state.laysEggs));
                  var provider = ref.read(addListingProvider.notifier);
                  return Checkbox(
                    value: state,
                    onChanged: (bool? newValue) {
                      provider.laysEggs(laysEggs: newValue!);
                    },
                  );
                }),
                Sized(width: 0.03,),
                lightText(title: "Lays Eggs"),
              ],
            ),
          ],
          if (state == AnimalsCategoryEnum.sheep) ...[
            Row(
              children: [
                Consumer(builder: (context,reference,_){
                  print('woolProduction');
                  var state = reference.watch(addListingProvider.select((state)=> state.woolProduction));
                  var provider = ref.read(addListingProvider.notifier);
                  return Checkbox(
                    value: state,
                    onChanged: (bool? newValue) {
                      provider.woolProduction(woolProduction: newValue!);
                    },
                  );
                }),
                Sized(width: 0.03,),
                lightText(title: "Wool Production"),
              ],
            ),
          ],
        ],
      );
    });
  }
}