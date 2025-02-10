import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:clay_containers/clay_containers.dart';

class LevelBar extends StatefulWidget {
  const LevelBar({super.key});

  @override
  State<LevelBar> createState() => _LevelBarState();
}

class _LevelBarState extends State<LevelBar> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<(int, int)>(
      future: getLevelAndExp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LinearProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text('エラーが発生しました');
        }
        var (level, exp) = snapshot.data!;
        return Row(
          children: [
            Text(
              'Lv. ${level.toString()}',
              style: const TextStyle(fontSize: 20, color: Colors.grey),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ClayContainer(
                emboss: true,
                borderRadius: 5,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  child: LinearProgressIndicator(
                    value: exp / 100,
                    backgroundColor: Colors.grey.withOpacity(0.3),
                    color: Colors.orange,
                    minHeight: 10,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<(int, int)> getLevelAndExp() async {
    // ランク情報を取得する関数
    final rankList = await getRank();

    // ランク情報から現在の経験値とレベルを計算
    return calcExpAndLevel(rankList);
  }

  Future<List> getRank() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final firestore = FirebaseFirestore.instance;
    var rankList = [];

    try {
      final querySnapshot = await firestore
          .collection('test_results')
          .where('user_id', isEqualTo: currentUser!.uid.toString())
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        rankList =
            querySnapshot.docs.map((doc) => doc['rank'].toString()).toList();
      } else {
        rankList = [];
      }
    } catch (e) {
      print('Firebase get error: $e');
    }

    return rankList;
  }

  (int, int) calcExpAndLevel(List rankList) {
    // ランク情報から経験値を計算
    final expList = rankList.map((rank) {
      switch (rank) {
        case 'S':
          return 50;
        case 'A':
          return 40;
        case 'B':
          return 30;
        case 'C':
          return 20;
        case 'D':
          return 10;
        default:
          return 0;
      }
    }).toList();

    // 経験値の合計を計算
    final totalExp = expList.fold(0, (prev, exp) => prev + exp);

    // レベルを計算
    final level = totalExp ~/ 100;

    // レベルアップまでの経験値を計算
    final expRemain = totalExp % 100;

    return (level, expRemain);
  }
}
