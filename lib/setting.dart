import 'package:flutter/material.dart';
import 'package:shop_easy/dashboard/DashboardScreen.dart';
import 'package:shop_easy/widgets/font_size_dialog.dart';
import 'package:shop_easy/l10n/app_strings.dart';
import 'package:shop_easy/widgets/language_dialog.dart';

import 'ProfilePage.dart';
import 'theme/theme_controller.dart';
import 'login.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool nhanThongBao = true;
  bool dongBo = true;

  // Widget để tạo một mục cài đặt với Switch
  Widget switchItem(
    IconData icon,
    String title,
    bool value,
    Function(bool) onChanged,
  ) {
    return SwitchListTile(
      secondary: Icon(icon),
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }

  // Widget để tạo một mục cài đặt thông thường
  Widget settingItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  // Widget để hiển thị thông tin hồ sơ người dùng
  Widget profileItem() {
    final s = AppStrings.of(context);
    return ListTile(
      leading: const CircleAvatar(
        radius: 25,
        backgroundImage: AssetImage('assets/images/IMG_1118.JPG'),
      ),
      title: const Text(
        'Dương Gia Bảo',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      subtitle: Text(s.profile),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfilePage()),
        );
      },
    );
  }

  // Widget để tạo nút đăng xuất
  Widget logoutButton() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton.icon(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Đăng xuất'),
                  content: const Text('Bạn có chắc chắn muốn đăng xuất không?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Hủy'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                          (route) => false,
                        );
                      },
                      child: const Text(
                        'Đăng xuất',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          icon: const Icon(Icons.logout),
          label: const Text(
            'Đăng xuất',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red.shade50,
            foregroundColor: Colors.red,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // ================= TIÊU ĐỀ CÓ NÚT QUAY LẠI =================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              color: const Color(0xFF203D67),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context); // Quay lại màn hình trước
                    },
                  ),
                  const SizedBox(width: 8),
                  Text(
                    s.settings,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // =========================================================

            Expanded(
              child: ListView(
                // Các mục cài đặt
                children: [
                  profileItem(),
                  const Divider(height: 1),
                  // Phần cài đặt thông báo, chế độ tối và đồng bộ
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        s.account,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // Các mục cài đặt với Switch
                  switchItem(
                    Icons.notifications_outlined,
                    s.notifications,
                    nhanThongBao,
                    (value) {
                      setState(() {
                        nhanThongBao = value;
                      });
                    },
                  ),
                  const Divider(height: 1),
                  // Sử dụng ValueListenableBuilder để lắng nghe thay đổi của isDarkModeNotifier
                  ValueListenableBuilder<bool>(
                    valueListenable: isDarkModeNotifier,
                    builder: (context, isDark, child) {
                      return switchItem(
                        Icons.dark_mode_outlined,
                        s.darkMode,
                        isDark,
                        (value) {
                          isDarkModeNotifier.value = value;
                        },
                      );
                    },
                  ),
                  const Divider(height: 1),
                  // Mục cài đặt khác
                  switchItem(Icons.sync, s.rememberLogin, dongBo, (value) {
                    setState(() {
                      dongBo = value;
                    });
                  }),
                  // thong ke tong quan
                  Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.bar_chart_rounded, size: 28),
                      title: Text(
                        s.dashboard,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle:Text(
                       s.revenueNumberOfOrdersReport,
                        style: TextStyle(fontSize: 12),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        // 🛠 3. Chuyển sang màn hình DashboardScreen khi bấm vào
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DashboardScreen(),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 16),
                  const Divider(height: 1),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        s.accountsettings,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // Các mục cài đặt khác
                  settingItem(
                    Icons.language,
                    s.language,
                    () => showLanguageDialog(context),
                  ),
                  const Divider(height: 1),
                  settingItem(
                    Icons.text_fields,
                    s.fontSize,
                    () => showFontSizeDialog(context),
                  ),
                  const Divider(height: 1),
                  settingItem(Icons.info_outline, s.aboutapp, () {
                    print('Thông tin ứng dụng');
                  }),
                  const Divider(height: 1),
                  logoutButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
