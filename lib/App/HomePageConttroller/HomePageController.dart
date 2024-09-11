
import 'package:get/get_state_manager/get_state_manager.dart';

class HomePageController extends GetxController{

  int totalResult=0;


  void updateResult(int result){
    totalResult=result;
    update();
  }

}