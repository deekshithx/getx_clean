import 'package:get/get.dart';
import 'package:zetexa_assignment/domain/entity/home_page_entity/region_model.dart';
import 'package:zetexa_assignment/presentation/general/images.dart';
import 'package:zetexa_assignment/presentation/pages/config_plans_screen.dart';

class HomePageController extends GetxController {
  List<String> availableSimTypes = ['eSIM', 'Physical SIM'],
      eSimTypes = ['Local eSIMs', 'Regional eSIMs'];
  RxString selectedSimType = ''.obs, selectedESimType = ''.obs, query = ''.obs;
  List<Region> regions = [];
  RxList searchedRegions = <Region>[].obs;

  @override
  void onInit() async {
    selectedSimType(availableSimTypes[0]);
    selectedESimType(eSimTypes[0]);
    fillRegions();
    initDebounce();
    super.onInit();
  }

  initDebounce() {
    debounce(
      query,
      (value) {
        searchRegion(value);
      },
      time: const Duration(milliseconds: 500),
    );
  }

  searchRegion(value) {
    searchedRegions.value = regions
        .where((element) => element.name.toLowerCase().contains(value))
        .toList();
  }

  fillRegions() => regions.addAll([
        Region(
            name: 'India',
            startPrice: '16',
            imagePath: LocalImages().india,
            type: RegionType.local),
        Region(
            name: 'Japan',
            startPrice: '20',
            imagePath: LocalImages().japan,
            type: RegionType.local),
        Region(
            name: 'South Korea',
            startPrice: '19',
            imagePath: LocalImages().southKorea,
            type: RegionType.local),
        Region(
            name: 'Indonesia',
            startPrice: '16',
            imagePath: LocalImages().indonesia,
            type: RegionType.local),
        Region(
            name: 'Dubai',
            startPrice: '16',
            imagePath: LocalImages().dubai,
            type: RegionType.local),
        Region(
            name: 'Africa',
            startPrice: '26',
            imagePath: LocalImages().africa,
            type: RegionType.regional),
        Region(
            name: 'Asia',
            startPrice: '14',
            imagePath: LocalImages().asia,
            type: RegionType.regional),
        Region(
            name: 'Europe',
            startPrice: '23',
            imagePath: LocalImages().europe,
            type: RegionType.regional),
        Region(
            name: 'North America',
            startPrice: '30',
            imagePath: LocalImages().northAmerica,
            type: RegionType.regional),
        Region(
            name: 'Australia',
            startPrice: '23',
            imagePath: LocalImages().australia,
            type: RegionType.regional),
      ]);

  goToPage(Region region) =>
      Get.to(() => ConfigPlansScreen(), arguments: region.name);
}
