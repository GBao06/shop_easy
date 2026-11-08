import 'package:flutter/material.dart';
import 'package:shop_easy/l10n/app_strings.dart';

// Model mô tả đơn hàng mẫu
class OrderItem {
  final String orderCode;
  final String customerName;
  final String amount;
  final String date;
  final String status;
  final Color statusColor;

  OrderItem({
    required this.orderCode,
    required this.customerName,
    required this.amount,
    required this.date,
    required this.status,
    required this.statusColor,
  });
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  // Dữ liệu mẫu đơn hàng gần đây với các nhãn trạng thái khác nhau
  List<OrderItem> _getSampleOrders() {
    return [
      OrderItem(
        orderCode: 'ĐH #1024',
        customerName: 'Nguyễn Văn A',
        amount: '2.990.000 đ',
        date: '26/10/2026',
        status: 'Hoàn thành',
        statusColor: Colors.green,
      ),
      OrderItem(
        orderCode: 'ĐH #1023',
        customerName: 'Trần Thị B',
        amount: '450.000 đ',
        date: '26/10/2026',
        status: 'Đang giao',
        statusColor: Colors.orange,
      ),
      OrderItem(
        orderCode: 'ĐH #1022',
        customerName: 'Lê Văn C',
        amount: '3.950.000 đ',
        date: '25/10/2026',
        status: 'Chờ xử lý',
        statusColor: Colors.blue,
      ),
      OrderItem(
        orderCode: 'ĐH #1021',
        customerName: 'Phạm Minh D',
        amount: '890.000 đ',
        date: '24/10/2026',
        status: 'Đã hủy',
        statusColor: Colors.red,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final AppStrings s = AppStrings.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(s.dashboard), elevation: 0),
      // 2. Dùng LayoutBuilder để tự động đáp ứng responsive
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Kiểm tra độ rộng màn hình: > 600dp thì 4 cột, ngược lại 2 cột
          final bool isWideScreen = constraints.maxWidth > 600;
          final int crossAxisCount = isWideScreen ? 4 : 2;

          // 5. Toàn màn hình cuộn bằng CustomScrollView
          return CustomScrollView(
            slivers: [
              // 1 & 2. Lưới 4 ô số liệu (SliverGrid)
              SliverPadding(
                padding: const EdgeInsets.all(12.0),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: isWideScreen ? 1.4 : 1.25,
                  ),
                  delegate: SliverChildListDelegate([
                    _buildStatCard(
                      icon: Icons.shopping_bag_outlined,
                      iconColor: Colors.blue,
                      value: '128',
                      label: s.orders,
                    ),
                    _buildStatCard(
                      icon: Icons.attach_money,
                      iconColor: Colors.green,
                      value: '45.8M',
                      label: s.ren,
                    ),
                    _buildStatCard(
                      icon: Icons.people_outline,
                      iconColor: Colors.orange,
                      value: '1,240',
                      label: s.customer,
                    ),
                    _buildStatCard(
                      icon: Icons.inventory_2_outlined,
                      iconColor: Colors.purple,
                      value: '86',
                      label: s.products,
                    ),
                  ]),
                ),
              ),

              // 3. Tiêu đề mục "Đơn hàng gần đây" có nút "Xem tất cả" căn phải
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 4.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text(
                        s.recent,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child:  Text(s.viewall),
                      ),
                    ],
                  ),
                ),
              ),

              // 4. Danh sách đơn hàng gần đây (SliverList)
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final orders = _getSampleOrders();
                    final order = orders[index];

                    return Card(
                      margin: const EdgeInsets.only(bottom: 8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 4.0,
                        ),
                        leading: CircleAvatar(
                          backgroundColor: Colors.indigo.shade50,
                          child: const Icon(
                            Icons.receipt_long,
                            color: Color(0xFF203D67),
                          ),
                        ),
                        title: Text(
                          order.orderCode,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text('${order.customerName} • ${order.date}'),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              order.amount,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            // Nhãn trạng thái với màu nền và màu chữ khác nhau
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: order.statusColor.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                order.status,
                                style: TextStyle(
                                  color: order.statusColor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }, childCount: _getSampleOrders().length),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // 1. Widget Ô số liệu tổng quan (Card + Icon tròn + Con số + Nhãn)
  Widget _buildStatCard({
    required IconData icon,
    required Color iconColor,
    required String value,
    required String label,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon tròn
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 22),
            ),
            const Spacer(),
            // Con số lớn
            Text(
              value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 2),
            // Nhãn chữ nhỏ
            Text(
              label,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}
