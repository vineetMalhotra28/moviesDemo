import 'package:movies_demo/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: const Text('Fav Movies'),
      ),
      body: Obx(() => controller.favList.isEmpty
          ? const Center(
              child: Text(
              'No Fav movie found',
              style: TextStyle(color: Colors.black),
            ))
          : Column(
              children: List.generate(controller.favList.length, (index) {
              return Dismissible(
                background: Container(color: Colors.red),
                onDismissed: (direction) {
                  controller.deleteRecord(controller.favList[index]['_id']);
                  controller.readRecord();
                },
                key: ObjectKey(controller.favList[index]),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.network(
                        'https://image.tmdb.org/t/p/w500/${controller.favList[index]['posterPath']}',
                        width: screenWidth * .3,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: Text(
                        '${controller.favList[index]['title']}',
                        style: const TextStyle(fontSize: 18),
                      ))
                    ],
                  ),
                ),
              );
            }))),
    ));
  }
}
