import 'package:flutter/material.dart';
import 'package:ms/data/model/user.dart';
import 'package:ms/view/account/account_screen.dart';
import 'package:ms/view/addon/addon_screen.dart';
import 'package:ms/view/budget/budget_screen.dart';
import 'package:ms/view/dashboard/dashboard_screen.dart';
import 'package:ms/view/transaction/transaction_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({required this.user, Key? key}) : super(key: key);
  final User user;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late User _user; // Biến để lưu trữ giá trị user

  @override
  void initState() {
    super.initState();
    _user = widget.user; // Lưu giá trị user vào _user khi initState được gọi
  }

  int selectedIndex = 0;
  late List<Widget> widgetOptions; // Chuyển sang sử dụng late để tránh lỗi

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Khởi tạo widgetOptions ở đây khi đã có giá trị của _user
    widgetOptions = [
      DashBoard(user: _user),
      Transaction(),
      Addon(),
      Budget(),
      Account()
    ];
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: widgetOptions.elementAt(selectedIndex),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Tổng quan',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet_outlined),
              label: 'Số giao dịch',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_circle_outlined), label: ""),
            BottomNavigationBarItem(
              icon: Icon(Icons.storage_rounded),
              label: 'Ngân sách',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Tài khoản',
            ),
          ],
          currentIndex: selectedIndex,
          selectedItemColor: const Color.fromRGBO(143, 148, 251, 1),
          onTap: onItemTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.black,
          unselectedItemColor: Colors.grey),
    );
  }
}
