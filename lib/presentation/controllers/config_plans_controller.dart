import 'package:get/get.dart';
import 'package:zetexa_assignment/domain/entity/config_plan_entities/config_plans_entity.dart';
import 'package:zetexa_assignment/domain/entity/config_plan_entities/incluions_entity.dart';
import 'package:zetexa_assignment/domain/entity/config_plan_entities/pack_entity.dart';

class ConfigPlansController extends GetxController {
  String region = '';
  List<String> planTypes = ['Popular', 'Family', 'Business', 'Student'],
      dataTypes = ['Data', 'Data / Voice / SMS'];
  RxString selectedPlanType = ''.obs, selectedDataType = ''.obs;
  List<ESimPlan> eSimPlansList = [];
  List<ESIMPackage> eSimPackageList = [];

  @override
  void onInit() async {
    region = Get.arguments ?? 'India';
    selectedDataType(dataTypes[0]);
    selectedPlanType(planTypes[0]);
    setESimPlansList();
    setESimPackageList();
    super.onInit();
  }

  setESimPackageList() {
    eSimPackageList.addAll([
      ESIMPackage(
          title: '$region Explorer Pack',
          expiresOn: DateTime.now()
              .add(const Duration(days: 30, hours: 3, minutes: 10)),
          inclusions: [
            const Inclusion(quota: 3, units: 'GB', quotaType: 'Data'),
            const Inclusion(
                quota: 1000, units: 'mins', quotaType: 'Voice Call'),
            const Inclusion(quota: 100, units: 'SMS', quotaType: 'SMS')
          ],
          price: 16),
      ESIMPackage(
          title: '$region Starter Pack',
          expiresOn: DateTime.now().add(const Duration(days: 5, minutes: 16)),
          inclusions: [
            const Inclusion(quota: 2, units: 'GB', quotaType: 'Data'),
            const Inclusion(quota: 800, units: 'mins', quotaType: 'Voice Call'),
            const Inclusion(quota: 100, units: 'SMS', quotaType: 'SMS')
          ],
          price: 14),
      ESIMPackage(
          title: '$region Basic Pack',
          expiresOn: DateTime.now().add(const Duration(days: 100, hours: 10)),
          inclusions: [
            const Inclusion(quota: 5, units: 'GB', quotaType: 'Data'),
            const Inclusion(
                quota: 1500, units: 'mins', quotaType: 'Voice Call'),
            const Inclusion(quota: 100, units: 'SMS', quotaType: 'SMS')
          ],
          price: 20)
    ]);
  }

  setESimPlansList() {
    eSimPlansList.addAll([
      ESimPlan(
        type: 'Data',
        quota: ['1 GB', '3 GB', '5 GB ', '10 GB', '20 GB'],
      ),
      ESimPlan(
        type: 'Voice',
        quota: ['50 mins', '75 mins', '100 mins', '125 mins', '150 mins'],
      ),
      ESimPlan(
        type: 'SMS',
        quota: ['25 sms', '50 sms', '75 sms ', '100 sms', '150 sms'],
      ),
      ESimPlan(
        type: 'Validity',
        quota: ['7 Days', '15 Days', '21 Days ', '28 Days', '31 Days'],
      ),
    ]);
  }
}
