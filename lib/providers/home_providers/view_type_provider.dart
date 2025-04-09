import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/enum/other_enum.dart';




final homeViewTypeProvider = StateNotifierProvider<HomeViewTypeNotifier,HomeViewTypeState>((ref){
  return HomeViewTypeNotifier();
});


class HomeViewTypeNotifier extends StateNotifier<HomeViewTypeState> {
  HomeViewTypeNotifier(): super(HomeViewTypeState(isGridView: true));

  void changeViewType(){
    state = state.copyWith(isGridView: !state.isGridView);
  }
}



class HomeViewTypeState {
  final bool isGridView;
  HomeViewTypeState({required this.isGridView});
  HomeViewTypeState  copyWith({bool ? isGridView}){
    return HomeViewTypeState(isGridView: isGridView ?? this.isGridView);
  }
}
