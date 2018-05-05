//
//  ViewController.swift
//  check
//
//  Created by Nandita Mohan on 4/27/18.
//  Copyright © 2018 Nandita Mohan. All rights reserved.
//

import UIKit


class CourseViewController: UIViewController, AddCourseSaveButtonDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    var courseList : [Course] = []
    var courseCollectionView : UICollectionView!
    let courseCellReuseIdentifier = "courseCell"
    var addButton: UIBarButtonItem!
    var bookButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My Course List"
        view.backgroundColor = .white

        
        
        let courseLayout = UICollectionViewFlowLayout()
        courseCollectionView = UICollectionView(frame: view.frame, collectionViewLayout : courseLayout)
        courseCollectionView.dataSource = self
        courseCollectionView.delegate = self
        courseCollectionView.backgroundColor = .white
        
        courseCollectionView.register(CourseCollectionViewCell1.self, forCellWithReuseIdentifier: courseCellReuseIdentifier)
        courseCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        addButton = UIBarButtonItem(title: "Add Course", style: .done, target: self, action: #selector(addCourseButtonPressed))
        self.navigationItem.rightBarButtonItem = addButton
        
        bookButton = UIButton(type: UIButtonType.roundedRect) as UIButton
        bookButton.setTitle("Search Ebooks", for: .normal)
        bookButton.titleLabel?.font = UIFont(name: "KohinoorTelugu-Light", size: 20)
        bookButton.addTarget(self, action: #selector(bookButtonPressed), for: .touchUpInside)
        bookButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(courseCollectionView)
        view.addSubview(bookButton)
        setupConstraints()
        Network.getAllCourses { (courseArray) in
            self.courseList = courseArray
            self.courseCollectionView.reloadData()
        }
        
        
    }
    
    func setupConstraints(){
        
        NSLayoutConstraint.activate([
            bookButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            bookButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
            ])

        NSLayoutConstraint.activate([
            courseCollectionView.topAnchor.constraint(equalTo: bookButton.bottomAnchor, constant: 10),
            courseCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            courseCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -70),
            courseCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20),
            courseCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
    
    @objc func bookButtonPressed(sender: UIButton){
        let booksVC = BookSearchViewController()
        navigationController?.pushViewController(booksVC, animated: true)
    }
    
    @objc func addCourseButtonPressed(sender: UIBarButtonItem){
        let addCourseVC = AddCourseViewController()
        addCourseVC.delegate = self
        navigationController?.pushViewController(addCourseVC, animated: true)
    }
    
    func saveButtonPressed(withName: String) {
        let course = Course(name: withName)
        courseList.append(course)
        courseCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let todoVC = TodoViewController(course: courseList[indexPath.item])
        navigationController?.pushViewController(todoVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: courseCellReuseIdentifier, for: indexPath) as! CourseCollectionViewCell1
        let course = courseList[indexPath.item]
        cell.nameLabel.text = course.name
        cell.backgroundColor = UIColor(red: 255/255, green: 137/255, blue: 0, alpha: 1.0)
        
        cell.contentView.layer.cornerRadius = 4.0
//        cell.contentView.layer.borderWidth = 1.0
//        cell.contentView.layer.borderColor = UIColor.black.cgColor
        cell.contentView.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cell.layer.shadowRadius = 4.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        cell.layer.masksToBounds = true
        cell.setNeedsUpdateConstraints()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return courseList.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width-10)/2.25
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
    
}
