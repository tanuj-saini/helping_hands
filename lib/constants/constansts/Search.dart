import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:helping_hands/constants/constansts/LoderScreen.dart';
import 'package:helping_hands/consumer/ProdunctListPurchase.dart';
import 'package:helping_hands/users/authContoller.dart';

class SearchUserTweet extends SearchDelegate {
  final WidgetRef ref;
  final String OrderId;

  SearchUserTweet({required this.OrderId, required this.ref});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ref.watch(listOfUsers(query)).when(
        data: (userModel) {
          // return ref.watch(getUserTweetForProfile(community)).when(data: (data){
          //   final TweetModel tweetModel=data[index];
          return ListView.builder(
            itemCount: userModel.length,
            itemBuilder: (context, index) {
              final community = userModel[index];
              return ProductDetailsPurchase(orderModule: community);
            },
          );
          // error: (e,trace){print(e.toString()) ;return showSnackBar(e.toString(), context);}, loading: ()=>LoderScreen());

          // },
        },
        error: (e, trace) {
          print(e.toString());
          return Text('');
          //showSnackBar(e.toString(), context);
        },
        loading: () => LoderScreen());
  }
}
