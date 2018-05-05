//
//  AddCourseViewController.swift
//  check
//
//  Created by Nandita Mohan on 4/27/18.
//  Copyright © 2018 Nandita Mohan. All rights reserved.
//

import UIKit

protocol AddCourseSaveButtonDelegate {
    func saveButtonPressed(withName: String)
}

class AddCourseViewController: UIViewController {
    
    var nameLabel: UILabel!
    var nameTextField : UITextField!
    var saveButton: UIBarButtonItem!
    var delegate: AddCourseSaveButtonDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        nameLabel = UILabel()
        nameLabel.text = "Course Name: "
        nameLabel.font = UIFont(name: "KohinoorTelugu-Light", size: 20)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor = UIColor(red: 247/255, green: 60/255, blue: 60/255, alpha: 1.0)
//        nameLabel.backgroundColor = UIColor(red: 255/255, green: 137/255, blue: 0, alpha: 1.0)
        
        let nameTextfieldPadding = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        nameTextField = UITextField()
        nameTextField.layer.cornerRadius = 10
        nameTextField.layer.borderWidth = 1.0
        nameTextField.leftView = nameTextfieldPadding
        nameTextField.leftViewMode = .always
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        saveButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveButtonPressed))
        self.navigationItem.rightBarButtonItem = saveButton
        
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        setupConstraints()

        // Do any additional setup after loading the view.
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32 ),
            nameLabel.widthAnchor.constraint(equalToConstant:nameLabel.intrinsicContentSize.width)
            ])
        
        NSLayoutConstraint.activate([
            nameTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 16),
            nameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            nameTextField.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            nameTextField.heightAnchor.constraint(equalToConstant: 32)])
        
    }
    
    
    @objc func saveButtonPressed(sender: UIBarButtonItem){
        
        if let name = nameTextField.text {
            Network.postCourse(withName: name, withCategory: "default")
            delegate?.saveButtonPressed(withName: name)
            navigationController?.popViewController(animated: true)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    


}
