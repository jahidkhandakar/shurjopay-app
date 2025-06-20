import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 4, 216, 114),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 27),
                Center(
                  child: Text(
                    'shurjoPay',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.home,
              color: Color.fromARGB(255, 4, 216, 114),
            ),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.description,
              color: Color.fromARGB(255, 4, 216, 114),
            ),
            title: const Text('Statement'),
            onTap: () {
              Navigator.pushNamed(context, '/statement');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.credit_card,
              color: Color.fromARGB(255, 4, 216, 114),
            ),
            title: const Text('Saved Cards'),
            onTap: () {
              Navigator.pushNamed(context, '/card');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
              color: Color.fromARGB(255, 4, 216, 114),
            ),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.verified_user,
              color: Color.fromARGB(255, 4, 216, 114),
            ),
            title: const Text('EKYC'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.person_add,
              color: Color.fromARGB(255, 4, 216, 114),
            ),
            title: const Text('Refer a friend'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.description_outlined,
              color: Color.fromARGB(255, 4, 216, 114),
            ),
            title: const Text('Terms & Conditions'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.privacy_tip,
              color: Color.fromARGB(255, 4, 216, 114),
            ),
            title: const Text('Privacy Policy'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.support_agent,
              color: Color.fromARGB(255, 4, 216, 114),
            ),
            title: const Text('Support'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          // const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
