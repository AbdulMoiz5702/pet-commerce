import 'package:animals/core/enum/animals_categpry_enum.dart';
import 'package:animals/view/common/text_widgets.dart';
import 'package:animals/view/screens/home_screens/widgets/listing_cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/presentation/app_colors.dart';
import '../../../core/exceptions/net_work_excptions.dart';
import '../../../providers/home_providers/get_category_listings.dart';
import '../../../providers/home_providers/view_type_provider.dart';
import '../../common/custom_button.dart';
import '../../common/custom_sizedBox.dart';

class CategoryScreens extends ConsumerWidget {
  final AnimalsCategoryEnum categoryEnum;
  const CategoryScreens({super.key,required this.categoryEnum});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final provider = ref.watch(getCategoryListings(categoryEnum));
    return Scaffold(
      appBar: AppBar(
        title: lightText(title: categoryEnum.toString().split('.').last),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 8),
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Sized(
              height: 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                mediumText(title: 'Recent Listings'),
                Consumer(builder: (context, reference, _) {
                  var state = ref.watch(homeViewTypeProvider.select((state) => state.isGridView));
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      mediumText(
                          title: state == true ? 'Grid View' : 'List View'),
                      Sized(
                        width: 0.05,
                      ),
                      TapIcon(
                          iconData:
                          state == true ? Icons.grid_view : Icons.list,
                          color: AppColor.secondaryColor,
                          onTap: () {
                            ref
                                .read(homeViewTypeProvider.notifier)
                                .changeViewType();
                          }),
                    ],
                  );
                }),
              ],
            ),
            provider.when(
              data: (data) {
                print('📦 StreamProvider received data: ${data.length}');
                if (data.isEmpty) {
                  return mediumText(
                      title: 'No Listings Found', color: AppColor.blackColor);
                } else {
                  return Consumer(builder: (context, reference, _) {
                    var state = ref.watch(homeViewTypeProvider
                        .select((state) => state.isGridView));
                    if (state == false) {
                      return ListView.builder(
                        shrinkWrap: true,
                        cacheExtent: 0,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: data.length,
                        itemBuilder: (context, index) =>
                            AnimalListCard(animal: data[index]),
                      );
                    } else {
                      return GridView.builder(
                        shrinkWrap: true,
                        cacheExtent: 0,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: data.length,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Number of columns in the grid
                          mainAxisSpacing:
                          10, // Vertical space between grid items
                          crossAxisSpacing:
                          5, // Horizontal space between grid items
                          childAspectRatio: 4 /
                              8.5, // Aspect ratio of the grid item (width/height)
                        ),
                        itemBuilder: (context, index) =>
                            AnimalGridCard(animal: data[index]),
                      );
                    }
                  });
                }
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
                            ref.invalidate(getCategoryListings(categoryEnum)),
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
