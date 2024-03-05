import 'package:flutter/material.dart';
import 'package:pdf_apps/service/pdf_service.dart';

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  final Service service = Service();

  List _orders = [];

  @override
  void initState() {
    super.initState();
  }

  // Future<void> re
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    final data = await service.generatePdf();
                    service.savePdfFile("PLN PDF", data);
                  },
                  child: Text('Get Pdf')),
              ElevatedButton(
                  onPressed: () async {
                    await service.exportExcel();
                  },
                  child: Text('Get Excel')),
            ],
          ),
        ),
      ),
    );
  }
}
