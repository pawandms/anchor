import 'package:anchor_getx/core/app_export.dart';
import 'package:anchor_getx/presentation/auth_screen/models/auth_model.dart';

/// A controller class for the LoginScreen.
///
/// This class manages the state of the LoginScreen, including the
/// current loginModelObj
class AuthController extends GetxController {
  Rx<AuthModel> loginModelObj = AuthModel().obs;
}
