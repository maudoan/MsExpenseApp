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
import 'package:intl/date_symbol_data_local.dart';
import 'package:ms/view/dashboard/cubit/dashboard_cubit.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key, required this.user}) : super(key: key);

  final User user;
  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late TabController _tabController;
  bool isHidden = false;
  final pageIndexNotifier = ValueNotifier(0);
  late final TextEditingController _moneyController = TextEditingController();
  late final ValueNotifier<String> _group = ValueNotifier<String>("");
  late final ValueNotifier<String> _groupAvatar = ValueNotifier<String>("");
  late final ValueNotifier<String> _money = ValueNotifier<String>("");
  late final ValueNotifier<String> _note = ValueNotifier<String>("");
  late int categoryId;
  late int transactionType;
  final DateTime _date = DateTime.now();
  late final ValueNotifier<DateTime> _dateTime = ValueNotifier<DateTime>(_date);
  late User _user;
  late List<TransactionParent> transactionParent1 = [];
  late List<TransactionParent> transactionParent2 = [];
  @override
  void initState() {
    _user = widget.user;
    Get.put(DashBoardCubit(Get.find()));
    Get.find<DashBoardCubit>().getCurrentUser();
    Get.find<DashBoardCubit>().searchTransactionParent(
        "userId==${widget.user.id};transactionType==1");
    Get.find<DashBoardCubit>().searchTransactionParent(
        "userId==${widget.user.id};transactionType==2");
    initializeDateFormatting();
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 77, 75, 75),
      body: Stack(
        children: [
          Scrollbar(
              child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              slivers: <Widget>[
                _buildHeader(),
                SliverToBoxAdapter(
                  child: _buildWallet(),
                ),
                SliverToBoxAdapter(
                  child: _buildExpenseReport(),
                ),
                SliverToBoxAdapter(
                  child: _buildHistoryExpense(),
                )
              ],
            ),
          )),
          _buildListener()
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                convertBalance(isHidden, _user.totalBalance!),
                style: MsTheme.of(context)
                    .title1
                    .copyWith(color: MsColors.textWhite),
              ),
              IconButton(
                icon: Icon(
                    isHidden == true ? Icons.visibility_off : Icons.visibility,
                    size: 15,
                    color: MsColors.greyBackGround),
                onPressed: () {
                  setState(() {
                    isHidden = !isHidden;
                  });
                },
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildWallet() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Tổng số dư",
              style: MsTheme.of(context)
                  .caption1
                  .copyWith(color: MsColors.textWhite),
            ),
            const SizedBox(width: 10),
            const Tooltip(
              message: 'Được tính dựa trên số dư của các ví nằm trong tổng',
              triggerMode: TooltipTriggerMode.tap,
              preferBelow: false,
              child: Icon(Icons.help, size: 15, color: MsColors.grey),
            )
          ],
        ),
        const SizedBox(height: 10),
        Card(
            color: const Color.fromARGB(137, 141, 131, 131),
            child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: SizedBox(
                  height: 100,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Ví của tôi",
                              style: MsTheme.of(context)
                                  .title1
                                  .copyWith(color: MsColors.textWhite),
                            ),
                            Text(
                              "Xem tất cả",
                              style: MsTheme.of(context).title1.copyWith(
                                  color:
                                      const Color.fromRGBO(143, 148, 251, 1)),
                            )
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Tiền mặt",
                              style: MsTheme.of(context)
                                  .title1
                                  .copyWith(color: MsColors.textWhite),
                            ),
                            Text(
                              convertBalance(true, _user.totalBalance!),
                              style: MsTheme.of(context)
                                  .title1
                                  .copyWith(color: MsColors.textWhite),
                            )
                          ],
                        ),
                      ]),
                ))),
        const SizedBox(height: 10)
      ],
    );
  }

  Widget _buildExpenseReport() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Báo cáo chi tiêu",
              style: MsTheme.of(context)
                  .caption1
                  .copyWith(color: MsColors.textWhite),
            ),
            Text(
              "Xem báo cáo",
              style: MsTheme.of(context)
                  .title1
                  .copyWith(color: const Color.fromRGBO(143, 148, 251, 1)),
            )
          ],
        ),
        const SizedBox(height: 10),
        Card(
            color: const Color.fromARGB(137, 141, 131, 131),
            child: SizedBox(
              height: 400,
              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                          color: Colors.grey[200],
                        ),
                        child: TabBar(
                          controller: _tabController,
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.black,
                          indicatorSize: TabBarIndicatorSize.tab,
                          dividerHeight: 0,
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                            color: MsColors.grey,
                          ),
                          tabs: const [
                            Tab(
                              text: 'Tuần',
                            ),
                            Tab(
                              text: 'Tháng',
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: const [
                            Center(
                              child: Text(
                                'My Sunshine',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                'My Sunshine',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            )),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildHistoryExpense() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Giao dịch gần đây",
              style: MsTheme.of(context)
                  .caption1
                  .copyWith(color: MsColors.textWhite),
            ),
            Text(
              "Xem tất cả",
              style: MsTheme.of(context)
                  .title1
                  .copyWith(color: const Color.fromRGBO(143, 148, 251, 1)),
            )
          ],
        ),
        const SizedBox(height: 10),
        Card(
            color: const Color.fromARGB(137, 141, 131, 131),
            child: SizedBox(
                height: 400,
                child: ListView.builder(
                    itemCount: _user.transactions!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return MaterialButton(
                          onPressed: () {
                            _showTransactionsBottomSheet(
                                context, _user.transactions![index]);
                          },
                          child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ClipOval(
                                    child: Container(
                                      color: const Color.fromRGBO(
                                          143, 148, 251, 1),
                                      padding: const EdgeInsets.all(8),
                                      child: Image.asset(
                                        MsUtils.getPathIcons(widget
                                            .user.transactions![index].icon),
                                        width: 25,
                                        height: 25,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Column(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${_user.transactions![index].categoryName}",
                                            style: MsTheme.of(context)
                                                .title1
                                                .copyWith(
                                                    color: MsColors.textWhite),
                                          ),
                                          Text(
                                            formatDate(_user
                                                .transactions![index].created),
                                            style: MsTheme.of(context)
                                                .caption1
                                                .copyWith(
                                                    color: MsColors.textWhite),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Expanded(child: Container()),
                                  Text(
                                    convertBalance(
                                        true,
                                        widget
                                            .user.transactions![index].amount),
                                    style: MsTheme.of(context)
                                        .caption1
                                        .copyWith(color: MsColors.textWhite),
                                  ),
                                ],
                              )));
                    })))
      ],
    );
  }

  void _showTransactionsBottomSheet(
      BuildContext context, Transactions transactions) {
    WoltModalSheet.show<void>(
      pageIndexNotifier: pageIndexNotifier,
      context: context,
      pageListBuilder: (modalSheetContext) {
        final textTheme = Theme.of(context).textTheme;
        return [
          page1(modalSheetContext, textTheme, transactions),
          page2(modalSheetContext, textTheme, transactions),
          page3(modalSheetContext, textTheme),
          page4(modalSheetContext, textTheme),
        ];
      },
      modalTypeBuilder: (context) {
        return WoltModalType.bottomSheet;
      },
      onModalDismissedWithDrag: () {
        Navigator.of(context).pop();
        pageIndexNotifier.value = 0;
      },
      onModalDismissedWithBarrierTap: () {
        Navigator.of(context).pop();
        pageIndexNotifier.value = 0;
      },
      maxDialogWidth: 560,
      minDialogWidth: 400,
      minPageHeight: 0.0,
      maxPageHeight: 0.9,
    );
  }

  SliverWoltModalSheetPage page1(BuildContext modalSheetContext,
      TextTheme textTheme, Transactions transactions) {
    return WoltModalSheetPage(
      backgroundColor: const Color.fromARGB(255, 34, 32, 32),
      hasSabGradient: false,
      isTopBarLayerAlwaysVisible: true,
      leadingNavBarWidget: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          textStyle: MsTheme.of(context).title2.copyWith(color: Colors.white),
        ),
        onPressed: () {
          Navigator.of(modalSheetContext).pop();
        },
        child: const Text('Đóng'),
      ),
      trailingNavBarWidget: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          textStyle: MsTheme.of(context).title2.copyWith(color: Colors.white),
        ),
        onPressed: () {
          pageIndexNotifier.value = 1;
          _moneyController.text = transactions.amount.toString();
          _group.value = transactions.categoryName ?? "";
          _groupAvatar.value = transactions.icon ?? "";
          _note.value = transactions.description ?? "";
          _dateTime.value = DateTime.fromMillisecondsSinceEpoch(
              transactions.transactionDate!);
        },
        child: const Text('Sửa'),
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            decoration:
                const BoxDecoration(color: Color.fromARGB(135, 68, 63, 63)),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
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
                                      MsUtils.getPathIcons(transactions.icon),
                                      width: 25,
                                      height: 25,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      MsUtils.getPathIcons(_groupAvatar.value),
                                      width: 25,
                                      height: 25,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          );
                        },
                        valueListenable: _group,
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ValueListenableBuilder<String>(
                            builder: (BuildContext context, String value,
                                Widget? child) {
                              return Text(
                                  value.isEmpty
                                      ? transactions.categoryName!
                                      : value,
                                  style: MsTheme.of(context)
                                      .title1
                                      .copyWith(color: Colors.white));
                            },
                            valueListenable: _group,
                          ),
                          const SizedBox(height: 10),
                          ValueListenableBuilder<String>(
                            builder: (BuildContext context, String value,
                                Widget? child) {
                              return Text(
                                  value.isEmpty
                                      ? convertBalance(
                                          true, transactions.amount)
                                      : convertBalance(true, int.parse(value)),
                                  style: MsTheme.of(context)
                                      .title2
                                      .copyWith(color: Colors.red));
                            },
                            valueListenable: _money,
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/calendar.png',
                        width: 25,
                        height: 25,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 10),
                      ValueListenableBuilder<DateTime>(
                        builder: (BuildContext context, DateTime value,
                            Widget? child) {
                          return Text(
                              transactions.transactionDate != null
                                  ? formatDate(transactions.transactionDate)
                                  : formatDate(
                                      DateTime.now().millisecondsSinceEpoch),
                              style: MsTheme.of(context)
                                  .title1
                                  .copyWith(color: Colors.white));
                        },
                        valueListenable: _dateTime,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
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
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          MaterialButton(
            onPressed: () async {
              Get.find<DashBoardCubit>().deleteTransaction(transactions.id!);
              Navigator.of(context).pop();
            },
            height: 50,
            color: const Color.fromARGB(135, 68, 63, 63),
            child: Center(
              child: Text(
                "Xóa giao dịch",
                style: MsTheme.of(context).title2.copyWith(color: Colors.red),
              ),
            ),
          ),
        ],
      ),
    );
  }

  SliverWoltModalSheetPage page2(BuildContext modalSheetContext,
      TextTheme textTheme, Transactions transactions) {
    _dateTime.value =
        DateTime.fromMillisecondsSinceEpoch(transactions.transactionDate!);
    return WoltModalSheetPage(
      backgroundColor: const Color.fromARGB(255, 34, 32, 32),
      hasSabGradient: false,
      stickyActionBar: Padding(
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(135, 68, 63, 63)),
          onPressed: () async {
            transactions.amount = int.parse(_moneyController.text);
            transactions.categoryId = categoryId;
            transactions.categoryName = _group.value;
            transactions.description = _note.value;
            transactions.transactionType = transactionType;
            transactions.icon = _groupAvatar.value;
            transactions.transactionDate =
                DateTime.now().millisecondsSinceEpoch;
            await Get.find<DashBoardCubit>()
                .updateTransaction(transactions.id, transactions);
            _group.value = "";
            _note.value = "";
            _moneyController.text = "";
            _groupAvatar.value = "";
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
      topBarTitle: Text('Sửa giao dịch',
          style: MsTheme.of(context).title1.copyWith(color: MsColors.white)),
      isTopBarLayerAlwaysVisible: true,
      leadingNavBarWidget: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          textStyle: MsTheme.of(context).title2.copyWith(color: MsColors.white),
        ),
        onPressed: () {
          pageIndexNotifier.value = 0;
          _group.value = "";
        },
        child: const Text('Hủy'),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 120),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration:
                    const BoxDecoration(color: Color.fromARGB(135, 68, 63, 63)),
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
                                  icon: const Icon(
                                    Icons.clear,
                                    size: 20,
                                    color: Colors.grey,
                                  ),
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
                        pageIndexNotifier.value = 2;
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
                            valueListenable: _groupAvatar,
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
                          pageIndexNotifier.value = 3;
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
                                  color: Colors.grey,
                                  size: 20,
                                ),
                              ),
                            )
                          ],
                        )),
                    const Divider(
                      height: 10,
                    ),
                    MaterialButton(
                        onPressed: () async {
                          _selectDate();
                        },
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
                            ValueListenableBuilder<DateTime>(
                              builder: (BuildContext context, DateTime value,
                                  Widget? child) {
                                return Text(
                                    formatDate(value.millisecondsSinceEpoch),
                                    style: MsTheme.of(context)
                                        .title1
                                        .copyWith(color: Colors.white));
                              },
                              valueListenable: _dateTime,
                            ),
                            const Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Colors.grey,
                                  size: 20,
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

  SliverWoltModalSheetPage page3(
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
                        Get.find<DashBoardCubit>().searchTransactionParent(
                            "userId==${widget.user.id};transactionType==1");
                      } else {
                        Get.find<DashBoardCubit>().searchTransactionParent(
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
              pageIndexNotifier.value = 1,
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

  SliverWoltModalSheetPage page4(
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
            pageIndexNotifier.value = 1;
            _note.value = "";
          },
        ),
        trailingNavBarWidget: IconButton(
          padding: const EdgeInsets.only(left: 16, right: 16),
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.of(modalSheetContext).pop();
            pageIndexNotifier.value = 1;
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

  convertBalance(bool action, int? totalBalance) {
    NumberFormat formatter = NumberFormat.decimalPatternDigits(
      locale: 'en_us',
      decimalDigits: 2,
    );
    if (action) {
      return "${formatter.format(totalBalance)} VND";
    } else {
      String total = "";
      for (int i = 0; i <= formatter.format(totalBalance).length; i++) {
        total += "*";
      }
      return total;
    }
  }

  formatDate(int? timestamp) {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp!);
    var formattedDate =
        DateFormat('EEEE, dd MMMM yyyy', 'vi_VN').format(dateTime);
    return formattedDate;
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dateTime.value,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _dateTime.value) {
      setState(() {
        _dateTime.value = picked;
      });
    }
  }

  Widget _buildListener() {
    return BlocListener(
      bloc: Get.find<DashBoardCubit>(),
      listener: (context, state) async {
        if (state is DeleteTransactionLoading) {
          MSLoading.show();
          return;
        }
        MSLoading.dismiss();

        if (state is DeleteTransactionSuccess) {
          Get.find<DashBoardCubit>().getCurrentUser();
          return;
        }
        if (state is AccountSuccess) {
          setState(() {
            _user = state.response;
          });
          return;
        }

        if (state is SearchTransactionParentSuccess) {
          if (state.response[0].transactionType == 1) {
            transactionParent1 = state.response;
          } else {
            transactionParent2 = state.response;
          }
          return;
        }
      },
      child: Container(),
    );
  }
}
