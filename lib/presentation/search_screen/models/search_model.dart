import '../../../core/app_export.dart';
import 'contact_item_model.dart';
import 'recentsearches_item_model.dart';

/// This class defines the variables used in the [search_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class SearchModel {
  Rx<List<RecentsearchesItemModel>> recentsearchesItemList = Rx([
    RecentsearchesItemModel(
        kevinAllsrub: ImageConstant.imgEllipse5.obs,
        kevinAllsrub1: "Kevin Allsrub".obs,
        yourEFriendsOn: "Your’e friends on twitter".obs),
    RecentsearchesItemModel(
        kevinAllsrub: ImageConstant.imgEllipse6.obs,
        kevinAllsrub1: "Sarah Owen".obs,
        yourEFriendsOn: "Your’e friends on twitter".obs),
    RecentsearchesItemModel(
        kevinAllsrub: ImageConstant.imgEllipse7.obs,
        kevinAllsrub1: "Rick Onad".obs,
        yourEFriendsOn: "Your’e friends on twitter".obs),
    RecentsearchesItemModel(
        kevinAllsrub: ImageConstant.imgEllipse8.obs,
        kevinAllsrub1: "Steven Ford".obs,
        yourEFriendsOn: "Your’e friends on twitter".obs),
    RecentsearchesItemModel(
        kevinAllsrub: ImageConstant.imgEllipse9.obs,
        kevinAllsrub1: "Lucas Anna ".obs,
        yourEFriendsOn: "Your’e friends on twitter".obs),
    RecentsearchesItemModel(
        kevinAllsrub: ImageConstant.imgEllipse10.obs,
        kevinAllsrub1: "Nabila Remaar".obs,
        yourEFriendsOn: "Your’e friends on twitter".obs),
    RecentsearchesItemModel(
        kevinAllsrub: ImageConstant.imgEllipse11.obs,
        kevinAllsrub1: "Rosalia".obs,
        yourEFriendsOn: "Your’e friends on twitter".obs)
  ]);

  List<ContactItemModel> contactList = ([
    ContactItemModel(
        kevinAllsrub: ImageConstant.imgEllipse5,
        kevinAllsrub1: "Kevin Allsrub",
        yourEFriendsOn: "Your’e friends on twitter",
        id: 1
    ),

    ContactItemModel(
        kevinAllsrub: ImageConstant.imgEllipse6,
        kevinAllsrub1: "Sarah Owen",
        yourEFriendsOn: "Your’e friends on twitter",
        id: 2
    ),
    ContactItemModel(
        kevinAllsrub: ImageConstant.imgEllipse7,
        kevinAllsrub1: "Rick Onad",
        yourEFriendsOn: "Your’e friends on twitter",
        id: 3
    ),
    ContactItemModel(
        kevinAllsrub: ImageConstant.imgEllipse8,
        kevinAllsrub1: "Steven Ford",
        yourEFriendsOn: "Your’e friends on twitter",
        id: 4
    ),
    ContactItemModel(
        kevinAllsrub: ImageConstant.imgEllipse9,
        kevinAllsrub1: "Lucas Anna ",
        yourEFriendsOn: "Your’e friends on twitter",
        id: 5
        ),
    ContactItemModel(
        kevinAllsrub: ImageConstant.imgEllipse10,
        kevinAllsrub1: "Nabila Remaar",
        yourEFriendsOn: "Your’e friends on twitter",
         id: 6
        ),
    ContactItemModel(
        kevinAllsrub: ImageConstant.imgEllipse11,
        kevinAllsrub1: "Rosalia",
        yourEFriendsOn: "Your’e friends on twitter",
      id: 7
        )
  ]);
}
