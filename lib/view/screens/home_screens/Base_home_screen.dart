import 'package:animals/core/constants/presentation/app_colors.dart';
import 'package:animals/providers/home_providers/view_type_provider.dart';
import 'package:animals/view/common/custom_button.dart';
import 'package:animals/view/common/text_widgets.dart';
import 'package:animals/view/screens/home_screens/widgets/listing_cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/exceptions/net_work_excptions.dart';
import '../../../providers/home_providers/get_home_screen_listings.dart';



class BaseHomeScreen extends ConsumerWidget {
  const BaseHomeScreen({super.key});
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final provider = ref.watch(allAnimalListingProvider(context));
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Listings'),
        actions: [
         Consumer(builder: (context,reference,_){
           var state = ref.watch(homeViewTypeProvider.select((state)=> state.isGridView));
           return  TapIcon(iconData:  state == true ? Icons.grid_view : Icons.list,color: AppColor.secondaryColor ,onTap: (){
             ref.read(homeViewTypeProvider.notifier).changeViewType();
           });
         }),
        ],
      ),
      body: provider.when(
          data: (data){
            if(data.isEmpty){
              return mediumText(title:'No Listings Found',color: AppColor.blackColor);
            }else{
              return Consumer(builder: (context,reference,_){
                var state = ref.watch(homeViewTypeProvider.select((state)=> state.isGridView));
                if(state == false){
                  return ListView.builder(
                    cacheExtent: 0,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    physics: BouncingScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (context, index) => AnimalListCard(animal: data[index]),
                  );
                }else{
                  return GridView.builder(
                    cacheExtent: 0,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    physics: BouncingScrollPhysics(),
                    itemCount: data.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns in the grid
                      mainAxisSpacing: 10, // Vertical space between grid items
                      crossAxisSpacing: 5, // Horizontal space between grid items
                      childAspectRatio: 4/8.5, // Aspect ratio of the grid item (width/height)
                    ),
                    itemBuilder: (context, index) => AnimalGridCard(animal: data[index]),
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
                  onTap:() => ref.invalidate(allAnimalListingProvider(context)) ,
                  iconData: Icons.refresh,
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),),
    );
  }
}
