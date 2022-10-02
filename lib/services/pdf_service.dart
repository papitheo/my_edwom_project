import 'dart:io';

import 'package:edwom/models/order.dart';
import 'package:edwom/product.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PdfService {
  static final instance = PdfService._();
  PdfService._();

  Future<void> generatePdf(List<Order> orders) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    final PdfDocument document = PdfDocument();
    final PdfPage page = document.pages.add();
    final PdfGrid grid = PdfGrid();
    grid.columns.add(count: 3);
    final PdfGridRow headerRow = grid.headers.add(1)[0];
    headerRow.cells[0].value = 'Email';
    headerRow.cells[1].value = 'Products';
    headerRow.cells[2].value = 'Time';
    headerRow.style.font =
        PdfStandardFont(PdfFontFamily.helvetica, 10, style: PdfFontStyle.bold);
    orders.forEach((element) {
      PdfGridRow row = grid.rows.add();
      row.cells[0].value = element.email;
      row.cells[1].value = element.products.getStringRepr;
      row.cells[2].value = element.createdAt.toString();
    });
    grid.style.cellPadding = PdfPaddings(left: 5, top: 5);
    grid.draw(
        page: page,
        bounds: Rect.fromLTWH(
            0, 0, page.getClientSize().width, page.getClientSize().height));
    File(appDocPath + 'orders.pdf').writeAsBytes(await document.save());
    document.dispose();
    OpenFile.open(appDocPath + 'orders.pdf');
  }
}

extension on List<Product> {
  String get getStringRepr => this.map((e) => e.name).join(', ');
}
