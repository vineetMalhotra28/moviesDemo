import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_demo/controllers/home_controller.dart';
import 'package:intl/intl.dart' as intl;
import '../widgets/detailsRow.dart';

class MovieDetail extends StatelessWidget {
  const MovieDetail({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    // controller.checkfavIdExist(controller.id);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text('${controller.title}'),
        actions: [
          Obx(
            () => IconButton(
                onPressed: () {
                  if (controller.fav.value) {
                    controller.deleteRecord(controller.currentId.value);
                  } else {
                    controller.addRecord(
                      controller.id.value,
                      controller.title.value,
                      controller.posterPath.value,
                    );
                  }
                },
                icon: controller.fav.value
                    ? const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                    : const Icon(
                        Icons.favorite,
                      )),
          ),
          PopupMenuButton<int>(
            onSelected: (item) => (item),
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                  onTap: () {
                    controller.readRecord().then((value) {
                      // print('heeeloo');
                      Get.toNamed('/favScreen');
                    });
                    // Get.toNamed('/');
                  },
                  value: 0,
                  child: const Text('Favourite')),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Image.network(
                'https://image.tmdb.org/t/p/w500/${controller.posterPath}',
                width: screenWidth - 30,
                height: 300,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 20,
              ),
              DetailRow('Title : ', '${controller.title}'),
              const SizedBox(
                height: 20,
              ),
              DetailRow(
                  'Release Date : ',
                  intl.DateFormat("d MMM yyyy")
                      .format(DateTime.parse(controller.releaseDate.value))
                      .toString()),
              const SizedBox(
                height: 20,
              ),
              DetailRow('Summary : ', '${controller.overview}'),
            ],
          ),
        ),
      ),
    );
  }
}
