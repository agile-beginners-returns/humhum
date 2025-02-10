import 'package:clay_containers/clay_containers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryScreen extends StatefulWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  /// コンストラクタで FirebaseAuth と FirebaseFirestore を受け取ることで DI を実現する。
  /// 引数 [auth] や [firestore] に値が渡されなかった場合は、デフォルトでそれぞれのインスタンスを使用する。
  HistoryScreen({
    super.key,
    FirebaseAuth? auth,
    FirebaseFirestore? firestore,
  })  : auth = auth ?? FirebaseAuth.instance,
        firestore = firestore ?? FirebaseFirestore.instance;

  @override
  HistoryScreenState createState() => HistoryScreenState();
}

class HistoryScreenState extends State<HistoryScreen> {
  // テスト結果を保持するリスト
  List<Map<String, dynamic>> testResults = [];
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    _fetchTestResults(_selectedDay);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('学習履歴', style: TextStyle(color: Colors.black)),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 4,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // カレンダー部分
              ClayContainer(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: 20,
                child: TableCalendar(
                  firstDay: DateTime.utc(2010, 1, 1),
                  lastDay: DateTime.utc(2030, 1, 1),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                    displayScores(selectedDay);
                  },
                  calendarBuilders: CalendarBuilders(
                    selectedBuilder: (context, date, events) {
                      return Container(
                        margin: const EdgeInsets.all(4.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          date.day.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    },
                    todayBuilder: (context, date, events) {
                      return Container(
                        margin: const EdgeInsets.all(4.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.orange[200],
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          date.day.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    },
                  ),
                  headerStyle: const HeaderStyle(
                    formatButtonTextStyle:
                        TextStyle(color: Colors.orange, fontSize: 16.0),
                    leftChevronIcon:
                        Icon(Icons.chevron_left, color: Colors.orange),
                    rightChevronIcon:
                        Icon(Icons.chevron_right, color: Colors.orange),
                    titleCentered: true,
                    formatButtonShowsNext: false,
                  ),
                ),
              ),
              const SizedBox(height: 13.0),
              // テスト結果表示部分
              Expanded(
                child: ListView.builder(
                  itemCount: testResults.length,
                  itemBuilder: (context, index) {
                    final result = testResults[index];
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ClayContainer(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: 10,
                        child: ListTile(
                          title: Text(result['exam_date_string'] ?? ''),
                          subtitle: Text(
                              '正解率: ${result['correct_answer_rate'] ?? 'N/A'}'),
                          trailing: Text('Rank ${result['rank'] ?? 'N/A'}'),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 日付が選択されたときに Firestore からデータを取得し、testResults を更新する
  void displayScores(DateTime selectedDay) async {
    final selectedDateString =
        "${selectedDay.year}-${selectedDay.month.toString().padLeft(2, '0')}-${selectedDay.day.toString().padLeft(2, '0')}";
    print(selectedDateString);

    try {
      final querySnapshot = await widget.firestore
          .collection('test_results')
          .where('user_id', isEqualTo: widget.auth.currentUser!.uid.toString())
          .where('exam_date_string', isEqualTo: selectedDateString)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final results = querySnapshot.docs.map((doc) => doc.data()).toList();
        print('Results: $results');
        setState(() {
          testResults = results;
        });
      } else {
        print('No results found');
        setState(() {
          testResults = [];
        });
      }
    } catch (e) {
      print('Error fetching test results: $e');
    }
  }

  // 画面初期化時に Firestore からデータを取得する
  Future<void> _fetchTestResults(DateTime selectedDay) async {
    final selectedDateString =
        "${selectedDay.year}-${selectedDay.month.toString().padLeft(2, '0')}-${selectedDay.day.toString().padLeft(2, '0')}";

    try {
      final querySnapshot = await widget.firestore
          .collection('test_results')
          .where('user_id', isEqualTo: widget.auth.currentUser!.uid.toString())
          .where('exam_date_string', isEqualTo: selectedDateString)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final results = querySnapshot.docs.map((doc) => doc.data()).toList();
        print('Results: $results');
        setState(() {
          testResults = results;
        });
      } else {
        print('No results found');
      }
    } catch (e) {
      print('Error fetching test results: $e');
    }
  }
}
