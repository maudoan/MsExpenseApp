import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ms/core/component/ms_color.dart';
import 'package:ms/core/component/ms_loading.dart';
import 'package:ms/core/component/ms_state_page.dart';
import 'package:ms/core/component/ms_theme.dart';
import 'package:ms/data/model/user.dart';
import 'package:ms/view/budget/cubit/budget_cubit.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  late User _user;
  final pageIndexNotifier = ValueNotifier(0);
  @override
  void initState() {
    Get.put(BudgetCubit(Get.find()));
    Get.find<BudgetCubit>().getCurrentUser();
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
      body: (widget.user.budgets != null && widget.user.budgets!.isNotEmpty)
          ? Stack(
              children: [_buildListener()],
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
          onPressed: () async {},
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
                    const Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Row(
                          children: [
                            Icon(
                              Icons.money,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                                child: TextField(
                              keyboardType: TextInputType.number,
                              controller: null,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(color: Colors.white),
                                hintText: 'Số tiền',
                                border: InputBorder.none,
                                suffixIcon: IconButton(
                                  onPressed: null,
                                  icon: Icon(Icons.clear,
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
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // ValueListenableBuilder<String>(
                          //   builder: (BuildContext context, String value,
                          //       Widget? child) {
                          //     return ClipOval(
                          //       child: Container(
                          //         color: const Color.fromRGBO(143, 148, 251, 1),
                          //         padding: const EdgeInsets.all(8),
                          //         child: Image.asset(
                          //           'assets/images/dog.png',
                          //           width: 25,
                          //           height: 25,
                          //           fit: BoxFit.cover,
                          //         ),
                          //       ),
                          //     );
                          //   },
                          //   valueListenable: _group,
                          // ),
                          // const SizedBox(width: 10),
                          // ValueListenableBuilder<String>(
                          //   builder: (BuildContext context, String value,
                          //       Widget? child) {
                          //     return Text(value.isEmpty ? "Chọn nhóm" : value,
                          //         style: MsTheme.of(context)
                          //             .title1
                          //             .copyWith(color: Colors.white));
                          //   },
                          //   valueListenable: _group,
                          // ),
                          Expanded(
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
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.notes,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 10),
                            // ValueListenableBuilder<String>(
                            //   builder: (BuildContext context, String value,
                            //       Widget? child) {
                            //     return Text(value.isEmpty ? "Ghi chú" : value,
                            //         style: MsTheme.of(context)
                            //             .title1
                            //             .copyWith(color: Colors.white));
                            //   },
                            //   valueListenable: _note,
                            // ),
                            Expanded(
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
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.calendar_month,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 10),
                            // ValueListenableBuilder<int>(
                            //   builder: (BuildContext context, int value,
                            //       Widget? child) {
                            //     return Text(formatDate(),
                            //         style: MsTheme.of(context)
                            //             .title1
                            //             .copyWith(color: Colors.white));
                            //   },
                            //   valueListenable: _date,
                            // ),
                            Expanded(
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
                            const Icon(
                              Icons.wallet,
                              color: Colors.grey,
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
      },
      child: Container(),
    );
  }
}
