import 'package:flutter/material.dart';

class ProductBanner extends StatelessWidget {
  const ProductBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
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
                Text("Fresh Tomato",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 32)),
              ],
            ),
            Image.network(
              "https://firebasestorage.googleapis.com/v0/b/edwom-project.appspot.com/o/D8ZZDb2DNHXumootDJSLvFzd5Hr1%2F2022-09-18T19%3A27%3A03.115264?alt=media&token=f615b17b-ad91-42f9-b240-8a23566d702452",
              width: 125,
            )
          ],
        ));
  }
}
