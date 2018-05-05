//
//  CourseCollectionViewCell1.swift
//  check
//
//  Created by Nandita Mohan on 4/27/18.
//  Copyright © 2018 Nandita Mohan. All rights reserved.
//

import UIKit

class CourseCollectionViewCell1: UICollectionViewCell {
    var nameLabel : UILabel!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        nameLabel = UILabel()
        nameLabel.font = UIFont (name: "KohinoorTelugu-Light", size: 30)
        nameLabel.textColor = .white
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(nameLabel)
    }
    
    override func updateConstraints() {
        
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
        
        super.updateConstraints()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
