
class AppConfig{
  AppConfig._privateConstructor();
  static final AppConfig instance = AppConfig._privateConstructor();
  bool enableMsgSound = false;

  void toggleMessageSound()
  {
    if(enableMsgSound)
     {
       enableMsgSound = false;
     }
    else {
      enableMsgSound = true;
    }
  }
}