import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ms/core/component/ms_color.dart';
import 'package:ms/core/component/ms_loading.dart';
import 'package:ms/core/component/ms_theme.dart';
import 'package:ms/core/utils/ms_utils.dart';
import 'package:ms/data/model/transaction_parent.dart';
import 'package:ms/data/model/transactions.dart';
import 'package:ms/data/model/user.dart';
import 'package:ms/view/account/account_screen.dart';
import 'package:ms/view/addon/addon_screen.dart';
import 'package:ms/view/budget/budget_screen.dart';
import 'package:ms/view/dashboard/dashboard_screen.dart';
import 'package:ms/view/home/cubit/home_cubit.dart';
import 'package:ms/view/transaction/transaction_screen.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({required this.user, Key? key}) : super(key: key);
  final User user;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late User _user;
  late TabController _tabController;
  late List<TransactionParent> transactionParent1 = [];
  late List<TransactionParent> transactionParent2 = [];
  int selectedIndex = 0;
  late List<Widget> widgetOptions;
  final pageIndexNotifier = ValueNotifier(0);
  late final TextEditingController _moneyController = TextEditingController();
  late final ValueNotifier<String> _group = ValueNotifier<String>("");
  late final ValueNotifier<String> _groupAvatar = ValueNotifier<String>("");
  late final ValueNotifier<String> _note = ValueNotifier<String>("");
  late final ValueNotifier<int> _date = ValueNotifier<int>(0);
  late int categoryId;
  late int transactionType;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    Get.find<HomeCubit>().searchTransactionParent(
        "userId==${widget.user.id};transactionType==1");
    Get.find<HomeCubit>().searchTransactionParent(
        "userId==${widget.user.id};transactionType==2");
    _user = widget.user;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widgetOptions = [
      DashBoard(user: _user),
      Transaction(),
      Addon(),
      BudgetScreen(
        user: _user,
      ),
      Account()
    ];
  }

  void onItemTapped(int index) {
    if (index == 2) {
      _showAddonBottomSheet(context);
    } else {
      setState(() {
        selectedIndex = index;
      });
    }
  }

  void _showAddonBottomSheet(BuildContext context) {
    WoltModalSheet.show<void>(
      pageIndexNotifier: pageIndexNotifier,
      context: context,
      pageListBuilder: (modalSheetContext) {
        final textTheme = Theme.of(context).textTheme;
        return [
          page1(modalSheetContext, textTheme),
          page2(modalSheetContext, textTheme),
          page3(modalSheetContext, textTheme),
        ];
      },
      modalTypeBuilder: (context) {
        return WoltModalType.bottomSheet;
      },
      onModalDismissedWithDrag: () {
        Navigator.of(context).pop();
        pageIndexNotifier.value = 0;
        _group.value = "";
        _note.value = "";
        _moneyController.text = "";
        _groupAvatar.value = "";
      },
      onModalDismissedWithBarrierTap: () {
        Navigator.of(context).pop();
        pageIndexNotifier.value = 0;
        _group.value = "";
        _note.value = "";
        _moneyController.text = "";
        _groupAvatar.value = "";
      },
      maxDialogWidth: 560,
      minDialogWidth: 400,
      minPageHeight: 0.0,
      maxPageHeight: 0.9,
    );
  }

  SliverWoltModalSheetPage page1(
      BuildContext modalSheetContext, TextTheme textTheme) {
    return WoltModalSheetPage(
      backgroundColor: const Color.fromARGB(255, 34, 32, 32),
      hasSabGradient: false,
      stickyActionBar: Padding(
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(135, 68, 63, 63)),
          onPressed: () async {
            if (isValidTransaction(_moneyController.text, _group.value,
                _note.value, _date.value.toString())) {
              Navigator.of(modalSheetContext).pop();
              Transactions transactions = Transactions();
              transactions.amount = int.parse(_moneyController.text);
              transactions.categoryId = categoryId;
              transactions.categoryName = _group.value;
              transactions.description = _note.value;
              transactions.transactionType = transactionType;
              transactions.icon = _groupAvatar.value;
              transactions.transactionDate =
                  DateTime.now().millisecondsSinceEpoch;
              await Get.find<HomeCubit>().createTransaction(transactions);
              _group.value = "";
              _note.value = "";
              _moneyController.text = "";
              _groupAvatar.value = "";
            }
          },
          child: SizedBox(
            height: 16,
            width: double.infinity,
            child: Center(
                child: Text('Lưu',
                    style: MsTheme.of(context)
                        .title1
                        .copyWith(color: MsColors.white))),
          ),
        ),
      ),
      topBarTitle: Text('Thêm giao dịch',
          style: MsTheme.of(context).title1.copyWith(color: MsColors.white)),
      isTopBarLayerAlwaysVisible: true,
      leadingNavBarWidget: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          textStyle: MsTheme.of(context).title2.copyWith(color: MsColors.white),
        ),
        onPressed: () {
          Navigator.of(modalSheetContext).pop();
          _group.value = "";
          _note.value = "";
          _moneyController.text = "";
          _groupAvatar.value = "";
        },
        child: const Text('Hủy'),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 120),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: Color.fromARGB(137, 141, 131, 131)),
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/vnd.png',
                              width: 25,
                              height: 25,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                                child: TextField(
                              style: MsTheme.of(context)
                                  .title1
                                  .copyWith(color: MsColors.white),
                              keyboardType: TextInputType.number,
                              controller: _moneyController,
                              decoration: InputDecoration(
                                hintStyle: const TextStyle(color: Colors.white),
                                hintText: 'Số tiền',
                                border: InputBorder.none,
                                suffixIcon: IconButton(
                                  onPressed: _moneyController.clear,
                                  icon: const Icon(Icons.clear,
                                      size: 20, color: Colors.grey),
                                ),
                              ),
                            ))
                          ],
                        )),
                    const Divider(
                      height: 10,
                    ),
                    MaterialButton(
                      onPressed: () async {
                        pageIndexNotifier.value = pageIndexNotifier.value + 1;
                      },
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ValueListenableBuilder<String>(
                            builder: (BuildContext context, String value,
                                Widget? child) {
                              return ClipOval(
                                child: Container(
                                  color: const Color.fromRGBO(143, 148, 251, 1),
                                  padding: const EdgeInsets.all(8),
                                  child: _groupAvatar.value.isEmpty
                                      ? Image.asset(
                                          'assets/images/dog.png',
                                          width: 25,
                                          height: 25,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(
                                          MsUtils.getPathIcons(
                                              _groupAvatar.value),
                                          width: 25,
                                          height: 25,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              );
                            },
                            valueListenable: _group,
                          ),
                          const SizedBox(width: 10),
                          ValueListenableBuilder<String>(
                            builder: (BuildContext context, String value,
                                Widget? child) {
                              return Text(value.isEmpty ? "Chọn nhóm" : value,
                                  style: MsTheme.of(context)
                                      .title1
                                      .copyWith(color: Colors.white));
                            },
                            valueListenable: _group,
                          ),
                          const Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 20,
                                color: Colors.grey,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const Divider(
                      height: 10,
                    ),
                    MaterialButton(
                        onPressed: () async {
                          pageIndexNotifier.value = 2;
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/images/pencil.png',
                              width: 25,
                              height: 25,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(width: 10),
                            ValueListenableBuilder<String>(
                              builder: (BuildContext context, String value,
                                  Widget? child) {
                                return Text(value.isEmpty ? "Ghi chú" : value,
                                    style: MsTheme.of(context)
                                        .title1
                                        .copyWith(color: Colors.white));
                              },
                              valueListenable: _note,
                            ),
                            const Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 20,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          ],
                        )),
                    const Divider(
                      height: 10,
                    ),
                    MaterialButton(
                        onPressed: () async {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/images/calendar.png',
                              width: 25,
                              height: 25,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(width: 10),
                            ValueListenableBuilder<int>(
                              builder: (BuildContext context, int value,
                                  Widget? child) {
                                return Text(formatDate(),
                                    style: MsTheme.of(context)
                                        .title1
                                        .copyWith(color: Colors.white));
                              },
                              valueListenable: _date,
                            ),
                            const Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 20,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          ],
                        )),
                    const Divider(
                      height: 10,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/salary.png',
                              width: 25,
                              height: 25,
                              fit: BoxFit.cover,
                            ),
                            TextButton(
                              onPressed: Navigator.of(modalSheetContext).pop,
                              child: Text(
                                'Tiền mặt',
                                style: MsTheme.of(context)
                                    .title1
                                    .copyWith(color: Colors.white),
                              ),
                            )
                          ],
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SliverWoltModalSheetPage page2(
      BuildContext modalSheetContext, TextTheme textTheme) {
    return SliverWoltModalSheetPage(
        isTopBarLayerAlwaysVisible: true,
        navBarHeight: 80,
        topBarTitle: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Center(
                    child: Text("Chọn nhóm",
                        style: MsTheme.of(context)
                            .title1
                            .copyWith(color: MsColors.black))),
                Container(
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                    color: Colors.grey[200],
                  ),
                  child: TabBar(
                    onTap: (index) {
                      if (index == 0) {
                        Get.find<HomeCubit>().searchTransactionParent(
                            "userId==${widget.user.id};transactionType==1");
                      } else {
                        Get.find<HomeCubit>().searchTransactionParent(
                            "userId==${widget.user.id};transactionType==2");
                      }
                    },
                    controller: _tabController,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    dividerHeight: 0,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                        color: MsColors.grey,
                        shape: BoxShape.rectangle),
                    tabs: const [
                      Tab(
                        text: 'Khoản chi',
                      ),
                      Tab(
                        text: 'Khoản thu',
                      )
                    ],
                  ),
                ),
              ],
            )),
        leadingNavBarWidget: IconButton(
          padding: const EdgeInsets.only(left: 16, right: 16),
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () =>
              pageIndexNotifier.value = pageIndexNotifier.value - 1,
        ),
        trailingNavBarWidget: IconButton(
          padding: const EdgeInsets.only(left: 16, right: 16),
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.of(modalSheetContext).pop();
            pageIndexNotifier.value = 0;
            _group.value = "";
          },
        ),
        hasSabGradient: false,
        mainContentSlivers: [
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: transactionParent1.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(height: 10, color: Colors.grey),
                          MaterialButton(
                            onPressed: () async {
                              _group.value = transactionParent1[index].name!;
                              _groupAvatar.value =
                                  transactionParent1[index].icon!;
                              pageIndexNotifier.value =
                                  pageIndexNotifier.value - 1;
                              categoryId = transactionParent1[index].id!;
                              transactionType =
                                  transactionParent1[index].transactionType!;
                            },
                            height: 50,
                            color: Colors.black12,
                            child: Row(
                              children: [
                                ClipOval(
                                  child: Container(
                                    color:
                                        const Color.fromRGBO(143, 148, 251, 1),
                                    padding: const EdgeInsets.all(8),
                                    child: Image.asset(
                                      MsUtils.getPathIcons(
                                          transactionParent1[index].icon!),
                                      width: 25,
                                      height: 25,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  transactionParent1[index].name ?? "MS",
                                  style: MsTheme.of(context)
                                      .title1
                                      .copyWith(color: MsColors.textWhite),
                                )
                              ],
                            ),
                          ),
                          transactionParent1[index].transactionCategoryChilds !=
                                  null
                              ? ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: transactionParent1[index]
                                      .transactionCategoryChilds
                                      ?.length,
                                  itemBuilder:
                                      (BuildContext context, int index1) {
                                    return Column(
                                      children: [
                                        const Divider(
                                            height: 10, color: Colors.grey),
                                        MaterialButton(
                                          onPressed: () async {
                                            _group.value =
                                                transactionParent1[index]
                                                    .transactionCategoryChilds![
                                                        index1]
                                                    .name!;
                                            _groupAvatar.value =
                                                transactionParent1[index]
                                                    .transactionCategoryChilds![
                                                        index1]
                                                    .icon!;
                                            pageIndexNotifier.value =
                                                pageIndexNotifier.value - 1;
                                            categoryId =
                                                transactionParent1[index].id!;
                                            transactionType =
                                                transactionParent1[index]
                                                    .transactionType!;
                                          },
                                          height: 50,
                                          color: Colors.black12,
                                          child: Row(
                                            children: [
                                              const SizedBox(width: 30),
                                              ClipOval(
                                                child: Container(
                                                  color: const Color.fromARGB(
                                                      255, 19, 204, 43),
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: Image.asset(
                                                    MsUtils.getPathIcons(
                                                        transactionParent1[
                                                                index]
                                                            .transactionCategoryChilds![
                                                                index1]
                                                            .icon!),
                                                    width: 25,
                                                    height: 25,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                transactionParent1[index]
                                                        .transactionCategoryChilds?[
                                                            index1]
                                                        .name ??
                                                    "MS",
                                                style: MsTheme.of(context)
                                                    .title1
                                                    .copyWith(
                                                        color:
                                                            MsColors.textWhite),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                )
                              : Container(),
                        ],
                      );
                    }),
                ListView.builder(
                    itemCount: transactionParent2.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          const Divider(height: 10, color: Colors.grey),
                          MaterialButton(
                            onPressed: () async {
                              _group.value = transactionParent2[index].name!;
                              _groupAvatar.value =
                                  transactionParent2[index].icon!;
                              pageIndexNotifier.value =
                                  pageIndexNotifier.value - 1;
                              categoryId = transactionParent2[index].id!;
                              transactionType =
                                  transactionParent2[index].transactionType!;
                            },
                            height: 50,
                            color: Colors.black12,
                            child: Row(
                              children: [
                                ClipOval(
                                  child: Container(
                                    color:
                                        const Color.fromRGBO(143, 148, 251, 1),
                                    padding: const EdgeInsets.all(8),
                                    child: Image.asset(
                                      MsUtils.getPathIcons(
                                          transactionParent2[index].icon!),
                                      width: 25,
                                      height: 25,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  transactionParent2[index].name ?? "MS",
                                  style: MsTheme.of(context)
                                      .title1
                                      .copyWith(color: MsColors.textWhite),
                                )
                              ],
                            ),
                          ),
                          transactionParent2[index].transactionCategoryChilds !=
                                  null
                              ? ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: transactionParent2[index]
                                      .transactionCategoryChilds
                                      ?.length,
                                  itemBuilder:
                                      (BuildContext context, int index1) {
                                    return Column(
                                      children: [
                                        const Divider(
                                            height: 10, color: Colors.grey),
                                        MaterialButton(
                                          onPressed: () async {
                                            _group.value =
                                                transactionParent2[index]
                                                    .transactionCategoryChilds![
                                                        index1]
                                                    .name!;
                                            _groupAvatar.value =
                                                transactionParent2[index]
                                                    .transactionCategoryChilds![
                                                        index1]
                                                    .icon!;
                                            pageIndexNotifier.value =
                                                pageIndexNotifier.value - 1;
                                            categoryId =
                                                transactionParent2[index].id!;
                                            transactionType =
                                                transactionParent2[index]
                                                    .transactionType!;
                                          },
                                          height: 50,
                                          color: Colors.black12,
                                          child: Row(
                                            children: [
                                              const SizedBox(width: 30),
                                              ClipOval(
                                                child: Container(
                                                  color: const Color.fromARGB(
                                                      255, 19, 204, 43),
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: Image.asset(
                                                    MsUtils.getPathIcons(
                                                        transactionParent2[
                                                                index]
                                                            .transactionCategoryChilds![
                                                                index1]
                                                            .icon!),
                                                    width: 25,
                                                    height: 25,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                transactionParent2[index]
                                                        .transactionCategoryChilds?[
                                                            index1]
                                                        .name ??
                                                    "MS",
                                                style: MsTheme.of(context)
                                                    .title1
                                                    .copyWith(
                                                        color:
                                                            MsColors.textWhite),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                )
                              : Container(),
                        ],
                      );
                    }),
              ],
            ),
          ),
        ]);
  }

  SliverWoltModalSheetPage page3(
      BuildContext modalSheetContext, TextTheme textTheme) {
    return SliverWoltModalSheetPage(
        isTopBarLayerAlwaysVisible: true,
        topBarTitle: Center(
            child: Text("Ghi chú",
                style: MsTheme.of(context)
                    .title1
                    .copyWith(color: MsColors.black))),
        leadingNavBarWidget: IconButton(
          padding: const EdgeInsets.only(left: 16, right: 16),
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            pageIndexNotifier.value = 0;
            _note.value = "";
          },
        ),
        trailingNavBarWidget: IconButton(
          padding: const EdgeInsets.only(left: 16, right: 16),
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.of(modalSheetContext).pop();
            pageIndexNotifier.value = 0;
            _note.value = "";
          },
        ),
        hasSabGradient: false,
        mainContentSlivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            sliver: SliverToBoxAdapter(
              child: TextField(
                keyboardType: TextInputType.text,
                minLines: 10,
                maxLines: null,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: "Nhập ghi chú"),
                onSubmitted: (value) {
                  _note.value = value;
                  pageIndexNotifier.value = 0;
                },
              ),
            ),
          ),
        ]);
  }

  formatDate() {
    var dateTime = DateTime.now();
    var formattedDate =
        DateFormat('EEEE, dd MMMM yyyy', 'vi_VN').format(dateTime);
    return formattedDate;
  }

  bool isValidTransaction(
      String money, String group, String note, String date) {
    if (money.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Số tiền không được bỏ trống'),
          action: SnackBarAction(
            label: 'Đóng',
            onPressed: () {
              // Code to execute.
            },
          ),
        ),
      );
      return false;
    }
    if (group.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Nhóm không được bỏ trống'),
          action: SnackBarAction(
            label: 'Đóng',
            onPressed: () {
              // Code to execute.
            },
          ),
        ),
      );
      return false;
    }
    if (note.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Chú thích không được bỏ trống'),
          action: SnackBarAction(
            label: 'Đóng',
            onPressed: () {
              // Code to execute.
            },
          ),
        ),
      );
      return false;
    }
    if (date.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Ngày tháng không được bỏ trống'),
          action: SnackBarAction(
            label: 'Đóng',
            onPressed: () {
              // Code to execute.
            },
          ),
        ),
      );
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: widgetOptions.elementAt(selectedIndex),
          ),
          _buildListener()
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

  Widget _buildListener() {
    return BlocListener(
      bloc: Get.find<HomeCubit>(),
      listener: (context, state) async {
        if (state is SearchTransactionParentLoading) {
          MSLoading.show();
          return;
        }
        MSLoading.dismiss();

        if (state is SearchTransactionParentSuccess) {
          if (state.response[0].transactionType == 1) {
            transactionParent1 = state.response;
          } else {
            transactionParent2 = state.response;
          }
          return;
        }

        if (state is CreateTransactionSuccess) {
          Get.find<HomeCubit>().getCurrentUser();
          return;
        }

        if (state is AccountSuccess) {
          setState(() {
            _user = state.response;
            widgetOptions = [
              DashBoard(user: _user),
              Transaction(),
              Addon(),
              BudgetScreen(
                user: _user,
              ),
              Account()
            ];
          });
          return;
        }
      },
      child: Container(),
    );
  }
}
