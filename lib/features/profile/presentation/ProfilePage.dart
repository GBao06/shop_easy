import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Widget thongKe(String so, String nhan) {
    return Column(
      children: [
        Text(
          so,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(nhan, textAlign: TextAlign.center),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.settings),
              label: const Text('Quay về Cài đặt'),
            ),
          ),
          Center(
            child: Card(
              margin: const EdgeInsets.all(20),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              clipBehavior: Clip.antiAlias,
              child: SizedBox(
                width: 500,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        //anh bia
                        Container(
                          color: Colors.blue.shade200,
                          height: 200,
                          width: double.infinity,
                        ),
                        //anh dai dien
                        Positioned(
                          bottom: -40,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage(
                                'assets/images/IMG_1118.JPG',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 55),
                    const Text(
                      'Dương Gia Bảo',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Lập trình ứng dụng di động',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          thongKe('120', 'Bài viết'),
                          thongKe('850', 'Người theo dõi'),
                          thongKe('45', 'Đang theo dõi'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Divider(height: 1),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text('Theo dõi'),
                            ),
                          ),

                          const SizedBox(width: 10),

                          Expanded(
                            flex: 2,
                            child: OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                // foregroundColor: Colors.black87,
                                // side: BorderSide(color: Colors.grey.shade400),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text('Nhắn tin'),
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
        ],
      ),
    );
  }
}
