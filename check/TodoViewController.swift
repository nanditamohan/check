//
//  TodoViewController.swift
//  check
//
//  Created by Nandita Mohan on 4/28/18.
//  Copyright © 2018 Nandita Mohan. All rights reserved.
//

import UIKit

class TodoViewController: UIViewController, UICollectionViewDataSource,  UICollectionViewDelegateFlowLayout, AddtodoSaveButtonDelegate{

    

    var todoCollectionView : UICollectionView!
    let todoCellReuseIdentifier = "todoCell"

    var addButton: UIBarButtonItem!    

    var course : Course!
    
    init(course: Course){
        self.course = course
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        title = "My Course TODOs"
        view.backgroundColor = .white
        

        let todoLayout = UICollectionViewFlowLayout()
        todoCollectionView = UICollectionView(frame: view.frame, collectionViewLayout : todoLayout)
        todoCollectionView.dataSource = self
        todoCollectionView.delegate = self
        todoCollectionView.backgroundColor = .white

        todoCollectionView.register(todoCollectionViewCell.self, forCellWithReuseIdentifier: todoCellReuseIdentifier)
        todoCollectionView.translatesAutoresizingMaskIntoConstraints = false

        addButton = UIBarButtonItem(title: "Add TODO", style: .done, target: self, action: #selector(addtodoButtonPressed))
        self.navigationItem.rightBarButtonItem = addButton

        view.addSubview(todoCollectionView)
        setupConstraints()
        
        Network.getTasks(withCourse: self.course.name){ (taskArray) in
            self.course.tasks = taskArray
            self.todoCollectionView.reloadData()
        }

    }


    func setupConstraints(){
        NSLayoutConstraint.activate([
            todoCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            todoCollectionView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            todoCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            todoCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
    


    @objc func addtodoButtonPressed(sender: UIBarButtonItem){
        let addtodoVC = AddtodoViewController(course: self.course)
        addtodoVC.delegate = self
        navigationController?.pushViewController(addtodoVC, animated: true)
    }

    func saveButtonPressed(withName: String, withDescrip: String, withDate: String) {
        let todo = Task(name: withName, description: withDescrip, time: withDate, course_name: self.course.name)
        course.tasks.append(todo)
        todoCollectionView.reloadData()
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: todoCellReuseIdentifier, for: indexPath) as! todoCollectionViewCell
        let todo = course.tasks[indexPath.item]
        cell.nameLabel.text = todo.name
        cell.dateLabel.text = "Due: \(todo.time)"
        
        cell.contentView.layer.cornerRadius = 4.0
        cell.contentView.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cell.layer.shadowRadius = 4.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
        
        cell.setNeedsUpdateConstraints()
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return course.tasks.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width-20, height: 80)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
        course.tasks.remove(at: indexPath.row)
        todoCollectionView.deleteItems(at: [indexPath])
    }

    
    

}

