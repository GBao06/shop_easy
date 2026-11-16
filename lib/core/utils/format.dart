String formatPrice(double amount) {
  final digits = amount.toStringAsFixed(0);
  final withDots =
      digits.replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (_) => '.');
  return '$withDots đ';
}