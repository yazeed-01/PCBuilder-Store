import 'package:flutter/material.dart';
import 'package:pcstore/provider/user_provider.dart';
import 'package:pcstore/services/auth_service.dart';
import 'package:provider/provider.dart';

class ProfileDataPage extends StatefulWidget {
  @override
  _ProfileDataPageState createState() => _ProfileDataPageState();
}

class _ProfileDataPageState extends State<ProfileDataPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final AuthService _authService = AuthService();

  bool _isEmailExpanded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false).refreshUserDetails();
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _ageController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        final user = userProvider.user;
        _usernameController.text = user['username'] ?? '';
        _emailController.text = user['email'] ?? '';
        _phoneController.text = user['phone']?.toString() ?? '';
        _ageController.text = user['age']?.toString() ?? '';

        return Theme(
          data: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: const Color(0xFF1A1A1A),
            cardColor: const Color(0xFF2A2A2A),
          ),
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              title: const Text('Profile Settings'),
              backgroundColor: const Color(0xFF2A2A2A),
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Profile Photo Section
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(user['profilePhotoUrl'] ??
                                  'https://via.placeholder.com/150'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: IconButton(
                            icon: const Icon(Icons.camera_alt,
                                color: Colors.white),
                            onPressed: () {
                              // Handle profile photo change
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // User Info Section
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome, ${user['username'] ?? 'User'}',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Email: ${user['email'] ?? 'N/A'}',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Phone: ${user['phone']?.toString() ?? 'N/A'}',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Age: ${user['age']?.toString() ?? 'N/A'}',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Email Section
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ExpansionTile(
                        initiallyExpanded: _isEmailExpanded,
                        title: const Text('Email Settings'),
                        leading: const Icon(Icons.email_outlined),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                TextField(
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    prefixIcon: const Icon(Icons.email),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () async {
                                    try {
                                      await _authService
                                          .updateUser(user['_id'], {
                                        'email': _emailController.text,
                                      });
                                      userProvider.refreshUserDetails();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Email updated successfully')),
                                      );
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Failed to update email: $e')),
                                      );
                                    }
                                  },
                                  child: const Text('Update Email'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Username Section
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ExpansionTile(
                        initiallyExpanded: _isEmailExpanded,
                        title: const Text('Username Settings'),
                        leading: const Icon(Icons.person),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                TextField(
                                  controller: _usernameController,
                                  decoration: InputDecoration(
                                    labelText: 'Username',
                                    prefixIcon: const Icon(Icons.person),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () async {
                                    try {
                                      await _authService
                                          .updateUser(user['_id'], {
                                        'username': _usernameController.text,
                                      });
                                      userProvider.refreshUserDetails();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Username updated successfully')),
                                      );
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Failed to update Username: $e')),
                                      );
                                    }
                                  },
                                  child: const Text('Update Username'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                    // Phone Section
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ExpansionTile(
                        title: const Text('Phone Settings'),
                        leading: const Icon(Icons.phone_android_outlined),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                TextField(
                                  controller: _phoneController,
                                  decoration: InputDecoration(
                                    labelText: 'Phone',
                                    prefixIcon: const Icon(Icons.phone),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () async {
                                    try {
                                      await _authService
                                          .updateUser(user['_id'], {
                                        'phone': _phoneController.text,
                                      });
                                      userProvider.refreshUserDetails();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Phone updated successfully')),
                                      );
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Failed to update phone: $e')),
                                      );
                                    }
                                  },
                                  child: const Text('Update Phone'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Age Section
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ExpansionTile(
                        title: const Text('Age Settings'),
                        leading: const Icon(Icons.calendar_month_outlined),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                TextField(
                                  controller: _ageController,
                                  decoration: InputDecoration(
                                    labelText: 'Age',
                                    prefixIcon:
                                        const Icon(Icons.calendar_today),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () async {
                                    try {
                                      await _authService
                                          .updateUser(user['_id'], {
                                        'age': int.parse(_ageController.text),
                                      });
                                      userProvider.refreshUserDetails();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Age updated successfully')),
                                      );
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Failed to update age: $e')),
                                      );
                                    }
                                  },
                                  child: const Text('Update Age'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Password Section
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ExpansionTile(
                        title: const Text('Password Settings'),
                        leading: const Icon(Icons.lock_outline),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                TextField(
                                  controller: _currentPasswordController,
                                  decoration: InputDecoration(
                                    labelText: 'Current Password',
                                    prefixIcon: const Icon(Icons.lock),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  obscureText: true,
                                ),
                                const SizedBox(height: 16),
                                TextField(
                                  controller: _newPasswordController,
                                  decoration: InputDecoration(
                                    labelText: 'New Password',
                                    prefixIcon: const Icon(Icons.lock),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  obscureText: true,
                                ),
                                const SizedBox(height: 16),
                                TextField(
                                  controller: _confirmPasswordController,
                                  decoration: InputDecoration(
                                    labelText: 'Confirm Password',
                                    prefixIcon: const Icon(Icons.lock),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  obscureText: true,
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () {
                                    // Handle password update
                                  },
                                  child: const Text('Update Password'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
