import 'package:animals/providers/Listing_provider/add_listing_provider.dart';
import 'package:animals/view/common/custom_button.dart';
import 'package:animals/view/common/custom_loading.dart';
import 'package:animals/view/common/custom_sizedBox.dart';
import 'package:animals/view/common/custom_textfeild.dart';
import 'package:animals/view/screens/Listings_screens/widgets/Listing_data_Feilds.dart';
import 'package:animals/view/screens/Listings_screens/widgets/MetaDataCheck.dart';
import 'package:animals/view/screens/Listings_screens/widgets/MetaDataFields.dart';
import 'package:animals/view/screens/Listings_screens/widgets/listing_Media.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/helper_fuctions/format_validator.dart';

class AddListingScreen extends ConsumerWidget {
  const AddListingScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var watchProvider = ref.watch(addListingProvider.notifier);
    var key = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Listing"),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Common Fields
              ListingDataFields(formKey: key,),
              Sized(height: 0.02),
              // Metadata Fields
              MetaDataFields(),
              Sized(height: 0.02),
              // Metadata Checkboxes
              MetadataCheck(),
              Sized(height: 0.02),
              CustomTextField(
                maxLine: 4,
                controller: watchProvider.descriptionsController,
                hintText: 'Description',
                validate: (value) {
                  return FormValidators.validateNormalField(value, 'Description');
                },
              ),
              // Image Upload Section
              Sized(height: 0.02),
              ListingMediaImages(),
              // Video Upload Section
              Sized(height: 0.02),
              ListingMediaVideo(),
              // Submit Listing
              Sized(height: 0.05),
              Consumer(builder: (context,reference,_){
                var state = ref.watch(addListingProvider.select((state)=>state.isLoading));
                var images = ref.watch(addListingProvider.select((state)=>state.images));
                var videos = ref.watch(addListingProvider.select((state)=>state.video));
                var data = ref.read(addListingProvider.notifier);
                return state == true ? CustomLoading() :CustomButton(title: 'Submit Listing', onTap: (){
                 if(key.currentState!.validate()){
                   data.uploadAndStoreImages(
                     context: context,
                     images: images!,
                     video: videos,
                   );
                 }
                });
              }),
            ],
          ),
        ),
      ),
    );
  }
}

