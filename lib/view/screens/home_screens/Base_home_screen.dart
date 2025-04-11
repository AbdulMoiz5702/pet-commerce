import 'package:animals/core/constants/presentation/app_colors.dart';
import 'package:animals/core/utils/bottom_model_sheets/helper_bottom_model_sheets.dart';
import 'package:animals/view/common/custom_button.dart';
import 'package:animals/view/common/custom_sizedBox.dart';
import 'package:animals/view/common/text_widgets.dart';
import 'package:animals/view/screens/home_screens/widgets/build_list-or_grid.dart';
import 'package:animals/view/screens/home_screens/widgets/cateogory_list.dart';
import 'package:animals/view/screens/home_screens/widgets/filters_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/exceptions/net_work_excptions.dart';
import '../../../models/animal_models/animal_models.dart';
import '../../../providers/filters_provider/filters_provider.dart';
import '../../../providers/home_providers/get_home_screen_listings.dart';


class BaseHomeScreen extends ConsumerWidget {
  const BaseHomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(allAnimalListingProvider(context));
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 8),
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Sized(height: 0.1,),
            CategoryList(),
            Sized(height: 0.02,),
            toggleListAndGrid(),
            TapIcon(iconData: Icons.tune_outlined,color: AppColor.primaryColor, onTap: (){
              HelperBottomSheets.showCustomModalBottomSheet(context: context, child: FilterWidget());
            }),
            provider.when(
              data: (data) {
                return data.isEmpty
                    ? mediumText(title: 'No Listings Found', color: AppColor.blackColor)
                    : Builder(
                  builder: (context) {
                    final filters = ref.watch(filterProvider);
                    bool noFilterApplied = filters.gender == null && filters.category == null && (filters.location == null || filters.location!.isEmpty) && (filters.minPrice == 0 && filters.maxPrice == 0 || filters.minPrice >= filters.maxPrice);
                    if (noFilterApplied) {
                      return buildListOrGrid(data);
                    }
                    else if (!noFilterApplied) {
                      List<AnimalModels> filteredData = data.where((animal) {
                        bool matchesGender = filters.gender == null || animal.gender == filters.gender;
                        bool matchesCategory = filters.category == null || animal.category == filters.category;
                        bool matchesLocation = filters.location == null || animal.location.toLowerCase().contains(filters.location!.toLowerCase());
                        double price = double.tryParse(animal.price) ?? 0.0;
                        bool matchesPrice = (filters.minPrice == 0.0 && filters.maxPrice == 0.0) || (price >= filters.minPrice && price <= filters.maxPrice);
                        return (filters.gender == null || matchesGender) &&
                            (filters.category == null || matchesCategory) &&
                            (filters.location == null || matchesLocation) &&
                            ((filters.minPrice == 0.0 && filters.maxPrice == 0.0) || matchesPrice);
                      }).toList();

                      if (filteredData.isEmpty) {
                        return mediumText(title: 'No Filter Listing Found', color: AppColor.blackColor);
                      } else {
                        return buildListOrGrid(filteredData);
                      }
                    }
                    else {
                      return mediumText(title: 'Something went wrong', color: AppColor.lightGrey);
                    }
                  },
                );

              },
              error: (error, stack) {
                print('error :$error $stack');
                String errorMessage = ExceptionHandler.getMessage(error);
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error, color: Colors.red, size: 50),
                      const SizedBox(height: 10),
                      Text(
                        errorMessage,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      TapIcon(
                        onTap: () =>
                            ref.invalidate(allAnimalListingProvider(context)),
                        iconData: Icons.refresh,
                      ),
                    ],
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }
}
