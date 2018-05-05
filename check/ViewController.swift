//
//  ViewController.swift
//  check
//
//  Created by Nandita Mohan on 4/27/18.
//  Copyright © 2018 Nandita Mohan. All rights reserved.
//

import UIKit


class ViewController: UIViewController{
    
    var logo: UIImageView!
    var label: UILabel!
    var label2: UILabel!
    var startButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Check"
        view.backgroundColor = .white
        
        logo = UIImageView(image: #imageLiteral(resourceName: "logo"))
        logo.translatesAutoresizingMaskIntoConstraints = false
        
        label = UILabel()
        label.font = UIFont(name: "KohinoorTelugu-Light", size: 35)
        label.text = "Ready to check off"
        label.translatesAutoresizingMaskIntoConstraints = false

        
        label2 = UILabel()
        label2.font = UIFont(name: "KohinoorTelugu-Light", size: 35)
        label2.text = "some tasks today?"
        label2.translatesAutoresizingMaskIntoConstraints = false
        
        startButton = UIButton(type: UIButtonType.roundedRect) as UIButton
        startButton.setTitle("START -->", for: .normal)
        startButton.titleLabel?.font = UIFont(name: "KohinoorTelugu-Light", size: 35)
        startButton.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
        startButton.translatesAutoresizingMaskIntoConstraints = false

        
        view.addSubview(logo)
        view.addSubview(label)
        view.addSubview(label2)
        view.addSubview(startButton)
        setupConstraints()
        
    }
    
    @objc func startButtonPressed(sender: UIButton){
        let courseVC = CourseViewController()
        navigationController?.pushViewController(courseVC, animated: true)
    }
    
    func setupConstraints(){
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            label.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            label.widthAnchor.constraint(equalToConstant: label.intrinsicContentSize.width)])
        
        NSLayoutConstraint.activate([
            label2.topAnchor.constraint(equalTo: label.bottomAnchor),
            label2.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            label2.widthAnchor.constraint(equalToConstant: label2.intrinsicContentSize.width)])
        
        NSLayoutConstraint.activate([
            logo.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: -30),
            logo.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 20),
            logo.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            logo.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, constant: -250)])
        
        NSLayoutConstraint.activate([
            startButton.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: -50),
            startButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)])
        

        
    }
    


}

