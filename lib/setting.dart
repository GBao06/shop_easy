import 'package:flutter/material.dart';
import 'package:shop_easy/dashboard/DashboardScreen.dart';

import 'ProfilePage.dart';
import 'theme_controller.dart';
import 'login.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool nhanThongBao = true;
  bool dongBo = true;

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

  Widget settingItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget profileItem() {
    return ListTile(
      leading: const CircleAvatar(
        radius: 25,
        backgroundImage: AssetImage('assets/images/IMG_1118.JPG'),
      ),
      title: const Text(
        'Dương Gia Bảo',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      subtitle: const Text('Xem hồ sơ cá nhân'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfilePage()),
        );
      },
    );
  }

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
                  const Text(
                    'Cài đặt',
                    style: TextStyle(
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
                children: [
                  profileItem(),
                  const Divider(height: 1),
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Tài khoản',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  switchItem(
                    Icons.notifications_outlined,
                    'Nhận thông báo',
                    nhanThongBao,
                    (value) {
                      setState(() {
                        nhanThongBao = value;
                      });
                    },
                  ),
                  const Divider(height: 1),
                  ValueListenableBuilder<bool>(
                    valueListenable: isDarkModeNotifier,
                    builder: (context, isDark, child) {
                      return switchItem(
                        Icons.dark_mode_outlined,
                        'Chế độ tối',
                        isDark,
                        (value) {
                          isDarkModeNotifier.value = value;
                        },
                      );
                    },
                  ),
                  const Divider(height: 1),
                  switchItem(Icons.sync, 'Nhớ đăng nhập', dongBo, (value) {
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
                      leading: const Icon(
                        Icons.bar_chart_rounded,

                        size: 28,
                      ),
                      title: const Text(
                        'Thống kê & Tổng quan',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
  
                        ),
                      ),
                      subtitle: const Text(
                        'Doanh thu, số lượng đơn hàng & báo cáo',
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,

                      ),
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
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'CÀI ĐẶT TÀI KHOẢN',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  settingItem(Icons.language, 'Ngôn ngữ', () {
                    print('Chọn ngôn ngữ');
                  }),
                  const Divider(height: 1),
                  settingItem(Icons.text_fields, 'Cỡ chữ', () {
                    print('Chọn cỡ chữ');
                  }),
                  const Divider(height: 1),
                  settingItem(Icons.info_outline, 'Về ứng dụng', () {
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
