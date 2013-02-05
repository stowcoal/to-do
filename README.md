to-do
=====

to-do list application for the iPhone

This is a to-do list application for the iPhone 6.0.  It allows the user to add tasks, delete tasks,
and check tasks off.  Also, the task list is saved, with the task status (checked off or not) so that
the user can close and open the application without losing data.  

Implementation
=====
I implemented this using as much of the out of the box software that I possibly could. All of the adding
and deleting functionality came natural, and required no additional work.

I created a new class, the todoTask class, which contained two NSString elements, one for taskName, and one
for taskChecked.  taskChecked was stored as either 'yes' or 'no' and taskName could be any string.  

My NSMutableArray _objects contains a list of these todoTasks.  When the cells are printed, it checks
each if checked == 'yes'.  If so, it changes the formatting of the cell.  When a cell is clicked, it changes
the clicked status and reloads the list.  

When the app closes it reads each object in _objects, and write first the taskName and then checked to a new 
array of NSStrings.  This array is then written to a file.  When the app opens, this file is read, two items at
a time, and a new todoTask and _objects array is generated and then the tableView is reloaded.
