import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/core/utils/app_style.dart';
import 'package:todo_app/core/utils/colors_manager.dart';

class TaskItem extends StatelessWidget {
   TaskItem({super.key,required this.todo, required this.onDeletedTask});

   TodoDM todo;
   VoidCallback onDeletedTask;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: REdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).colorScheme.onPrimary),
      child: Slidable(
        startActionPane: ActionPane(motion: DrawerMotion(), children: [
          SlidableAction(flex: 2,
            onPressed: (context) {
            deleteTodo(todo);
            onDeletedTask();
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
            autoClose: true,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), topLeft: Radius.circular(15)),),
          SlidableAction(flex: 2,
            onPressed: (context) {
            print('Clicked');
            },
            backgroundColor: ColorsManger.blue,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
            autoClose: true,),
        ]),
        child: Container(
          padding: REdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Container(
              height: 62.h,
              width: 4.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).primaryColor),
            ),
              SizedBox(width: 7.h,),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(todo.title, style: ApplightStyles.tasksTitle),
                  SizedBox(height: 4.h,),
                  Text(todo.description, style: ApplightStyles.taskDesc),
                  SizedBox(height: 4.h,),
              ],
            ),
              Spacer(),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 3.h),
                  decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(10),),
                child: Icon(Icons.check, color: Colors.white, size: 30,))
          ],
        ),
      ),
    ),
    );
  }

  void deleteTodo(TodoDM todo) async {
    CollectionReference todoCollection = FirebaseFirestore.instance
        .collection(UserDM.collectionName)
        .doc(UserDM.currentUser!.id)
        .collection(TodoDM.collectionName);
    DocumentReference task = todoCollection.doc(todo.id);
    await task.delete();
  }
}