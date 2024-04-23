import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ms/core/component/ms_color.dart';
import 'package:ms/core/component/ms_theme.dart';
import 'package:ms/data/model/user.dart';
import 'package:intl/date_symbol_data_local.dart';

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

  @override
  void initState() {
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
                convertBalance(isHidden, widget.user.totalBalance!),
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
                              convertBalance(true, widget.user.totalBalance!),
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
                    padding: const EdgeInsets.all(20),
                    itemCount: widget.user.transactions!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(Icons.home),
                              const SizedBox(width: 20),
                              Column(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${widget.user.transactions![index].categoryName}",
                                        style: MsTheme.of(context)
                                            .title1
                                            .copyWith(
                                                color: MsColors.textWhite),
                                      ),
                                      Text(
                                        formatDate(widget
                                            .user.transactions![index].created),
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
                                convertBalance(true,
                                    widget.user.transactions![index].amount),
                                style: MsTheme.of(context)
                                    .caption1
                                    .copyWith(color: MsColors.textWhite),
                              ),
                            ],
                          ));
                    })))
      ],
    );
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
}
