import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';
import '../theme/app_theme.dart';
import 'package:countup/countup.dart';
import '../models/app_user.dart';
import '../models/bank_account_details.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _bankNameController = TextEditingController();
  final _accountHolderNameController = TextEditingController();
  final _accountNumberController = TextEditingController();
  String? _appVersion;
  bool _isEditingBankDetails = false;
  bool _isSavingBankDetails = false;
  String? _bankDetailsError;

  @override
  void initState() {
    super.initState();
    _loadAppVersion();
  }

  Future<void> _loadAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _appVersion = packageInfo.version;
    });
  }

  @override
  void dispose() {
    _bankNameController.dispose();
    _accountHolderNameController.dispose();
    _accountNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(currentUserProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryGreen,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () => _showLogoutConfirmation(context),
          ),
        ],
      ),
      body: userAsync.when(
        data: (appUser) {
          if (appUser == null) return const SizedBox.shrink();

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(currentUserProvider);
            },
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                // Profile Header
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryGreen,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(32),
                        bottomRight: Radius.circular(32),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 3,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.white,
                            backgroundImage: appUser.photoUrl != null ? NetworkImage(appUser.photoUrl!) : null,
                            child: appUser.photoUrl == null
                                ? const Icon(Icons.person, size: 50, color: AppTheme.primaryGreen)
                                : null,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          appUser.displayName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (appUser.bio != null) ...[
                          const SizedBox(height: 8),
                          Text(
                            appUser.bio!,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),

                // Stats Section
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Achievements',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textDark,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildAchievementCard(
                          'Total Earnings',
                          '\$${appUser.totalEarnings.toStringAsFixed(2)}',
                          Icons.attach_money,
                          AppTheme.primaryGreen,
                        ),
                        const SizedBox(height: 12),
                        _buildAchievementCard(
                          'Total Paid',
                          '\$${appUser.totalPaid.toStringAsFixed(2)}',
                          Icons.payments,
                          AppTheme.warningYellow,
                        ),
                        const SizedBox(height: 12),
                        _buildAchievementCard(
                          'Preferred Language',
                          appUser.preferredLanguage,
                          Icons.language,
                          AppTheme.primaryRed,
                        ),
                      ],
                    ),
                  ),
                ),

                // Settings Section
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Settings',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textDark,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildBankDetailsCard(appUser),
                        const SizedBox(height: 12),
                        _buildSettingsCard(
                          'Language',
                          appUser.preferredLanguage,
                          Icons.language,
                          onTap: () {
                            // TODO: Navigate to language settings
                          },
                        ),
                        const SizedBox(height: 12),
                        _buildSettingsCard(
                          'Help & Support',
                          'Get assistance',
                          Icons.help,
                          onTap: () {
                            // TODO: Navigate to help
                          },
                        ),
                        const SizedBox(height: 12),
                        _buildSettingsCard(
                          'Privacy Policy',
                          'Read our privacy policy',
                          Icons.privacy_tip,
                          onTap: () async {
                            final url = Uri.parse('https://deedscircle.com/privacy');
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                // Footer
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.favorite,
                              color: AppTheme.primaryRed,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Made with love by Asif',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        if (_appVersion != null) ...[
                          const SizedBox(height: 8),
                          Text(
                            'Version $_appVersion',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryGreen),
          ),
        ),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                color: AppTheme.errorRed,
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(
                'Error: ${error.toString()}',
                style: const TextStyle(color: AppTheme.errorRed),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAchievementCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textDark,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBankDetailsCard(AppUser appUser) {
    final details = appUser.bankAccountDetails;
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: AppTheme.primaryGreen.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.account_balance, color: AppTheme.primaryGreen),
                    const SizedBox(width: 8),
                    Text(
                      'Bank Account',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textDark,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(_isEditingBankDetails ? Icons.close : Icons.edit, color: AppTheme.primaryGreen),
                  onPressed: () {
                    setState(() {
                      _bankDetailsError = null;
                      _isEditingBankDetails = !_isEditingBankDetails;
                      if (_isEditingBankDetails && details != null) {
                        _bankNameController.text = details.bankName;
                        _accountHolderNameController.text = details.accountHolderName;
                        _accountNumberController.text = details.accountNumber;
                      } else if (_isEditingBankDetails) {
                        _bankNameController.clear();
                        _accountHolderNameController.clear();
                        _accountNumberController.clear();
                      }
                    });
                  },
                ),
              ],
            ),
            if (!_isEditingBankDetails)
              details != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        _bankDetailRow('Bank Name', details.bankName),
                        _bankDetailRow('Account Holder', details.accountHolderName),
                        _bankDetailRow('Account Number', details.accountNumber),
                        if (details.isVerified)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              children: [
                                Icon(Icons.verified, color: Colors.green, size: 18),
                                const SizedBox(width: 4),
                                Text('Verified',
                                    style: TextStyle(color: Colors.green[700], fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('Not Connected', style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                    ),
            if (_isEditingBankDetails)
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _bankNameController,
                      decoration: const InputDecoration(
                        labelText: 'Bank Name',
                        hintText: 'Enter your bank name',
                        prefixIcon: Icon(Icons.account_balance),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter bank name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _accountHolderNameController,
                      decoration: const InputDecoration(
                        labelText: 'Account Holder Name',
                        hintText: 'Enter account holder name',
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter account holder name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _accountNumberController,
                      decoration: const InputDecoration(
                        labelText: 'Account Number',
                        hintText: 'Enter account number',
                        prefixIcon: Icon(Icons.numbers),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter account number';
                        }
                        return null;
                      },
                    ),
                    if (_bankDetailsError != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(_bankDetailsError!, style: const TextStyle(color: Colors.red)),
                      ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _isSavingBankDetails
                                ? null
                                : () async {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        _isSavingBankDetails = true;
                                        _bankDetailsError = null;
                                      });
                                      try {
                                        final user = ref.read(authStateProvider).value;
                                        if (user != null) {
                                          final bankDetails = BankAccountDetails(
                                            bankName: _bankNameController.text,
                                            accountHolderName: _accountHolderNameController.text,
                                            accountNumber: _accountNumberController.text,
                                            isVerified: false,
                                          );
                                          await FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(user.uid)
                                              .update({'bankAccountDetails': bankDetails.toJson()});
                                          ref.invalidate(currentUserProvider);
                                          setState(() {
                                            _isEditingBankDetails = false;
                                          });
                                          if (context.mounted) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(content: Text('Bank details updated successfully')),
                                            );
                                          }
                                        }
                                      } catch (e) {
                                        setState(() {
                                          _bankDetailsError = 'Failed to update bank details.';
                                        });
                                      } finally {
                                        setState(() {
                                          _isSavingBankDetails = false;
                                        });
                                      }
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryGreen,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: _isSavingBankDetails
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    ),
                                  )
                                : const Text('Save'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: _isSavingBankDetails
                                ? null
                                : () {
                                    setState(() {
                                      _isEditingBankDetails = false;
                                      _bankDetailsError = null;
                                    });
                                  },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: AppTheme.primaryGreen),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('Cancel'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _bankDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Text('$label: ', style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w500)),
          Expanded(child: Text(value, style: const TextStyle(color: AppTheme.textDark))),
        ],
      ),
    );
  }

  Widget _buildSettingsCard(String title, String subtitle, IconData icon, {VoidCallback? onTap}) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: AppTheme.primaryGreen.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.primaryGreen.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppTheme.primaryGreen),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppTheme.textDark,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: AppTheme.textLight,
        ),
        onTap: onTap,
      ),
    );
  }

  Future<void> _showLogoutConfirmation(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await ref.read(authRepositoryProvider).signOut();
                if (context.mounted) {
                  context.go('/login');
                }
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}
