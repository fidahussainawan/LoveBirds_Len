// // settings_screen.dart
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/theme_provider.dart';
// import '../providers/auth_provider.dart';
// import '../utils/constants.dart';
// import '../screens/auth_screen.dart';
//
// class SettingsScreen extends StatelessWidget {
//   const SettingsScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Settings',
//           style: TextStyle(fontWeight: FontWeight.w600),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: Consumer2<ThemeProvider, AuthProvider>(
//         builder: (context, themeProvider, authProvider, child) {
//           return ListView(
//             padding: const EdgeInsets.all(16),
//             children: [
//               // Account section
//               _buildSectionHeader('Account'),
//               if (authProvider.isSignedIn) ...[
//                 _buildUserInfoCard(authProvider),
//                 const SizedBox(height: 16),
//                 _buildSettingsTile(
//                   icon: Icons.logout,
//                   title: 'Sign Out',
//                   subtitle: 'Sign out from your account',
//                   onTap: () => _showSignOutDialog(context, authProvider),
//                   color: Colors.red,
//                 ),
//               ] else ...[
//                 _buildSettingsTile(
//                   icon: Icons.login,
//                   title: 'Sign In',
//                   subtitle: 'Sign in to save your birds',
//                   onTap: () {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => const AuthScreen(),
//                       ),
//                     );
//                   },
//                   color: AppColors.primaryGreen,
//                 ),
//                 const SizedBox(height: 16),
//                 _buildSettingsTile(
//                   icon: Icons.person_add,
//                   title: 'Create Account',
//                   subtitle: 'Create a new account',
//                   onTap: () {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => const AuthScreen(),
//                       ),
//                     );
//                   },
//                   color: AppColors.lightGreen,
//                 ),
//               ],
//
//               const SizedBox(height: 32),
//
//               // General section
//               _buildSectionHeader('General'),
//               _buildThemeToggle(themeProvider),
//               const SizedBox(height: 16),
//               _buildSettingsTile(
//                 icon: Icons.share,
//                 title: 'Share This App',
//                 subtitle: 'Share with friends and family',
//                 onTap: () => _shareApp(context),
//               ),
//               const SizedBox(height: 16),
//               _buildSettingsTile(
//                 icon: Icons.star_rate,
//                 title: 'Rate Us',
//                 subtitle: 'Rate us on the app store',
//                 onTap: () => _rateApp(context),
//               ),
//
//               const SizedBox(height: 32),
//
//               // About section
//               _buildSectionHeader('About'),
//               _buildSettingsTile(
//                 icon: Icons.info,
//                 title: 'About',
//                 subtitle: 'Version 1.0.0',
//                 onTap: () => _showAboutDialog(context),
//               ),
//
//               const SizedBox(height: 32),
//
//               // App info
//               Center(
//                 child: Column(
//                   children: [
//                     Container(
//                       width: 80,
//                       height: 80,
//                       decoration: BoxDecoration(
//                         color: AppColors.primaryGreen.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Icon(
//                         Icons.pets,
//                         size: 40,
//                         color: AppColors.primaryGreen,
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     const Text(
//                       'Lovebirds Lens',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       'AI-powered bird identification',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 32),
//             ],
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildSectionHeader(String title) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16),
//       child: Text(
//         title,
//         style: const TextStyle(
//           fontSize: 18,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildUserInfoCard(AuthProvider authProvider) {
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Row(
//           children: [
//             CircleAvatar(
//               radius: 30,
//               backgroundColor: AppColors.primaryGreen.withOpacity(0.1),
//               child: Icon(
//                 Icons.person,
//                 color: AppColors.primaryGreen,
//                 size: 30,
//               ),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     authProvider.userName,
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     authProvider.userEmail,
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildThemeToggle(ThemeProvider themeProvider) {
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: ListTile(
//         leading: Container(
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: AppColors.primaryGreen.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Icon(
//             themeProvider.isDarkTheme ? Icons.dark_mode : Icons.light_mode,
//             color: AppColors.primaryGreen,
//           ),
//         ),
//         title: const Text(
//           'Theme',
//           style: TextStyle(fontWeight: FontWeight.w600),
//         ),
//         subtitle: Text(themeProvider.isDarkTheme ? 'Dark Mode' : 'Light Mode'),
//         trailing: Switch(
//           value: themeProvider.isDarkTheme,
//           onChanged: (value) => themeProvider.toggleTheme(),
//           activeColor: AppColors.primaryGreen,
//         ),
//         contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//       ),
//     );
//   }
//
//   Widget _buildSettingsTile({
//     required IconData icon,
//     required String title,
//     required String subtitle,
//     required VoidCallback onTap,
//     Color? color,
//   }) {
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: ListTile(
//         leading: Container(
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: (color ?? AppColors.primaryGreen).withOpacity(0.1),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Icon(
//             icon,
//             color: color ?? AppColors.primaryGreen,
//           ),
//         ),
//         title: Text(
//           title,
//           style: const TextStyle(fontWeight: FontWeight.w600),
//         ),
//         subtitle: Text(subtitle),
//         trailing: const Icon(Icons.chevron_right),
//         onTap: onTap,
//         contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//       ),
//     );
//   }
//
//   void _showSignOutDialog(BuildContext context, AuthProvider authProvider) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Sign Out'),
//         content: const Text('Are you sure you want to sign out?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//               authProvider.signOut();
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(
//                   content: Text('Signed out successfully'),
//                   backgroundColor: AppColors.primaryGreen,
//                 ),
//               );
//             },
//             style: TextButton.styleFrom(foregroundColor: Colors.red),
//             child: const Text('Sign Out'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _shareApp(BuildContext context) {
//     // In a real app, you would use share_plus package
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Share functionality would be implemented here'),
//         backgroundColor: AppColors.primaryGreen,
//       ),
//     );
//   }
//
//   void _rateApp(BuildContext context) {
//     // In a real app, you would use url_launcher to open app store
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Rate app functionality would be implemented here'),
//         backgroundColor: AppColors.primaryGreen,
//       ),
//     );
//   }
//
//   void _showAboutDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('About Lovebirds Lens'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text('Version: 1.0.0'),
//             const SizedBox(height: 8),
//             const Text('An AI-powered bird identification app that helps you discover and learn about different bird species.'),
//             const SizedBox(height: 16),
//             const Text(
//               'Features:',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 4),
//             const Text('• AI bird identification'),
//             const Text('• Personal bird collection'),
//             const Text('• Detailed bird information'),
//             const Text('• Dark/Light theme support'),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: const Text('Close'),
//           ),
//         ],
//       ),
//     );
//   }
// }


// settings_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/auth_provider.dart';
import '../utils/constants.dart';
import '../screens/auth_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Consumer2<ThemeProvider, AuthProvider>(
        builder: (context, themeProvider, authProvider, child) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Account section
              _buildSectionHeader('Account'),
              if (authProvider.isSignedIn) ...[
                _buildUserInfoCard(authProvider),
                const SizedBox(height: 16),
                _buildSettingsTile(
                  icon: Icons.logout,
                  title: 'Sign Out',
                  subtitle: 'Sign out from your account',
                  onTap: () => _showSignOutDialog(context, authProvider),
                  color: Colors.red,
                ),
              ] else ...[
                _buildSettingsTile(
                  icon: Icons.login,
                  title: 'Sign In',
                  subtitle: 'Sign in to save your birds',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AuthScreen(),
                      ),
                    );
                  },
                  color: const Color(0xFF4CAF50), // AppColors.primaryGreen
                ),
                const SizedBox(height: 16),
                _buildSettingsTile(
                  icon: Icons.person_add,
                  title: 'Create Account',
                  subtitle: 'Create a new account',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AuthScreen(),
                      ),
                    );
                  },
                  color: const Color(0xFF8BC34A), // AppColors.lightGreen
                ),
              ],

              const SizedBox(height: 32),

              // General section
              _buildSectionHeader('General'),
              _buildThemeToggle(themeProvider),
              const SizedBox(height: 16),
              _buildSettingsTile(
                icon: Icons.share,
                title: 'Share This App',
                subtitle: 'Share with friends and family',
                onTap: () => _shareApp(context),
              ),
              const SizedBox(height: 16),
              _buildSettingsTile(
                icon: Icons.star_rate,
                title: 'Rate Us',
                subtitle: 'Rate us on the app store',
                onTap: () => _rateApp(context),
              ),

              const SizedBox(height: 32),

              // About section
              _buildSectionHeader('About'),
              _buildSettingsTile(
                icon: Icons.info,
                title: 'About',
                subtitle: 'Version 1.0.0',
                onTap: () => _showAboutDialog(context),
              ),

              const SizedBox(height: 32),

              // App info
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: const Color(0xFF4CAF50).withOpacity(0.1), // AppColors.primaryGreen
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.pets,
                        size: 40,
                        color: Color(0xFF4CAF50), // AppColors.primaryGreen
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Lovebirds Lens',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'AI-powered bird identification',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildUserInfoCard(AuthProvider authProvider) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: const Color(0xFF4CAF50).withOpacity(0.1), // AppColors.primaryGreen
              child: const Icon(
                Icons.person,
                color: Color(0xFF4CAF50), // AppColors.primaryGreen
                size: 30,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    authProvider.userName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Builder(
                    builder: (context) {
                      return Text(
                        authProvider.userEmail,
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeToggle(ThemeProvider themeProvider) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF4CAF50).withOpacity(0.1), // AppColors.primaryGreen
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            themeProvider.isDarkTheme ? Icons.dark_mode : Icons.light_mode,
            color: const Color(0xFF4CAF50), // AppColors.primaryGreen
          ),
        ),
        title: const Text(
          'Theme',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(themeProvider.isDarkTheme ? 'Dark Mode' : 'Light Mode'),
        trailing: Switch(
          value: themeProvider.isDarkTheme,
          onChanged: (value) => themeProvider.toggleTheme(),
          activeColor: const Color(0xFF4CAF50), // AppColors.primaryGreen
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? color,
  }) {
    const defaultColor = Color(0xFF4CAF50); // AppColors.primaryGreen
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: (color ?? defaultColor).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: color ?? defaultColor,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      ),
    );
  }

  void _showSignOutDialog(BuildContext context, AuthProvider authProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              authProvider.signOut();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Signed out successfully'),
                  backgroundColor: const Color(0xFF4CAF50), // AppColors.primaryGreen
                ),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }

  void _shareApp(BuildContext context) {
    // In a real app, you would use share_plus package
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Share functionality would be implemented here'),
        backgroundColor: const Color(0xFF4CAF50), // AppColors.primaryGreen
      ),
    );
  }

  void _rateApp(BuildContext context) {
    // In a real app, you would use url_launcher to open app store
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Rate app functionality would be implemented here'),
        backgroundColor: const Color(0xFF4CAF50), // AppColors.primaryGreen
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About Lovebirds Lens'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Version: 1.0.0'),
            SizedBox(height: 8),
            Text('An AI-powered bird identification app that helps you discover and learn about different bird species.'),
            SizedBox(height: 16),
            Text(
              'Features:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text('• AI bird identification'),
            Text('• Personal bird collection'),
            Text('• Detailed bird information'),
            Text('• Dark/Light theme support'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}