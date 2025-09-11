import 'package:car_monitor/screens/map_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../car_assets.dart';
import '../screens/home_screen.dart';
import '../screens/notification_screen.dart';
import '../screens/porfile_screen.dart';
import '../core/theme/color_styles.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  BottomNavBarState createState() => BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  double? nearestDistance; // Distance to the nearest fuel station
  final PageController _pageController = PageController();

  void _onNavBarItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void updateDistance(double newDistance) { 
    setState(() {
      nearestDistance = newDistance;
    });
  } 

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = 56;

    const primaryColor = ColorStyles.primaryColor;
    const whiteColor = Colors.white;
    const backgroundColor = ColorStyles.primaryColor;

    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children:  [
          HomeScreen(nearestDistance: nearestDistance == null ? 0.0 : nearestDistance!,),
          const NotificationScreen(),
          MapScreen(updateDistance: updateDistance),
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
              painter: BottomNavCurvePainter(backgroundColor: backgroundColor),
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
                    selected: _selectedIndex == 0,
                    onPressed: () => _onNavBarItemTapped(0),
                    defaultColor: whiteColor,
                    selectedColor: primaryColor,
                  ),
                  NavBarIcon(
                    text: "Notifications",
                    icon: CupertinoIcons.bell,
                    selected: _selectedIndex == 1,
                    onPressed: () => _onNavBarItemTapped(1),
                    defaultColor: whiteColor,
                    selectedColor: primaryColor,
                  ),
                  const SizedBox(width: 56),
                  NavBarIcon(
                    text: "Map",
                    icon: Icons.map_outlined,
                    selected: _selectedIndex == 2,
                    onPressed: () => _onNavBarItemTapped(2),
                    defaultColor: whiteColor,
                    selectedColor: primaryColor,
                  ),
                  NavBarIcon(
                    text: "Account",
                    icon: CupertinoIcons.person,
                    selected: _selectedIndex == 3,
                    onPressed: () => _onNavBarItemTapped(3),
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
