import 'dart:core';
import 'dart:math';

// import 'package:charts_flutter/flutter.dart' as charts;
import 'package:darq/darq.dart';
import 'package:date_util/date_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/data_holder.dart';
import 'package:hishabee_business_manager_fl/app/_utils/utility.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/expenses/data/remote/models/expense_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/expenses/domain/repositories/i_expense_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/transaction_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/domain/repositories/i_transaction_repository.dart';
import 'package:intl/intl.dart';

class ReportController extends GetxController {
  final showCase = true.obs;

  final shop = Shop().obs;
  final transactionList = <Transactions>[].obs;

  final filterTransactionList = <Transactions>[].obs;

  final expenseList = <ExpenseResponseModel>[].obs;

  final filterExpenseList = <ExpenseResponseModel>[].obs;

  final todaysSale = 0.0.obs;
  final todaysExpense = 0.0.obs;

  // final saleLineData = <charts.Series<TimeSeriesSales, DateTime>>[].obs;
  // final barChartData = <charts.Series<BarChartData, String>>[].obs;
  // final pieChartData = <charts.Series<PieChartData, String>>[].obs;

  final date = DateTime.now().obs;

  final ITransactionRepository transactionRepository;
  final IExpenseRepository expenseRepository;

  ReportController(this.transactionRepository, this.expenseRepository);

  @override
  void onInit() async {
    getArguments();

    Future.delayed(const Duration(seconds: 3), () {
      showCase.value = false;
    });
    super.onInit();
  }

  @override
  onReady() async {
    await initData();
    super.onReady();
  }

  initData() async {
    await getAllTransaction();
    getToDaysTransaction();
    await getAllExpense();
    getToDaysExpense();
    createLineChartData();
    createPieChartData();
    createBarChartData();
  }

  getArguments() {
    shop.value = Get.arguments["shop"];
  }

  getAllTransaction() async {
    final result = await transactionRepository.getAllTransaction(
        shopId: DataHolder.shopId);

    transactionList.assignAll(result.data);
  }

  getToDaysTransaction() {
    final result = transactionList.where((element) {
      if (element.createdAt != null) {
        return Utility.isToday(element.createdAt);
      }
      return false;
    }).toList();
    filterTransactionList.assignAll(result);

    calculateTodaysSale(filterTransactionList);
  }

  calculateTodaysSale(List<Transactions> trans) {
    var temp = 0.0;
    trans.forEach((element) {
      temp += element.totalPrice;
    });
    todaysSale.value = temp;
  }

  getAllExpense() async {
    final result =
        await expenseRepository.getAllExpense(shopId: DataHolder.shopId);

    expenseList.assignAll(result);
  }

  getToDaysExpense() {
    final result = expenseList.where((element) {
      if (element.createdAt != null) {
        return Utility.isToday(element.createdAt);
      }
      return false;
    }).toList();
    filterExpenseList.assignAll(result);

    calculateTodaysSale(filterTransactionList);
  }

  calculateTodaysExpense(List<ExpenseResponseModel> list) {
    var temp = 0.0;
    list.forEach((element) {
      temp += element.amount;
    });
    todaysExpense.value = temp;
  }

  incrementDate() {
    date.value =
        DateTime(date.value.year, date.value.month + 1, date.value.day);

    createLineChartData();
    createPieChartData();
    createBarChartData();
  }

  decrementDate() {
    date.value =
        DateTime(date.value.year, date.value.month - 1, date.value.day);
    createLineChartData();
    createPieChartData();
    createBarChartData();
  }

  List<Transactions> getSalesByMonth(DateTime date, int daysInMonth) {
    List<Transactions> list = [];
    transactionList.forEach((element) {
      if (element.createdAt.difference(date).inDays <= daysInMonth) {
        list.add(element);
      }
    });

    return list;
  }

  List<ExpenseResponseModel> getExpensesByMonth(
      DateTime date, int daysInMonth) {
    List<ExpenseResponseModel> list = [];
    expenseList.forEach((element) {
      if (element.createdAt.difference(date).inDays <= daysInMonth) {
        list.add(element);
      }
    });

    return list;
  }

