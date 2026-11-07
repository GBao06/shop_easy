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
}
