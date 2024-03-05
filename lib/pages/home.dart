import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf_apps/service/pdf_service.dart';

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  final Service service = Service();

  List _orders = [];

  // Future<void> readJson() async {
  //   final String response = await rootBundle.loadString('assets/orders.json');
  //   final data = await json.decode(response);
  //   setState(() {
  //     _orders = data['records'];
  //   });
  // }

  @override
  void initState() {
    // readJson();
    super.initState();
  }

  // Future<void> re
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
              onPressed: () async {
                final data = await service.generatePdf();
                service.savePdfFile("PLN PDF", data);
              },
              child: Text('Get Pdf')),
        ),
      ),
    );
  }
}
