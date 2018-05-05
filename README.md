# check
HackDev Project

* App Name: CHECK
* App Tagline: The easiest way to manage your school tasks.

* Team Members: Nandita Mohan (nkm39), Garima Kapila (gk347), Sahithi Kalvakota (sk2679), Riddhima Narravula (rrn23)

* Link(s) to public repos: 
for iOS: https://github.com/sahithi-kal/check
For Backend: https://github.com/gkapila/Check-Backend

* README with Screenshots: https://docs.google.com/document/d/1nRp9endIqOQejEdbDlT23pqAxqlDZzgwGucwGXO5aWY/edit?usp=sharing

Description: 
Check is an iPhone app that allows users to organize & prioritize their school TODOs. When a user enters the app, they will be able to input their courses for the semester. These courses get added to the ‘My Course List’ screen, where each course is organized and can be modified. Once a course that is inputted is tapped on, there is a TODO screen that pops up, where one can view all the required tasks they have to finish for the course. 

Each task, when added, includes a title, description, and deadline (or when the user wants to finish it by). Once saved, the task gets added to the TODO list on the previous screen. When a list item is complete, the user can “swipe left” on the task to check it off their list! 

An additional feature we have is the ability to search for audiobooks & ebooks, for which we use the iTunes API. The user can search whether the ebooks they need are available, and clicking on the title takes them to the iTunes info page. 


Requirements:
IOS Requirements- 
- We use Autolayout for all our ViewControllers, UITableViewCells, UICollectionView and UICollectionView Cells.
- We use CollectionView on our CourseViewController to display all the courses the the user has saved. We also use a CollectionView to display all the tasks a user has in a class in each todoViewConttroller. In our BookSearchViewController, we use a UITableView to display the result of the book search.
- We use a NavigationController to navigate through the different screens in a our app.
- We use the iTunes API to integrate an eBook Search into our app. This allows users to search for books they may need for their courses.

Backend Requirements (see Backend README for more information)-
- We designed an API according to the information and methods that the iOS client needed and implemented it using the Flask Boilerplate provided to us. 
- We have two different tables in our database: a Course table and a Task table. Our courses (as you can see in our models folder) have two fields: name and category. Our tasks (also in models folder) have four fields: name, description, due_date, and course_name (which corresponds to our course names in the course table). 
- In the backend repository’s README, you can see all of the methods that we implemented (and are being used by the frontend) and example outputs for each. 
- The backend is fully deployed using Docker and Google Cloud Services.

Additional Info for Grader: 
- We have not used all the backend methods in our app front-end. This is because we have not implemented features like delete & edits for some items (like courses) due to the timeline of this project. However, we did use GET and POST requests to keep courses & tasks updated in our app. 
