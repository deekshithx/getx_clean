import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:zetexa_assignment/domain/entity/home_page_entity/region_model.dart';
import 'package:zetexa_assignment/presentation/controllers/home_page_controller.dart';
import 'package:zetexa_assignment/presentation/widgets/options_selector.dart';
import 'package:zetexa_assignment/presentation/widgets/region_list_tile.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomePageController homePageController = Get.put(HomePageController());
  final TextStyle headerTextStyle = const TextStyle(
      fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xfff0ecec),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _customAppBar(),
              _eSimTypeSelector(),
              _eSimList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _eSimList() {
    return Obx(
      () => Column(
        children: homePageController.query.isNotEmpty
            ? homePageController.searchedRegions
                .map((region) => RegionListTile(
                      region: region,
                      onTap: () => homePageController.goToPage(region),
                    ))
                .toList()
            : (homePageController.regions.where((element) =>
                    element.type ==
                    (homePageController.selectedESimType
                            .toLowerCase()
                            .contains('local')
                        ? RegionType.local
                        : RegionType.regional)))
                .map((region) => RegionListTile(
                      region: region,
                      onTap: () => homePageController.goToPage(region),
                    ))
                .toList(),
      ),
    );
  }

  Padding _eSimTypeSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 23),
      child: Obx(
        () => OptionsSelector(
            fitToWidth: true,
            outerBorderRadius: 4,
            optionsRadius: 4,
            fontSizeFactor: 0.78,
            optionsConstraints: BoxConstraints(minWidth: 25.w),
            unselectedOptionTextColor: Colors.black,
            selectedOption: homePageController.selectedESimType.value,
            optionsBGColor: Colors.white,
            selectedTabcolor: Colors.black,
            options: homePageController.eSimTypes,
            onChanged: (_) {
              homePageController.selectedESimType(_);
            }),
      ),
    );
  }

  Widget _customAppBar() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        _header(),
        _searchBar(),
      ],
    );
  }

  Container _searchBar() {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            boxShadow: const [
              BoxShadow(
                  color: Color.fromARGB(255, 97, 97, 97),
                  blurRadius: 3.0,
                  spreadRadius: 0.8)
            ]),
        child: TextField(
          decoration: InputDecoration(
              hintText: ' Search here',
              hintStyle:
                  const TextStyle(fontSize: 13, color: Color(0xffc4c4c4)),
              suffixIcon: const Icon(
                Icons.search,
                size: 26,
              ),
              isDense: true,
              counterText: "",
              contentPadding: const EdgeInsets.all(10.0),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none)),
          onChanged: (_) {
            print(_);
            homePageController.query(_);
          },
          textAlign: TextAlign.start,
          maxLines: 1,
          maxLength: 20,
        ));
  }

  Container _header() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      color: const Color(0xff111111),
      width: double.infinity,
      height: 28.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _simTypeSelector(),
          SizedBox(
            height: 3.h,
          ),
          Text(
            'Hi, 👋🏻 Welcome',
            style: headerTextStyle,
          ),
          SizedBox(
            width: 50.w,
            child: Text(
              'Customize your own pack across 160 countries',
              textAlign: TextAlign.center,
              style: headerTextStyle.copyWith(
                  fontSize: 10, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
        ],
      ),
    );
  }

  Row _simTypeSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(
          width: 50,
        ),
        Obx(
          () => OptionsSelector(
              outerBorderRadius: 8,
              fontSizeFactor: 0.7,
              optionsRadius: 8,
              optionsConstraints: BoxConstraints(minWidth: 25.w),
              paddingFactor: 0.4,
              selectedOption: homePageController.selectedSimType.value,
              optionsBGColor: const Color(0xff1B1B1D),
              selectedTabcolor: Colors.black,
              options: homePageController.availableSimTypes,
              onChanged: (_) {
                homePageController.selectedSimType(_);
              }),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
          child: Icon(
            Icons.notifications,
            color: Colors.white,
            size: 30,
          ),
        )
      ],
    );
  }
}
