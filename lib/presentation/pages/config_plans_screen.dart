import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:zetexa_assignment/domain/entity/config_plan_entities/config_plans_entity.dart';
import 'package:zetexa_assignment/domain/entity/config_plan_entities/pack_entity.dart';
import 'package:zetexa_assignment/presentation/controllers/config_plans_controller.dart';
import 'package:zetexa_assignment/presentation/general/extension.dart';
import 'package:zetexa_assignment/presentation/general/images.dart';
import 'package:zetexa_assignment/presentation/general/toast.dart';
import 'package:zetexa_assignment/presentation/widgets/options_selector.dart';
import 'package:zetexa_assignment/presentation/widgets/slider_widget.dart';

class ConfigPlansScreen extends StatelessWidget {
  ConfigPlansScreen({
    super.key,
  });

  final ConfigPlansController controller = Get.put(ConfigPlansController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff0ecec),
        appBar: _buildAppBar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: [
              _buildPlanCategory(),
              _buildPlanCustomization(),
              _eSimPlanTypeSelector(),
              ...controller.eSimPackageList
                  .map((package) => _buildPlansList(package))
                  .toList(),
            ],
          ),
        ));
  }

  Container _buildPlanCustomization() {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 12, 0, 10),
      padding: const EdgeInsets.fromLTRB(12, 16, 12, 0),
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(
            color: Color.fromARGB(255, 221, 221, 221),
            blurRadius: 3,
            spreadRadius: 0.3)
      ], color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 12, bottom: 10),
            child: Text(
              'Customize Your Plan',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w500),
            ),
          ),
          ...controller.eSimPlansList.map((plan) => _buildQuotaList(plan))
        ],
      ),
    );
  }

  Widget _buildPlansList(ESIMPackage package) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 65.w),
                    child: Text(
                      package.title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Text(
                    'Plan expires on ${package.expiresOn.format(format: 'MMM dd, yyyy hh:mm a')}',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Image.asset(
                LocalImages().sim,
                width: 13.w,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 26),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: package.inclusions
                    .map((inclusion) => _buildPlanItems(
                        '${inclusion.quota} ${inclusion.units}',
                        inclusion.quotaType))
                    .toList()),
          ),
          InkWell(
              onTap: () => customTextToast('Brought ${package.title}'),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(197, 255, 255, 255)),
                    borderRadius: BorderRadius.circular(2)),
                padding: const EdgeInsets.all(12),
                child: Text(
                  'Buy now - \$${package.price}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600),
                ),
              ))
        ],
      ),
    );
  }

  SizedBox _buildDivider() {
    return const SizedBox(
      height: 30,
      child: VerticalDivider(
        color: Colors.grey,
      ),
    );
  }

  Column _buildPlanItems(String title, String subTitle) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
        ),
        Text(
          subTitle,
          style: const TextStyle(
              color: Colors.white, fontSize: 9, fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  Widget _eSimPlanTypeSelector() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 6, 0, 16),
      child: Obx(
        () => OptionsSelector(
            fitToWidth: true,
            outerBorderRadius: 4,
            optionsRadius: 4,
            fontSizeFactor: 0.78,
            optionsConstraints: BoxConstraints(minWidth: 25.w),
            unselectedOptionTextColor: Colors.black,
            selectedOption: controller.selectedDataType.value,
            optionsBGColor: Colors.white,
            selectedTabcolor: Colors.black,
            options: controller.dataTypes,
            onChanged: (_) {
              controller.selectedDataType(_);
            }),
      ),
    );
  }

  Widget _buildQuotaList(ESimPlan plan) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, bottom: 4),
          child: Text(
            plan.type,
            style: const TextStyle(
                color: Colors.black, fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: plan.quota
                .map((quota) => Text(
                      quota,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 91, 91, 91),
                          fontSize: 9,
                          fontWeight: FontWeight.w500),
                    ))
                .toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SliderWidget(divisions: 4, onSlide: (_) {}),
        )
      ],
    );
  }

  Widget _buildPlanCategory() {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: controller.planTypes
            .map((plan) => GestureDetector(
                  onTap: () {
                    controller.selectedPlanType(plan);
                  },
                  child: Container(
                    constraints: const BoxConstraints(minWidth: 80),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: plan == controller.selectedPlanType.value
                          ? Colors.black
                          : const Color(0xffE0E0E0),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      plan,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: plan == controller.selectedPlanType.value
                              ? Colors.white
                              : Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xff111111),
      title: Text(
        controller.region,
        style: const TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }
}
