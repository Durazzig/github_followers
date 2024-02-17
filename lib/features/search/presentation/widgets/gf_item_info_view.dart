import 'package:flutter/material.dart';
import 'package:github_followers/features/search/presentation/widgets/gf_item_info.dart';
import 'package:github_followers/ui/gf_button.dart';

class GFItemInfoView extends StatelessWidget {
  const GFItemInfoView({
    Key? key,
    required this.buttonTitle,
    required this.buttonColor,
    required this.type1,
    required this.type2,
    required this.type1Count,
    required this.type2Count,
    required this.onButtonTapped,
  }) : super(key: key);
  final String buttonTitle;
  final Color buttonColor;
  final ItemInfoType type1;
  final ItemInfoType type2;
  final int type1Count;
  final int type2Count;
  final VoidCallback onButtonTapped;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GFItemInfo(
                  type: type1,
                  count: type1Count,
                ),
                GFItemInfo(
                  type: type2,
                  count: type2Count,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: GFButton(
                    title: buttonTitle,
                    height: 36,
                    color: buttonColor,
                    onPressed: onButtonTapped,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:github_followers/features/search/domain/user_model.dart';
// import 'package:github_followers/features/search/presentation/widgets/gf_item_info.dart';

// class GFItemInfoView extends StatelessWidget {
//   GFItemInfoView({
//     super.key,
//     required this.user,
//   });
//   final User user;
//   late String buttonTitle;
//   late ItemInfoType type1;
//   late ItemInfoType type2;
//   late int type1Count;
//   late int type2Count;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color: Theme.of(context).colorScheme.secondary,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 GFItemInfo(
//                   type: type1,
//                   count: type1Count,
//                 ),
//                 GFItemInfo(
//                   type: type2,
//                   count: type2Count,
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {},
//                     child: Text(buttonTitle),
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

