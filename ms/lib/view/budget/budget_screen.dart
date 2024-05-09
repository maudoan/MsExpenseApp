import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ms/core/component/ms_color.dart';
import 'package:ms/core/component/ms_loading.dart';
import 'package:ms/core/component/ms_state_page.dart';
import 'package:ms/core/component/ms_theme.dart';
import 'package:ms/core/utils/ms_utils.dart';
import 'package:ms/data/model/budgets.dart';
import 'package:ms/data/model/transaction_parent.dart';
import 'package:ms/data/model/user.dart';
import 'package:ms/view/budget/cubit/budget_cubit.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen>
    with TickerProviderStateMixin {
  late User _user;
  late TabController _tabController;
  final pageIndexNotifier = ValueNotifier(0);
  late final ValueNotifier<String> _group = ValueNotifier<String>("");
  late final ValueNotifier<String> _groupAvatar = ValueNotifier<String>("");
  late final TextEditingController _moneyController = TextEditingController();
  late List<TransactionParent> transactionParent1 = [];
  late List<TransactionParent> transactionParent2 = [];
  late int categoryId;
  late int transactionType;
  final DateTime _startDate = DateTime.now();
  final DateTime _endDate = DateTime.now().add(const Duration(days: 7));
  late final ValueNotifier<DateTime> _startDateTime =
      ValueNotifier<DateTime>(_startDate);
  late final ValueNotifier<DateTime> _endDateTime =
      ValueNotifier<DateTime>(_endDate);
  @override
  void initState() {
    _user = widget.user;
    _tabController = TabController(length: 2, vsync: this);
    Get.put(BudgetCubit(Get.find()));
    Get.find<BudgetCubit>().getCurrentUser();
    Get.find<BudgetCubit>().searchTransactionParent(
        "userId==${widget.user.id};transactionType==1");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(221, 2, 2, 2),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(221, 2, 2, 2),
        centerTitle: true,
        title: Text('Ngân sách',
            style: MsTheme.of(context).title1.copyWith(color: MsColors.white)),
      ),
      body: (_user.budgets != null && _user.budgets!.isNotEmpty)
          ? Stack(
              children: [
                Center(
                  child: Text("MY SUNSHINE"),
                ),
                _buildListener()
              ],
            )
          : Stack(
              children: [
                Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MsStatePage.empty(
                            title: "Bạn chưa có ngân sách",
                            error:
                                "Bắt đầu tiết kiệm bằng cách tạo ngân sách và chúng tôi sẽ giúp bạn kiểm soát ngân sách",
                            titleStyle: MsTheme.of(context)
                                .title1
                                .copyWith(color: MsColors.white),
                            descStyle: MsTheme.of(context)
                                .body1
                                .copyWith(color: MsColors.grey)),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(135, 68, 63, 63)),
                            onPressed: () async {
                              _showTransactionsBottomSheet(context);
                            },
                            child: Center(
                                child: Text('Tạo ngân sách',
                                    style: MsTheme.of(context)
                                        .body1
                                        .copyWith(color: MsColors.white))),
                          ),
                        )
                      ]),
                ),
                _buildListener()
              ],
            ),
    );
  }

  void _showTransactionsBottomSheet(BuildContext context) {
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
            if (isValidBudget(_moneyController.text, _group.value,
                _startDateTime.toString(), _endDateTime.value.toString())) {
              Navigator.of(modalSheetContext).pop();
              Budgets budgets = Budgets();
              budgets.amount = int.parse(_moneyController.text);
              budgets.categoryId = categoryId;
              budgets.categoryName = _group.value;
              budgets.categoryType = transactionType;
              budgets.categoryIcon = _groupAvatar.value;
              budgets.budgetDateStart =
                  _startDateTime.value.millisecondsSinceEpoch;
              budgets.budgetDateEnd = _endDateTime.value.millisecondsSinceEpoch;
              await Get.find<BudgetCubit>().createBudget(budgets);
              _group.value = "";
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
      topBarTitle: Text('Thêm ngân sách',
          style: MsTheme.of(context).title1.copyWith(color: MsColors.white)),
      isTopBarLayerAlwaysVisible: true,
      leadingNavBarWidget: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          textStyle: MsTheme.of(context).title2.copyWith(color: MsColors.white),
        ),
        onPressed: () {
          Navigator.of(modalSheetContext).pop();
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
                                  onPressed: () {
                                    _moneyController.text = "";
                                  },
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
                          pageIndexNotifier.value = 2;
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
                            const SizedBox(width: 20),
                            ValueListenableBuilder<DateTime>(
                              builder: (BuildContext context, DateTime value,
                                  Widget? child) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'Từ:  ${formatDate(_startDateTime.value)}',
                                        style: MsTheme.of(context)
                                            .title1
                                            .copyWith(color: Colors.white)),
                                    Text(
                                        'Đến:  ${formatDate(_endDateTime.value)}',
                                        style: MsTheme.of(context)
                                            .title1
                                            .copyWith(color: Colors.white)),
                                  ],
                                );
                              },
                              valueListenable: _startDateTime,
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
                              'assets/images/global.png',
                              width: 25,
                              height: 25,
                              fit: BoxFit.cover,
                            ),
                            TextButton(
                              onPressed: Navigator.of(modalSheetContext).pop,
                              child: Text(
                                'Tổng cộng',
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
                        Get.find<BudgetCubit>().searchTransactionParent(
                            "userId==${widget.user.id};transactionType==1");
                      } else {
                        Get.find<BudgetCubit>().searchTransactionParent(
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
                        text: 'Vay/Nợ',
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
    return WoltModalSheetPage(
      hasSabGradient: false,
      isTopBarLayerAlwaysVisible: true,
      leadingNavBarWidget: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.black,
          textStyle: MsTheme.of(context).title2.copyWith(color: Colors.black),
        ),
        onPressed: () {
          pageIndexNotifier.value = 0;
        },
        child: const Text('Đóng'),
      ),
      trailingNavBarWidget: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.black,
          textStyle: MsTheme.of(context).title2.copyWith(color: Colors.black),
        ),
        onPressed: () {
          pageIndexNotifier.value = 0;
        },
        child: const Text('Xong'),
      ),
      child: Column(
        children: [
          ValueListenableBuilder<DateTime>(
            builder: (BuildContext context, DateTime value, Widget? child) {
              return ListTile(
                title:
                    Text('Ngày bắt đầu: ${formatDate(_startDateTime.value)}'),
                trailing: Image.asset(
                  'assets/images/calendar.png',
                  width: 25,
                  height: 25,
                  fit: BoxFit.cover,
                ),
                onTap: _selectStartDate,
              );
            },
            valueListenable: _startDateTime,
          ),
          ValueListenableBuilder<DateTime>(
            builder: (BuildContext context, DateTime value, Widget? child) {
              return ListTile(
                title: Text('Ngày kết thúc: ${formatDate(_endDateTime.value)}'),
                trailing: Image.asset(
                  'assets/images/calendar.png',
                  width: 25,
                  height: 25,
                  fit: BoxFit.cover,
                ),
                onTap: _selectEndDate,
              );
            },
            valueListenable: _endDateTime,
          ),
        ],
      ),
    );
  }

  Future<void> _selectStartDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDateTime.value,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _startDateTime.value) {
      setState(() {
        _startDateTime.value = picked;
      });
    }
  }

  Future<void> _selectEndDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _endDateTime.value,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      if (picked.isBefore(_startDateTime.value)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Ngày kết thúc không thể nhỏ hơn ngày bắt đầu."),
          ),
        );
      } else {
        setState(() {
          _endDateTime.value = picked;
        });
      }
    }
  }

  formatDate(DateTime dateTime) {
    var formattedDate =
        DateFormat('EEEE, dd MMMM yyyy', 'vi_VN').format(dateTime);
    return formattedDate;
  }

  bool isValidBudget(
      String money, String group, String startDate, String endDate) {
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

    if (startDate.isEmpty) {
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
    if (endDate.isEmpty) {
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

  Widget _buildListener() {
    return BlocListener(
      bloc: Get.find<BudgetCubit>(),
      listener: (context, state) async {
        if (state is AccountLoading) {
          MSLoading.show();
          return;
        }
        MSLoading.dismiss();

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

        if (state is CreateBudgetSuccess) {
          Get.find<BudgetCubit>().getCurrentUser();
          setState(() {});
          return;
        }
      },
      child: Container(),
    );
  }
}
