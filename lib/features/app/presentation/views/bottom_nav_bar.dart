import 'package:car_monitor/features/app/presentation/manager/bottom_nav_cubit/bottom_nav_cubit.dart';
import 'package:car_monitor/features/home/presentation/views/home_screen.dart';
import 'package:car_monitor/screens/map_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../car_assets.dart';
import '../../../../screens/notification_screen.dart';
import '../../../../screens/porfile_screen.dart';
import '../../../../core/theme/color_styles.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = 56;

    const primaryColor = ColorStyles.primaryColor;
    const whiteColor = Colors.white;
    const backgroundColor = ColorStyles.primaryColor;

    return BlocBuilder<BottomNavCubit, BottomNavState>(
      builder: (context, state) {
        return Scaffold(
          body: PageView(
            controller: context.read<BottomNavCubit>().pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              const HomeScreen(),
              const NotificationScreen(),
              MapScreen(
                  updateDistance:
                      context.read<BottomNavCubit>().updateNearestDistance),
              const ProfileScreen(),
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            color: Colors.transparent,
            elevation: 0,
            child: Stack(
              children: [
                CustomPaint(
                  size: Size(size.width, height + 7),
                  painter:
                      BottomNavCurvePainter(backgroundColor: backgroundColor),
                ),
                Center(
                  heightFactor: 0.4,
                  child: FloatingActionButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0)),
                    backgroundColor: whiteColor,
                    elevation: 0.1,
                    onPressed: () {
                      // Add your onPressed code here!
                    },
                    child: Image.asset(
                      Assets.assetsAssetsLogoTranc,
                      width: 70,
                      height: 70,
                    ),
                  ),
                ),
                SizedBox(
                  height: height,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      NavBarIcon(
                        text: "Home",
                        icon: CupertinoIcons.home,
                        selected: state.selectedIndex == 0,
                        onPressed: () =>
                            context.read<BottomNavCubit>().changeBottomNav(0),
                        defaultColor: whiteColor,
                        selectedColor: primaryColor,
                      ),
                      NavBarIcon(
                        text: "Notifications",
                        icon: CupertinoIcons.bell,
                        selected: state.selectedIndex == 1,
                        onPressed: () =>
                            context.read<BottomNavCubit>().changeBottomNav(1),
                        defaultColor: whiteColor,
                        selectedColor: primaryColor,
                      ),
                      const SizedBox(width: 56),
                      NavBarIcon(
                        text: "Map",
                        icon: Icons.map_outlined,
                        selected: state.selectedIndex == 2,
                        onPressed: () =>
                            context.read<BottomNavCubit>().changeBottomNav(2),
                        defaultColor: whiteColor,
                        selectedColor: primaryColor,
                      ),
                      NavBarIcon(
                        text: "Account",
                        icon: CupertinoIcons.person,
                        selected: state.selectedIndex == 3,
                        onPressed: () =>
                            context.read<BottomNavCubit>().changeBottomNav(3),
                        selectedColor: primaryColor,
                        defaultColor: whiteColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class BottomNavCurvePainter extends CustomPainter {
  BottomNavCurvePainter(
      {this.backgroundColor = Colors.black, this.insetRadius = 38});

  final Color backgroundColor;
  final double insetRadius;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 12);

    double insetCurveBeginnningX = size.width / 2 - insetRadius;
    double insetCurveEndX = size.width / 2 + insetRadius;
    double transitionToInsetCurveWidth = size.width * .05;

    path.quadraticBezierTo(size.width * 0.20, 0,
        insetCurveBeginnningX - transitionToInsetCurveWidth, 0);
    path.quadraticBezierTo(
        insetCurveBeginnningX, 0, insetCurveBeginnningX, insetRadius / 2);

    path.arcToPoint(Offset(insetCurveEndX, insetRadius / 2),
        radius: const Radius.circular(10.0), clockwise: false);

    path.quadraticBezierTo(
        insetCurveEndX, 0, insetCurveEndX + transitionToInsetCurveWidth, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 12);
    path.lineTo(size.width, size.height + 56);
    path.lineTo(0, size.height + 56);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class NavBarIcon extends StatelessWidget {
  const NavBarIcon({
    super.key,
    required this.text,
    required this.icon,
    required this.selected,
    required this.onPressed,
    this.selectedColor = const Color(0xffFF8527),
    this.defaultColor = Colors.black54,
  });

  final String text;
  final IconData icon;
  final bool selected;
  final Function() onPressed;
  final Color defaultColor;
  final Color selectedColor;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      icon: CircleAvatar(
        backgroundColor: selected ? Colors.white : Colors.transparent,
        child: Icon(
          icon,
          size: 25,
          color: selected ? Colors.black : defaultColor,
        ),
      ),
    );
  }
}
