import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_demo/models/home_model.dart';

import '../controllers/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text('Popular Movies'),
      ),
      body: Obx(() => controller.isDataLoad.value
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            )
          : FutureBuilder(
              future: controller.homeData,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  // print(snapshot.data..wind?.speed);
                  return (const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  ));
                } else {
                  HomeModel data = snapshot.data;
                  var homedata = data.results;
                  var sortData = controller.sortlist(homedata);
                  // print(sortData[0].title);
                  return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: sortData!.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            controller.title.value =
                                sortData![index][0]['title'];
                            controller.posterPath.value =
                                sortData![index][0]['posterPath'];
                            controller.id.value = sortData![index][0]['id'];
                            controller.overview.value =
                                sortData![index][0]['overview'];
                            controller.releaseDate.value =
                                sortData![index][0]['releaseDate'].toString();

                            controller
                                .getCurrentRowData(sortData![index][0]['id']);
                            Get.toNamed('movieDetail');
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.network(
                                  'https://image.tmdb.org/t/p/w500/${sortData![index][0]['posterPath']}',
                                  width: screenWidth * .3,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                    child: Text(
                                  '${sortData[index][0]['title']}',
                                  style: TextStyle(fontSize: 18),
                                ))
                              ],
                            ),
                          ),
                        );
                      });
                }
              })),
    ));
  }
}
