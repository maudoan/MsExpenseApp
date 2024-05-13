import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ms/core/component/ms_color.dart';
import 'package:ms/core/component/ms_loading.dart';
import 'package:ms/core/component/ms_theme.dart';
import 'package:ms/core/utils/ms_utils.dart';
import 'package:ms/data/model/budgets.dart';
import 'package:ms/data/model/user.dart';
import 'package:ms/route/routes.dart';
import 'package:ms/view/budget/budget_screen.dart';
import 'package:ms/view/budget/cubit/budget_cubit.dart';

class BudgetDetailScreen extends StatefulWidget {
  const BudgetDetailScreen({Key? key, required this.budget}) : super(key: key);
  final Budgets budget;
  @override
  State<BudgetDetailScreen> createState() => _BudgetDetailScreenState();
}

class _BudgetDetailScreenState extends State<BudgetDetailScreen> {
  final ScrollController _scrollController = ScrollController();
  late User _user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(221, 2, 2, 2),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(221, 2, 2, 2),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Quay lại',
          style: MsTheme.of(context).title1.copyWith(color: MsColors.white),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {},
            child: Text(
              'Sửa',
              style: MsTheme.of(context).title1.copyWith(color: MsColors.white),
            ),
          ),
        ],
      ),
      body: Stack(children: [
        Scrollbar(
            child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: CustomScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: _buildDetailBudget(),
              ),
            ],
          ),
        )),
        _buildListener()
      ]),
    );
  }

  Widget _buildDetailBudget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
            color: const Color.fromARGB(137, 141, 131, 131),
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipOval(
                          child: Container(
                              color: const Color.fromRGBO(143, 148, 251, 1),
                              padding: const EdgeInsets.all(8),
                              child: Image.asset(
                                MsUtils.getPathIcons(
                                    widget.budget.categoryIcon),
                                width: 25,
                                height: 25,
                                fit: BoxFit.cover,
                              )),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.budget.categoryName!,
                                style: MsTheme.of(context)
                                    .title1
                                    .copyWith(color: Colors.white)),
                            const SizedBox(height: 10),
                            Text(convertBalance(true, widget.budget.amount),
                                style: MsTheme.of(context)
                                    .title1
                                    .copyWith(color: Colors.white)),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Đã chi",
                                        style: MsTheme.of(context)
                                            .body2
                                            .copyWith(color: Colors.white)),
                                    Text(
                                        convertBalance(
                                            true, widget.budget.amount),
                                        style: MsTheme.of(context)
                                            .body1
                                            .copyWith(color: Colors.white)),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Còn lại",
                                        style: MsTheme.of(context)
                                            .body2
                                            .copyWith(color: Colors.white)),
                                    Text(
                                        convertBalance(
                                            true, widget.budget.amount),
                                        style: MsTheme.of(context)
                                            .body1
                                            .copyWith(color: Colors.white)),
                                  ],
                                )
                              ],
                            )
                          ],
                        ))
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/calendar.png',
                          width: 25,
                          height: 25,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                '${formatDate(widget.budget.budgetDateStart)} --> ${formatDate(widget.budget.budgetDateEnd)}',
                                style: MsTheme.of(context)
                                    .title1
                                    .copyWith(color: Colors.white)),
                            Text('Còn lại',
                                style: MsTheme.of(context)
                                    .body2
                                    .copyWith(color: Colors.white)),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/global.png',
                          width: 25,
                          height: 25,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(width: 20),
                        Text(
                          'Tổng cộng',
                          style: MsTheme.of(context)
                              .title2
                              .copyWith(color: Colors.white),
                        )
                      ],
                    )
                  ],
                ))),
        Card(
          color: const Color.fromARGB(137, 141, 131, 131),
          child: InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                width: double.infinity,
                height: 20.0,
                child: Center(
                    child: Text(
                  'Danh sách giao dịch',
                  style:
                      MsTheme.of(context).title2.copyWith(color: Colors.green),
                )),
              ),
            ),
          ),
        ),
        Card(
          color: const Color.fromARGB(137, 141, 131, 131),
          child: InkWell(
            onTap: () {
              Get.find<BudgetCubit>().deleteBudget(widget.budget.id!);
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                width: double.infinity,
                height: 20.0,
                child: Center(
                    child: Text(
                  'Xóa',
                  style: MsTheme.of(context).title2.copyWith(color: Colors.red),
                )),
              ),
            ),
          ),
        )
      ],
    );
  }

  formatDate(int? timestamp) {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp!);
    var formattedDate = DateFormat('dd MMMM yyyy', 'vi_VN').format(dateTime);
    return formattedDate;
  }

  convertBalance(bool action, int? totalBalance) {
    NumberFormat formatter = NumberFormat.decimalPatternDigits(
      locale: 'en_us',
      decimalDigits: 2,
    );
    if (action) {
      return formatter.format(totalBalance);
    } else {
      String total = "";
      for (int i = 0; i <= formatter.format(totalBalance).length; i++) {
        total += "*";
      }
      return total;
    }
  }

  Widget _buildListener() {
    return BlocListener(
      bloc: Get.find<BudgetCubit>(),
      listener: (context, state) async {
        if (state is DeleteBudgetLoading) {
          MSLoading.show();
          return;
        }
        MSLoading.dismiss();

        if (state is DeleteBudgetSuccess) {
          Get.find<BudgetCubit>().getCurrentUser();
          return;
        }

        if (state is AccountSuccess) {
          _user = state.response;
          Get.offAllNamed(AppRoute.HOME_SCREEN.name, arguments: [_user, 3]);
          return;
        }
      },
      child: Container(),
    );
  }
}
