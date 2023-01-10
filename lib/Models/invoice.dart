import 'package:cmed_app/Models/customer.dart';
import 'package:cmed_app/Models/supplier.dart';

class Invoice {
  final InvoiceInfo info;
  final Supplier supplier;
  final Customer customer;
  final List<InvoiceItem> items;

  const Invoice({
    required this.info,
    required this.supplier,
    required this.customer,
    required this.items,
  });
}

class InvoiceInfo {
  final DateTime fechaCreacionR;
  final DateTime fechaCreacionD;
  final String cod_persona;

  const InvoiceInfo({
    required this.fechaCreacionR,
    required this.fechaCreacionD,
    required this.cod_persona
  });
}

class InvoiceItem {
  final String description;
  final DateTime date;
  final int quantity;
  final double vat;
  final double unitPrice;

  const InvoiceItem({
    required this.description,
    required this.date,
    required this.quantity,
    required this.vat,
    required this.unitPrice,
  });
}
