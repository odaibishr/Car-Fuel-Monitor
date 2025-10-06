import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'bottom_nav_state.dart';

class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavCubit() : super(const BottomNavState());

  final PageController pageController = PageController();

  void changeBottomNav(int index) {
    if (index < 0 || index >= 4) return; // We have 4 pages (0-3)
    if (index == state.selectedIndex) return;

    emit(state.copyWith(selectedIndex: index));
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastEaseInToSlowEaseOut,
    );
  }

  @override
  Future<void> close() {
    pageController.dispose(); // Dispose the controller when cubit is closed
    return super.close();
  }
}
