import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CryptoShimmer extends StatelessWidget {
  int count = 7;
  CryptoShimmer({Key? key,this.count = 7}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 80,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade500,
        highlightColor: Colors.white,
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: count,
          itemBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 7),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                      color: Theme.of(context).highlightColor,
                      borderRadius:
                      BorderRadius.circular(10)
                  ),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 50,
                            height: 50,
                            child: CircleAvatar(
                              child: Icon(Icons.add),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets
                                .symmetric(
                                horizontal: 10),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                              children: [
                                SizedBox(
                                  width: 50,
                                  height: 12,
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius
                                              .circular(
                                              2),
                                          color: Colors
                                              .white)),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  width: 30,
                                  height: 11,
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius
                                              .circular(
                                              2),
                                          color: Colors
                                              .white)),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(
                            horizontal: 10),
                        child: SizedBox(
                          width: 70,
                          height: 30,
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius
                                      .circular(2),
                                  color: Colors.white)),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(
                            horizontal: 10),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 60,
                              height: 12,
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius
                                          .circular(
                                          2),
                                      color:
                                      Colors.white)),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: 40,
                              height: 11,
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius
                                          .circular(
                                          2),
                                      color:
                                      Colors.white)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
            );
          },
        ),
      ),
    );
  }
}
