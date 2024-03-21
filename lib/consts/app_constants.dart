import '../models/categories_model.dart';
import '../services/assets_manager.dart';

class AppConstants {
  static const String imageUrl =
      'https://i.ibb.co/8r1Ny2n/20-Nike-Air-Force-1-07.png';

  static List<String> bannersImages = [
    AssetsManager.banner1,
    AssetsManager.banner2,
    AssetsManager.banner3,
    AssetsManager.banner4,
  ];

  static List<CategoriesModel> categoriesList = [
    CategoriesModel(
      id: "Reading",
      image: AssetsManager.mobiles,
      name: "Reading",
    ),
    CategoriesModel(
      id: "Fashion",
      image: AssetsManager.pc,
      name: "Fashion",
    ),
    CategoriesModel(
      id: "Eyesight",
      image: AssetsManager.electronics,
      name: "Eyesight",
    ),
    CategoriesModel(
      id: "Sunglasses",
      image: AssetsManager.watch,
      name: "Sunglasses",
    ),
    CategoriesModel(
      id: "Computer",
      image: AssetsManager.fashion,
      name: "Computer",
    ),
    CategoriesModel(
      id: "DriveWear",
      image: AssetsManager.shoes,
      name: "DriveWear",
    ),
    CategoriesModel(
      id: "BlueLight ",
      image: AssetsManager.book,
      name: "BlueLight ",
    ),
    CategoriesModel(
      id: "Trending",
      image: AssetsManager.cosmetics,
      name: "Trending",
    ),
  ];
}
