//
//  AddtodoViewController.swift
//  check
//
//  Created by Nandita Mohan on 4/28/18.
//  Copyright © 2018 Nandita Mohan. All rights reserved.
//

import UIKit

protocol AddtodoSaveButtonDelegate {
    func saveButtonPressed(withName: String, withDescrip: String, withDate: String)
    
}

class AddtodoViewController: UIViewController {
    
    var course : Course!
    var nameLabel: UILabel!
    var nameTextField : UITextField!
    
    var descriptionLabel: UILabel!
    var descriptionTextView : UITextView!
    
    var dateLabel: UILabel!
    var datePicker : UIDatePicker!
    var selectedDateField: UITextField!
    
    var saveButton: UIBarButtonItem!
    var delegate: AddtodoSaveButtonDelegate?
    
    init(course: Course){
        self.course = course
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        
        nameLabel = UILabel()
        nameLabel.text = "Task: "
        nameLabel.font = UIFont(name: "KohinoorTelugu-Light", size: 25)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor = .purple
        
        let nameTextfieldPadding = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        nameTextField = UITextField()
        nameTextField.layer.cornerRadius = 10
        nameTextField.layer.borderWidth = 1.0
        nameTextField.leftView = nameTextfieldPadding
        nameTextField.leftViewMode = .always
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionLabel = UILabel()
        descriptionLabel.text = "Description: "
        descriptionLabel.font = UIFont(name: "KohinoorTelugu-Light", size: 25)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textColor = .black
        
        descriptionTextView = UITextView()
        descriptionTextView.layer.cornerRadius = 10
        descriptionTextView.backgroundColor = .lightGray
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        
        dateLabel = UILabel()
        dateLabel.text = "Deadline: "
        dateLabel.font = UIFont(name: "KohinoorTelugu-Light", size: 25)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.textColor = .black

        datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        selectedDateField = UITextField()
        selectedDateField.text = "Click to Select Date"
        selectedDateField.font = UIFont(name: "KohinoorTelugu-Light", size: 25)
        selectedDateField.inputView = datePicker
        selectedDateField.translatesAutoresizingMaskIntoConstraints = false
        selectedDateField.textColor = UIColor(red: 255/255, green: 137/255, blue: 0, alpha: 1.0)
        
    
        
        let tapScreen = UITapGestureRecognizer(target: self, action: #selector(screenTapped))
        
        
        saveButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveButtonPressed))
        self.navigationItem.rightBarButtonItem = saveButton
        
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(descriptionLabel)
        view.addSubview(descriptionTextView)
        view.addSubview(dateLabel)
        view.addSubview(selectedDateField)
        view.addGestureRecognizer(tapScreen)
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
        
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 25),
            descriptionLabel.widthAnchor.constraint(equalToConstant: descriptionLabel.intrinsicContentSize.width)
            ])
        
        NSLayoutConstraint.activate([
            descriptionTextView.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            descriptionTextView.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            descriptionTextView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 100)])
        
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            dateLabel.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 25),
            dateLabel.widthAnchor.constraint(equalToConstant: dateLabel.intrinsicContentSize.width)
            ])
        
        
        NSLayoutConstraint.activate([
            selectedDateField.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 20),
            selectedDateField.topAnchor.constraint(equalTo: dateLabel.topAnchor),
            selectedDateField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)])
        
        
    }

    
    @objc func dateChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        selectedDateField.text = dateFormatter.string(from: datePicker.date)
       
    }
    
    @objc func screenTapped(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    

    
    @objc func saveButtonPressed(sender: UIBarButtonItem){
        
        
        if let name = nameTextField.text {
            if let description = descriptionTextView.text{
                if let date = selectedDateField.text {
                        Network.postTask(withName: name, withDescription: description, withDueDate: date, withCourseName: self.course.name)
                        delegate?.saveButtonPressed(withName: name, withDescrip: description, withDate: date)
                        navigationController?.popViewController(animated: true)
                   
                }
             
                    }
        }
        
    }
    

    
    
    
    
    
}
