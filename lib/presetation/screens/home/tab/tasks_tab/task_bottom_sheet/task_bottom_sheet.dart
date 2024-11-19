import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/utils/app_style.dart';
import 'package:todo_app/core/utils/date_utils.dart';
class TaskBottomSheet extends StatefulWidget {
  TaskBottomSheet({super.key});

  @override
  State<TaskBottomSheet> createState() => _TaskBottomSheetState();

  static Future show(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: TaskBottomSheet(),
          );
        });
  }
}

class _TaskBottomSheetState extends State<TaskBottomSheet> {
  DateTime selectedDate = DateTime.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      padding: REdgeInsets.all(12),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Add new task',
              textAlign: TextAlign.center,
              style: ApplightStyles.bottomSheetTitle,
            ),
            SizedBox(height: 8.h,),
            TextFormField(
              validator: (input) {
                if (input == null || input.trim().isEmpty) {
                  return 'Plz, enter task title';
                }
                return null;
              },
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'Enter your task title',
                hintStyle: ApplightStyles.hintStyle,
              ),
            ),
            SizedBox(height: 8.h,),
            TextFormField(
              validator: (input) {
                if (input == null || input.trim().isEmpty) {
                  return 'Plz, enter task description';
                }
                if (input.length < 6) {
                  return 'Sorry, description should be at least 6 characters';
                }
                return null;
              },
              controller: descriptionController,
              decoration: InputDecoration(
                  hintText: 'Enter your task description',
                  hintStyle: ApplightStyles.hintStyle),
            ),
            SizedBox(height: 12.h,),
            Text('Select date',
              style:ApplightStyles.dateLabel,
            ),
            SizedBox(height: 8.h,),
            InkWell(
                onTap: () {
                  showTaskDatePicker();
                },
                child: Text(
                  selectedDate.toFormattedDate,
                  textAlign: TextAlign.center,
                  style: ApplightStyles.dateStyle,
                )),
            const Spacer(),
            ElevatedButton(
                onPressed: () {
                  addTodoToFireStore();
                },
                child: Text('Add task'))
          ],
        ),
      ),
    );
  }

  void showTaskDatePicker() async {
    selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    ) ??
        selectedDate;

    setState(() {});
  }

  void addTodoToFireStore() {
    if (formKey.currentState?.validate() == false) return;
    var db = FirebaseFirestore.instance;
    CollectionReference collectionReference = db
        .collection(UserDM.collectionName)
        .doc(UserDM.currentUser!.id)
        .collection(TodoDM.collectionName);
    DocumentReference newDoc =
    collectionReference.doc(); 

    TodoDM todo = TodoDM(
        id: newDoc.id,
        title: titleController.text,
        description: descriptionController.text,
        dateTime: selectedDate.copyWith(
          second: 0,
          millisecond: 0,
          minute: 0,
          microsecond: 0,
          hour: 0,
        ),
        isDone: false);
    newDoc.set(todo.toFireStore()).then(
          (_) {
        print('Success');
        Navigator.pop(context);
      },
    ).onError(
          (error, stackTrace) {
        print('Error occurred');
      },
    ).timeout(
      const Duration(seconds: 4),
      onTimeout: () {
        if (mounted) {
          Navigator.pop(context);
        }
      },
    ); // stuck
  }
}