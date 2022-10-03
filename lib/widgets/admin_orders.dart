import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edwom/models/user_data.dart';
import 'package:edwom/product.dart';
import 'package:edwom/services/pdf_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/order.dart';
import '../providers.dart';
import 'empty_widget.dart';

class AdminOrders extends ConsumerWidget {
  const AdminOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7E3E0),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: const Color(0xFFE7E3E0),
      ),
      body: StreamBuilder<QuerySnapshot<Order>>(
          stream: ref.read(databaseProvider)!.getAllOrders(),
          builder: (context, snapshot) {
            //   return ListView.builder(
            //       itemCount: snapshot.data!.length,
            //       itemBuilder: (context, index) {
            //         final order = snapshot.data![index];

            //         final total = order.products
            //             .map(((e) => e.price))
            //             .reduce((value, element) => value + element);

            //         return Padding(
            //             padding: const EdgeInsets.all(8.5),
            //             child: ListTile(
            //               title: Text(
            //                 order.products.map((e) => e.name).join(', '),
            //                 style: const TextStyle(
            //                   color: Colors.black,
            //                 ),
            //               ),
            //               subtitle: Text(
            //                 order.timestamp!.toDate().toString(),
            //                 style: const TextStyle(
            //                   color: Colors.black,
            //                 ),
            //               ),
            //               trailing: Text(
            //                 "\$" + total.toString(),
            //                 style: const TextStyle(
            //                   color: Colors.black,
            //                 ),
            //               ),
            //             ));
            //       });
            // }
            // return const Center(child: CircularProgressIndicator());
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text('Error loading data'),
              );
            }
            if (snapshot.hasData) {
              final data = snapshot.data?.docs.map((e) => e.data()).toList();
              return Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Email',style: TextStyle(color: Colors.black,),)),
                          DataColumn(label: Text('Products',style: TextStyle(color: Colors.black,),)),
                          DataColumn(label: Text('Time',style: TextStyle(color: Colors.black,),)),
                        ],
                        rows: data
                                ?.map((e) => DataRow(cells: [
                                      DataCell(Text(e.email,style:const TextStyle(color: Colors.black,),)),
                                      DataCell(Text(e.products.getStringRepr,style:const TextStyle(color: Colors.black,),)),
                                      DataCell(Text(e.createdAt.toString(),style:const TextStyle(color: Colors.black,),)),
                                    ]))
                                .toList() ??
                            []),
                  ),
                  TextButton(
                      style: TextButton.styleFrom(),
                      onPressed: () {
                        PdfService.instance.generatePdf(data!);
                      },
                      child: const Text('Generate Orders'))
                ],
              );
            }
            return Container();
          }),
    );
  }
}

extension on List<Product> {
  String get getStringRepr => this.map((e) => e.name).join(', ');
}
