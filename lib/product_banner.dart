import 'package:flutter/material.dart';

class ProductBanner extends StatelessWidget {
  const ProductBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 175,
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 250, 123, 0),
              Colors.black,
            ],
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  "New Product",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 10),
                Text("Cool shoes",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 32)),
              ],
            ),
            Image.network(
              "https://firebasestorage.googleapis.com/v0/b/edwom-project.appspot.com/o/D8ZZDb2DNHXumootDJSLvFzd5Hr1%2F2022-09-02T15%3A34%3A45.150297?alt=media&token=14811933-37bf-4d5c-9a55-f64990b11860",
              width: 125,
            )
          ],
        ));
  }
}
