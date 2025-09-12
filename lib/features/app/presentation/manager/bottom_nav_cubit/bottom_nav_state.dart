part of 'bottom_nav_cubit.dart';

@immutable
class BottomNavState {
  final int selectedIndex;
  final double? nearestDistance;

  const BottomNavState({
    this.selectedIndex = 0,
    this.nearestDistance,
  });

  BottomNavState copyWith({
    int? selectedIndex,
    double? nearestDistance,
  }) {
    return BottomNavState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      nearestDistance: nearestDistance ?? this.nearestDistance,
    );
  }
}

final class BottomNavInitial extends BottomNavState {}