  createLineChartData() {
    var data = <TimeSeriesSales>[];

    var dateUtil = DateUtil();

    var days = dateUtil.daysInMonth(date.value.month, date.value.year);

    var sales = getSalesByMonth(date.value, days);

    for (int i = 1; i <= days; i++) {
      var d = DateTime(date.value.year, date.value.month, i);
      double dAmount = 0;
      sales.forEach((element) {
        if (element.createdAt.difference(d).inDays == 0) {
          dAmount += element.totalPrice;
        }
      });

      data.add(TimeSeriesSales(d, dAmount));
    }
    var seriesData = [
      // new charts.Series<TimeSeriesSales, DateTime>(
      //   id: 'Sales',
      //   domainFn: (TimeSeriesSales sales, _) => sales.time,
      //   measureFn: (TimeSeriesSales sales, _) => sales.sales,
      //   data: data,
      // )
    ];
    // saleLineData.assignAll(seriesData);
  }

  createPieChartData() {
    var expenseData = <PieChartData>[];

    var dateUtil = DateUtil();

    var days = dateUtil.daysInMonth(date.value.month, date.value.year);

    var expenses = getExpensesByMonth(date.value, days);

    var expCat = <String>[];

    var distEx = expenses.distinct((element) => element.type).toList();

    distEx.forEach((element) {
      expCat.add(element.type);
    });

    expCat.forEach((cat) {
      double eAmount = 0;

      for (int i = 1; i <= days; i++) {
        var d = DateTime(date.value.year, date.value.month, i);
        expenses.forEach((element) {
          if (element.createdAt.difference(d).inDays == 0 &&
              cat == element.type) {
            eAmount += element.amount;
          }
        });
      }

      if (eAmount > 0) {
        expenseData.add(PieChartData(
            cat,
            eAmount,
            Color((Random().nextDouble() * 0xFFFFFF).toInt())
                .withOpacity(1.0)));
      }
    });
    if (expenseData.isNotEmpty) {
      final pieData = [
        // new charts.Series<PieChartData, String>(
        //     id: 'Sales',
        //     domainFn: (PieChartData expense, _) => expense.expenseName,
        //     measureFn: (PieChartData expense, _) => expense.amount,
        //     data: expenseData,
        //     colorFn: (PieChartData expense, _) =>
        //         charts.ColorUtil.fromDartColor(expense.colorsValue),
        //     labelAccessorFn: (PieChartData expense, _) => "${expense.amount}")
      ];

      // pieChartData.assignAll(pieData);
    } else {
      // pieChartData.clear();
    }
  }

  createBarChartData() {
    var saleData = <BarChartData>[];

    var dateUtil = DateUtil();

    var days = dateUtil.daysInMonth(date.value.month, date.value.year);

    var sales = getSalesByMonth(date.value, days);
    double sAmount = 0;

    for (int i = 1; i <= days; i++) {
      var d = DateTime(date.value.year, date.value.month, i);
      sales.forEach((element) {
        if (element.createdAt.difference(d).inDays == 0) {
          sAmount += element.totalPrice;
        }
      });
    }

    saleData.add(
        BarChartData('${DateFormat('MMM yyyy').format(date.value)}', sAmount));

    final expenseData = <BarChartData>[];

    var expenses = getExpensesByMonth(date.value, days);

    double eAmount = 0;

    for (int i = 1; i <= days; i++) {
      var d = DateTime(date.value.year, date.value.month, i);
      expenses.forEach((element) {
        if (element.createdAt.difference(d).inDays == 0) {
          eAmount += element.amount;
        }
      });
    }
    expenseData.add(
        BarChartData('${DateFormat('MMM yyyy').format(date.value)}', eAmount));

    var barData = [
      // charts.Series<BarChartData, String>(
      //   id: 'Sale',
      //   colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      //   domainFn: (BarChartData sales, _) => sales.time,
      //   measureFn: (BarChartData sales, _) => sales.amount,
      //   data: saleData,
      // ),
      // charts.Series<BarChartData, String>(
      //   id: 'Expense',
      //   colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
      //   domainFn: (BarChartData expense, _) => expense.time,
      //   measureFn: (BarChartData expense, _) => expense.amount,
      //   data: expenseData,
      // )
    ];

    // barChartData.assignAll(barData);
  }
}

class TimeSeriesSales {
  final DateTime time;
  final double sales;

  TimeSeriesSales(this.time, this.sales);
}

class PieChartData {
  final String expenseName;
  final double amount;
  final Color colorsValue;

  PieChartData(this.expenseName, this.amount, this.colorsValue);
}

class BarChartData {
  final String time;
  final double amount;

  BarChartData(this.time, this.amount);
}
