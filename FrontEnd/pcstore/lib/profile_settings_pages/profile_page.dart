import 'package:flutter/material.dart';
import 'package:pcstore/auth_pages/login_page.dart';
import 'package:pcstore/profile_settings_pages/order_page.dart';
import 'package:pcstore/profile_settings_pages/profile_data_page.dart';
import 'package:pcstore/profile_settings_pages/wishlist_page.dart';
import 'package:pcstore/provider/user_provider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isDarkMode = false;
  String selectedLanguage = 'English';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false).refreshUserDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          final user = userProvider.user;
          final userName = user['name'] ?? 'Guest';

          return ListView(
            children: [
              const SizedBox(height: 20),
              const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage('https://placeholder.com/150'),
              ),
              const SizedBox(height: 10),
              Text(
                userName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              _buildSection(
                'Personal Information',
                [
                  _buildListTile(
                    'Edit Profile',
                    Icons.person,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileDataPage(),
                      ),
                    ),
                  ),
                  _buildListTile(
                    'Manage Addresses',
                    Icons.location_on,
                    () => _showManageAddressesDialog(context),
                  ),
                ],
              ),
              _buildSection(
                'Orders & Wishlist',
                [
                  _buildListTile(
                    'My Orders',
                    Icons.shopping_bag,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OrdersPage()),
                      );
                    },
                  ),
                  _buildListTile(
                    'My Wishlist',
                    Icons.favorite,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WishlistPage()),
                      );
                    },
                  ),
                ],
              ),
              _buildSection(
                'Settings',
                [
                  SwitchListTile(
                    title: const Text('Dark Mode'),
                    secondary: const Icon(Icons.dark_mode),
                    value: isDarkMode,
                    onChanged: (value) {
                      setState(() {
                        isDarkMode = value;
                      });
                    },
                  ),
                  ListTile(
                    title: const Text('Language'),
                    leading: const Icon(Icons.language),
                    trailing: DropdownButton<String>(
                      value: selectedLanguage,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            selectedLanguage = newValue;
                          });
                        }
                      },
                      items: <String>['English', 'Spanish', 'French', 'German']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  _buildListTile(
                    'About Us',
                    Icons.info,
                    () {
                      Navigator.pushNamed(context, '/about');
                    },
                  ),
                ],
              ),
              _buildSection(
                'Support',
                [
                  _buildListTile(
                    'Help Center',
                    Icons.help,
                    () {},
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    await Provider.of<UserProvider>(context, listen: false)
                        .logout();
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      (route) => false,
                    );
                  },
                  child: const Text('Logout'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ...children,
        const Divider(),
      ],
    );
  }

  Widget _buildListTile(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  void _showManageAddressesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Manage Addresses'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text('Home'),
                  subtitle: const Text('123 Main St, City, Country'),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {},
                  ),
                ),
                ListTile(
                  title: const Text('Work'),
                  subtitle: const Text('456 Office Rd, City, Country'),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {},
                  ),
                ),
                ElevatedButton(
                  child: const Text('Add New Address'),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
