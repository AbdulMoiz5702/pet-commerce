
import 'package:animals/view/common/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/enum/animals_categpry_enum.dart';
import '../../../../providers/filters_provider/filters_provider.dart';

class FilterWidget extends ConsumerStatefulWidget {
  const FilterWidget({super.key});

  @override
  ConsumerState<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends ConsumerState<FilterWidget> {
  late TextEditingController _locationController;

  @override
  void initState() {
    super.initState();
    final filters = ref.read(filterProvider);
    _locationController = TextEditingController(text: filters.location ?? '');
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer(builder: (context,reference,_){
          var state = reference.watch((filterProvider.select((state)=> state.gender)));
          return  DropdownButton<GenderEnum>(
            value: state,
            hint: Text('Select Gender'),
            onChanged: (value) {
              reference.read(filterProvider.notifier).updateGender(value);
            },
            items: GenderEnum.values.map((gender) {
              return DropdownMenuItem(
                value: gender,
                child: Text(gender.name),
              );
            }).toList(),
          );
        }),
        Consumer(builder: (context,reference,_){
          var state = reference.watch((filterProvider.select((state)=> state.category)));
         return DropdownButton<AnimalsCategoryEnum>(
            value: state,
            hint: Text('Select Category'),
            onChanged: (value) {
              ref.read(filterProvider.notifier).updateCategory(value);
            },
            items: AnimalsCategoryEnum.values.map((category) {
              return DropdownMenuItem(
                value: category,
                child: Text(category.name),
              );
            }).toList(),
          );
        }),
        Consumer(builder: (context,reference,_){
          var state = reference.watch((filterProvider.select((state)=> state.location)));
          return TextField(
            controller: _locationController,
            decoration: InputDecoration(labelText: 'Enter Location'),
            onChanged: (value) {
              ref.read(filterProvider.notifier).updateLocation(value);
            },
          );
        }),
        Consumer(builder: (context,reference,_){
          var stateMAx = reference.watch((filterProvider.select((state)=> state.maxPrice)));
          var stateMIn = reference.watch((filterProvider.select((state)=> state.minPrice)));
          return RangeSlider(
            values: RangeValues(stateMIn, stateMAx),
            min: 0,
            max: 100000,
            divisions: 100,
            onChanged: (values) {
              ref.read(filterProvider.notifier).updatePriceRange(values.start, values.end);
            },
          );
        }),
        Consumer(builder: (context,reference,_){
          return  CustomButton(title: 'Reset Filter', onTap: (){
            reference.read(filterProvider.notifier).resetFilters();
          });
        }),
      ],
    );
  }
}

