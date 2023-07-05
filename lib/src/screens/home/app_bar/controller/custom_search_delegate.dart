// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';

// class CustomSearchDelegate extends SearchDelegate {
//   // first overwrite to
//   // clear the search text
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//         onPressed: () {
//           query = '';
//         },
//         icon: const Icon(Icons.clear),
//       ),
//     ];
//   }
//   // second overwrite to pop out of search menu

//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//       onPressed: () {
//         close(context, null);
//       },
//       icon: const Icon(Icons.arrow_back),
//     );
//   }

// // third overwrite to show query result
//   @override
//   Widget buildResults(BuildContext context) {
//     List<Product> matchQuery = [];
//     return Consumer(builder: (_, WidgetRef ref, __) {
//       final proucts = ref.watch(productsListFutureProvider);
//       return AsyncValueWidget<List<Product>>(
//           value: proucts,
//           data: (productsList) {
//             final products = productsList.where(
//               (product) =>
//                   product.title.toLowerCase().contains(query.toLowerCase()),
//             );
//             matchQuery.addAll(products);
//             if (matchQuery.isNotEmpty) {
//               return ListView.builder(
//                   itemCount: matchQuery.length,
//                   itemBuilder: (context, index) {
//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         if (index == 0)
//                           const Padding(
//                             padding: EdgeInsets.symmetric(
//                                 vertical: 15, horizontal: 8),
//                             child: Text(
//                               'Search Results',
//                               style: TextStyle(fontWeight: FontWeight.w800),
//                             ),
//                           ),
//                         SearchResults(
//                           product: matchQuery[index],
//                         ),
//                       ],
//                     );
//                   });
//             } else {
//               return Center(
//                 child: Center(
//                   child: Text(
//                     'No results for $query',
//                     style: Theme.of(context).textTheme.headlineMedium,
//                   ),
//                 ),
//               );
//             }
//           });
//     });
//   }

// // last overwrite to show the
//   // querying process at the runtime
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     List<Product> matchQuery = [];
//     return Consumer(
//       builder: (_, WidgetRef ref, __) {
//         final products = ref.watch(productsListFutureProvider);
//         return AsyncValueWidget(
//             value: products,
//             data: (productsList) {
//               final products = productsList.where(
//                 (product) =>
//                     product.title.toLowerCase().contains(query.toLowerCase()) &&
//                     query.isNotEmpty,
//               );
//               matchQuery.addAll(products);
//               return ListView.builder(
//                   itemCount: matchQuery.length,
//                   itemBuilder: (context, index) {
//                     final product = matchQuery[index];
//                     return ListBody(
//                       children: [
//                         InkWell(
//                           onTap: () => context.goNamed(
//                             AppRoute.product.name,
//                             params: {'id': product.id},
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Row(
//                                 children: [
//                                   Image.asset(
//                                     product.imageUrl,
//                                     width: 70,
//                                     height: 70,
//                                   ),
//                                   const SizedBox(width: 10),
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(product.title),
//                                       const SizedBox(height: 10),
//                                       Text('${product.price} \$')
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                               const Padding(
//                                 padding: EdgeInsets.symmetric(horizontal: 15),
//                                 child: Icon(Icons.open_in_new),
//                               )
//                             ],
//                           ),
//                         ),
//                         const Divider(),
//                       ],
//                     );
//                   });
//             });
//       },
//     );
//   }
// }
