import 'package:flutter/material.dart';
import 'package:todo_app/core/utils/app_style.dart';
import 'package:todo_app/core/utils/colors_manager.dart';
import 'package:todo_app/core/utils/date_utils.dart';
import 'package:todo_app/presetation/screens/home/tab/tasks_tab/widgets/task_item.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';

class TasksTab extends StatefulWidget {
  const TasksTab({super.key,required});

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  DateTime calenderSelectedDate = DateTime.now();
  List<TodoDM> todosList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readTodosFromFireStore();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
    children: [
      Container(height: 115, color: ColorsManger.blue,),
      buildCalenderTimeLine(),
    ],
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return TaskItem(
                todo: todosList[index],
                onDeletedTask: () {
                  readTodosFromFireStore();
                },
              );
            },
            itemCount: todosList.length,
          ),
        )
      ],
    ); // rendering ui
  }

  void readTodosFromFireStore() async {
    var db = FirebaseFirestore.instance; //todo
    CollectionReference todoCollection = db
        .collection(UserDM.collectionName)
        .doc(UserDM.currentUser!.id)
        .collection(TodoDM.collectionName);
    QuerySnapshot collectionSnapShot = await todoCollection
        .where('dateTime',
        isEqualTo: calenderSelectedDate.copyWith(
          hour: 0,
          microsecond: 0,
          minute: 0,
          millisecond: 0,
          second: 0,
        ))
        .get();
    List<QueryDocumentSnapshot> documents = collectionSnapShot.docs;
    todosList = documents.map(
          (docSnapShot) {
        Map<String, dynamic> json = docSnapShot.data() as Map<String, dynamic>;
        TodoDM todo = TodoDM.fromFireStore(json);
        return todo;
      },
    ).toList();

    setState(() {});
  }


  Widget buildCalenderTimeLine() => EasyInfiniteDateTimeLine(
    firstDate: DateTime.now().subtract(const Duration(days: 365)),
    focusDate: calenderSelectedDate,
    lastDate: DateTime.now().add(const Duration(days: 365)),
    onDateChange: (selectedDate) {},
    itemBuilder: (context, date, isSelected, onTap) {
      return InkWell(
        onTap: () {
          calenderSelectedDate = date;
          readTodosFromFireStore();
        },
        child: Card(
          color: ColorsManger.white,
          elevation: 12,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${date.day}', style: isSelected ? ApplightStyles.calenderSelectedItem : ApplightStyles.calenderUnSelectedItem,),
              Text(date.getDayName, style: isSelected ? ApplightStyles.calenderSelectedItem : ApplightStyles.calenderUnSelectedItem,),
            ],
          ),
        ),
      );
    },
  );
}