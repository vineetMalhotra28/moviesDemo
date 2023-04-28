import 'package:get/get.dart';

import '../screens/fav_screen.dart';
import '../screens/home_screen.dart';
import '../screens/movie_detail.dart';

class Routes {
  var route = [
    GetPage(name: '/', page: () => const HomeScreen()),
    GetPage(name: '/movieDetail', page: () => const MovieDetail()),
    GetPage(name: '/favScreen', page: () => const FavScreen()),
  ];
}
