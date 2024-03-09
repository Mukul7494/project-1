import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.arrow_back),
              title: const Text("Back"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(Icons.person_add),
                    title: const Text("Add Student"),
                    onTap: () => context.push("/createStudentFormPage"),
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text("Students List"),
                    onTap: () => context.push("/studentListPage"),
                  ),
                  ListTile(
                    leading: const Icon(Icons.apartment),
                    title: const Text("Book to Stay"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.airplanemode_active),
                    title: const Text("Book a Flight"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.map),
                    title: const Text("Book an Activity"),
                    onTap: () {},
                  ),
                  const Divider(color: Colors.black),
                  const ListTile(
                    title: Text("My profile"),
                    textColor: Colors.grey,
                  ),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text("Home"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.luggage),
                    title: const Text("My Trip"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.thumb_up),
                    title: const Text("Vote"),
                    onTap: () {},
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                            width: 125,
                            height: 30,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Text(
                              'Activate NFT',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            )),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                            width: 125,
                            height: 30,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 16, 23, 103),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Text(
                              'Explore NFT',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            )),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text("Login"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.person_add_alt_1_outlined,
                      color: Colors.blue,
                    ),
                    title: const Text("Sign Up Now",
                        style: TextStyle(color: Colors.blue)),
                    onTap: () {},
                  ),
                  const Divider(color: Colors.black),
                  const ListTile(
                    title: Text("Settings"),
                    textColor: Colors.grey,
                  ),
                  ListTile(
                    leading: const Icon(Icons.abc_outlined),
                    title: const Text("Languages"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.price_check),
                    title: const Text("Popular Currencies"),
                    onTap: () {},
                  ),
                  const Divider(color: Colors.black),
                  ListTile(
                    leading: const Icon(Icons.chat),
                    title: const Text("About Us"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.post_add),
                    title: const Text("Invite Program"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.lightbulb_outline),
                    title: const Text("Smart Program"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.check_circle_outline),
                    title: const Text("Best Price Gurantee"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.shield_moon_outlined),
                    title: const Text("TravelSmart Protection"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.card_giftcard),
                    title: const Text("Travel gift Cards"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.card_membership_outlined),
                    title: const Text("Payment Options"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.shield_outlined),
                    title: const Text("Privacy Policy"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.cookie_outlined),
                    title: const Text("Cookie policy"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.call),
                    title: const Text("Contact"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.pageview_outlined),
                    title: const Text(" Terms And Conditions"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.question_mark_rounded),
                    title: const Text("Help"),
                    onTap: () {},
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
