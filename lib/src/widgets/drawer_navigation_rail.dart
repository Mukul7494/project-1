import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../admin/admin_view.dart';

class DrawerNavRail extends StatefulWidget {
  const DrawerNavRail({super.key});

  @override
  State<DrawerNavRail> createState() => _DrawerNavRailState();
}

class _DrawerNavRailState extends State<DrawerNavRail> {
  var list = [
    AdminHomePage(),
    AdminHomePage(),
    AdminHomePage(),
    AdminHomePage(),
    AdminHomePage(),
    AdminHomePage(),
    AdminHomePage(),
  ];

  int _selectedIndex = 0;

  bool extended = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            SafeArea(
              child: IntrinsicWidth(
                child: NavigationRail(
                  backgroundColor: Color.fromARGB(255, 12, 3, 20),
                  minExtendedWidth: 160,
                  elevation: 6,
                  selectedIndex: _selectedIndex,
                  destinations: _buildDestinations(),
                  extended: extended,
                  onDestinationSelected: (int index) {
                    setState(() {
                      _selectedIndex = index;

                      if (_selectedIndex == 6) {
                        context.go('/login_choice');
                      }
                    });
                  },
                ),
              ),
            ),
            SafeArea(
              child: list[_selectedIndex],
            )
          ],
        ),
      ),
    );
  }

  List<NavigationRailDestination> _buildDestinations() {
    return [
      NavigationRailDestination(
        icon: InkWell(
          onTap: () {
            setState(() => extended = !extended);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                extended ? Icons.close : Icons.arrow_right,
                color: Colors.white,
              ),
            ],
          ),
        ),
        label: Container(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            '',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
      NavigationRailDestination(
        icon: Icon(
          Icons.home,
          color: Colors.white,
        ),
        label: Text(
          'Home',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      NavigationRailDestination(
        icon: Icon(
          Icons.person,
          color: Colors.white,
        ),
        label: Text(
          'Profile',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      NavigationRailDestination(
        icon: Icon(
          Icons.person_4,
          color: Colors.white,
        ),
        label: Text(
          'Teacher',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      NavigationRailDestination(
        icon: Icon(
          Icons.person_2,
          color: Colors.white,
        ),
        label: Text(
          'Student',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      NavigationRailDestination(
        icon: Icon(
          Icons.home,
          color: Colors.white,
        ),
        label: Text(
          'Home',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      NavigationRailDestination(
        icon: Icon(
          Icons.logout,
          color: Colors.white,
        ),
        label: Text(
          'LogOut',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    ];
  }
}
