
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/enum/animals_categpry_enum.dart';
import '../../../../core/utils/helper_fuctions/format_validator.dart';
import '../../../../providers/Listing_provider/add_listing_provider.dart';
import '../../../common/custom_sizedBox.dart';
import '../../../common/custom_textfeild.dart';

class ListingDataFields extends ConsumerWidget {
  final GlobalKey<FormState> formKey ;
  const ListingDataFields({super.key,required this.formKey});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    var watchProvider = ref.watch(addListingProvider.notifier);
    return Form(
         key:formKey,
        child: Column(
          children: [
            const Sized(height: 0.05,),
            CustomTextField(
              controller: watchProvider.nameController,
              hintText: 'Title',
              validate: (value) {
                return FormValidators.validateNormalField(value, 'Title');
              },
            ),
            // Age input
            const Sized(height: 0.02,),
            CustomTextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              controller: watchProvider.ageController,
              hintText: 'Age in months',
              validate: (value) {
                return FormValidators.validateNormalField(value, 'Age in months');
              },
            ),
            // Price input
            const Sized(height: 0.02,),
            CustomTextField(
              keyboardType: TextInputType.numberWithOptions(decimal: false),
              controller: watchProvider.priceController,
              hintText: 'Price',
              validate: (value) {
                return FormValidators.validateNormalField(value, 'Price');
              },
            ),
            // Location input
            const Sized(height: 0.02,),
            CustomTextField(
              controller: watchProvider.locationController,
              hintText: 'Location',
              validate: (value) {
                return FormValidators.validateNormalField(value, 'Location');
              },
            ),
            // Phone input
            const Sized(height: 0.02,),
            CustomTextField(
              keyboardType: TextInputType.numberWithOptions(decimal: false),
              controller: watchProvider.phoneController,
              hintText: 'Phone',
              validate: (value) {
                return FormValidators.validateNormalField(value, 'Phone');
              },
            ),
            // WhatsApp input
            const Sized(height: 0.02,),
            CustomTextField(
              keyboardType: TextInputType.numberWithOptions(decimal: false),
              controller: watchProvider.whatsappController,
              hintText: 'WhatsApp',
              validate: (value) {
                return FormValidators.validateNormalField(value, 'WhatsApp');
              },
            ),
            // Gender input
            const Sized(height: 0.02,),
            Consumer(builder: (context,reference,_){
              print('gender');
              var state = reference.watch(addListingProvider.select((state)=> state.gender));
              return DropdownButtonFormField<GenderEnum>(
                value: state,
                onChanged: (newGender) {
                  if (newGender!= null) {
                    reference.read(addListingProvider.notifier).changeGender(newGender: newGender);
                  }
                },
                items: GenderEnum.values.map((GenderEnum gender) {
                  return DropdownMenuItem<GenderEnum>(
                    value: gender,
                    child: Text(gender.toString().split('.').last),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Select Gender Category'),
              );
            }),
            // Animal Category Dropdown
            const Sized(height: 0.02,),
            Consumer(builder: (context,reference,_){
              print('category');
              var state = reference.watch(addListingProvider.select((state)=> state.category));
              return  DropdownButtonFormField<AnimalsCategoryEnum>(
                value: state,
                onChanged: (newCategory) {
                  if (newCategory != null) {
                    reference.read(addListingProvider.notifier).changeCategory(newCategory: newCategory);
                  }
                },
                items: AnimalsCategoryEnum.values.map((AnimalsCategoryEnum category) {
                  return DropdownMenuItem<AnimalsCategoryEnum>(
                    value: category,
                    child: Text(category.toString().split('.').last),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Select Animal Category'),
              );
            }),
          ],
        ));
  }
}
