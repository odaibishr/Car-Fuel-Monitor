import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'bottom_nav_state.dart';

class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavCubit() : super(const BottomNavState());

  final PageController pageController = PageController();

  void changeBottomNav(int index) {
    if (index == state.selectedIndex) return;
    emit(state.copyWith(selectedIndex: index));
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastEaseInToSlowEaseOut,
    );
  }

  void updateNearestDistance(double distanceKm) {
    emit(state.copyWith(nearestDistance: distanceKm));
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
