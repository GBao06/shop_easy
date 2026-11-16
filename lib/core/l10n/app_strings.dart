import 'package:flutter/material.dart';

class AppStrings {
  final String _code;
  const AppStrings._(this._code);

  /// Gọi trong build: AppStrings.of(context)
  static AppStrings of(BuildContext context) =>
      AppStrings._(Localizations.localeOf(context).languageCode);

  static const _vi = {
    'All': 'Tất cả',
    'profile': 'Xem hồ sơ cá nhân',
    'settings': 'Cài đặt',
    'account': 'Tài khoản',
    'notifications': 'Nhận thông báo',
    'darkMode': 'Chế độ tối',
    'language': 'Ngôn ngữ',
    'fontSize': 'Cỡ chữ',
    'logout': 'Đăng xuất',
    'cancel': 'Hủy',
    'searchHint': 'Tìm sản phẩm...',
    'rememberLogin': 'Nhớ đăng nhập',
    'about_app': 'Về ứng dụng',
    'account_settings': 'Cài đặt tài khoản',
    'dashboard': 'Thống kê & Tổng quan',
    'Revenue, number of orders & report':
        'Doanh thu, số lượng đơn hàng & báo cáo',
    'aboutDescription': 'Ứng dụng mua sắm đồ cầu lông: vợt, áo, quần, giày.',
    'noProductsFound':
        'Không tìm thấy sản phẩm nào phù hợp với từ khóa tìm kiếm.',
    'home': 'Trang chủ',
    'category': 'Danh mục',
    'setting': 'Cài đặt',
    'buy': 'Mua',
    'addToCart': 'Thêm vào giỏ ',
    'productDetails': 'Chi tiết sản phẩm',
    'productDescription': 'Mô tả sản phẩm:',
    'undo': 'HOÀN TÁC',
    'isempty': 'Giỏ hàng của bạn đang trống',
    'isempty2': 'Hãy chọn thêm sản phẩm để tiếp tục mua sắm nhé!',
    'Continue shopping': 'Tiếp tục mua sắm',
    'subtotal': 'Tạm tính:',
    'shipping': 'Phí vận chuyển',
    'free': 'Miễn phí',
    'total': 'Tổng cộng',
    'checkout': 'Thanh toán',
    'cart': 'Giỏ hàng của bạn',
    'Easy Shopping': 'Mua sắm dễ dàng',
    'logOutConfirmation': 'Bạn có chắc chắn muốn đăng xuất không?',
    'order': 'Đơn hàng',
    'revenue': 'Doanh thu',
    'customers': 'Khách hàng',
    'products': 'Sản phẩm',
    'recentorders': 'Đơn hàng gần đây',
    'viewall': 'Xem tất cả',
    'opencart': 'Xem giỏ',

    'deleted': 'Đã xóa ',
  };

  static const _en = {
    'All': 'All',
    'profile': 'View profile',
    'settings': 'Settings',
    'account': 'Account',
    'notifications': 'Notifications',
    'darkMode': 'Dark mode',
    'language': 'Language',
    'fontSize': 'Font size',
    'logout': 'Log out',
    'cancel': 'Cancel',
    'searchHint': 'Search products...',
    'rememberLogin': 'Remember login',
    'about_app': 'About app',
    'account_settings': 'Account settings',
    'dashboard': 'Dashboard',
    'Revenue, number of orders & report': 'Revenue, number of orders & report',
    'aboutDescription':
        'A shopping app for badminton gear: rackets, shirts, shorts, shoes.',
    'noProductsFound': 'No products found matching your search criteria.',
    'home': 'Home',
    'category': 'Category',
    'setting': 'Setting',
    'buy': 'Buy',
    'addToCart': 'Add to cart',
    'productDetails': 'Product Details',
    'productDescription': 'Product Description:',
    'undo': 'UNDO',
    'isempty': 'Your shopping cart is empty',
    'isempty2': 'Please pick more items to keep shopping!',
    'Continue shopping': 'Continue shopping',
    'subtotal': 'Subtotal:',
    'shipping': 'Shipping Fee',
    'free': 'Free',
    'total': 'Total',
    'checkout': 'Checkout',
    'cart': 'Cart Items',
    'Easy Shopping': 'Easy Shopping',
    'logOutConfirmation': 'Are you sure you want to log out?',
    'order': 'Order',
    'revenue': 'Revenue',
    'customers': 'Customers',
    'products': 'Products',
    'recentorders': 'Recent Orders',
    'viewall': 'View all',
    'opencart': 'Open Cart',

    'deleted': 'Deleted',
  };

  String _t(String key) => (_code == 'en' ? _en : _vi)[key] ?? key;
  String get all => _t('All');
  String get settings => _t('settings');
  String get account => _t('account');
  String get notifications => _t('notifications');
  String get darkMode => _t('darkMode');
  String get language => _t('language');
  String get fontSize => _t('fontSize');
  String get logout => _t('logout');
  String get cancel => _t('cancel');
  String get searchHint => _t('searchHint');

  String get rememberLogin => _t('rememberLogin');
  String get profile => _t('profile');
  String get aboutapp => _t('about_app');
  String get accountsettings => _t('account_settings');
  String get dashboard => _t('dashboard');
  String get revenueNumberOfOrdersReport =>
      _t('Revenue, number of orders & report');
  String get about => _t('about_app');
  String get aboutDescription => _t('aboutDescription');
  String get noProductsFound => _t('noProductsFound');
  String get home => _t('home');
  String get category => _t('category');
  String get setting => _t('setting');
  String get buy => _t('buy');
  String get addToCart => _t('addToCart');
  String get productDetails => _t('productDetails');
  String get productDescription => _t('productDescription');
  String get undo => _t('undo');
  String get isempty => _t('isempty');
  String get isempty2 => _t('isempty2');
  String get continueShopping => _t('Continue shopping');
  String get subtotal => _t('subtotal');
  String get shipping => _t('shipping');
  String get free => _t('free');
  String get total => _t('total');
  String get checkout => _t('checkout');
  String get cart => _t('cart');
  String get easyShopping => _t('Easy Shopping');
  String get logOutConfirmation => _t('logOutConfirmation');
  String get orders => _t('order');
  String get ren => _t('revenue');
  String get customer => _t('customers');
  String get products => _t('products');
  String get recent => _t('recentorders');
  String get viewall => _t('viewall');
  String get opencart => _t('opencart');

  String get del => _t('deleted');
  String removedItem(String name) =>
      _code == 'en' ? 'Removed "$name"' : 'Đã xóa "$name"';
  String addProduct(String name) => _code == 'en' ? 'Added "$name" to your cart!' : 'Đã thêm "$name" vào giỏ hàng của bạn! '; 
}
