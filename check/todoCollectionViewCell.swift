//
//  todoCollectionViewCell.swift
//  check
//
//  Created by Nandita Mohan on 4/28/18.
//  Copyright © 2018 Nandita Mohan. All rights reserved.
//

import UIKit

class todoCollectionViewCell: UICollectionViewCell , UIGestureRecognizerDelegate{
    var nameLabel : UILabel!
    var dateLabel : UILabel!
    
    var panGesture : UIPanGestureRecognizer!
    var deleteLabel: UILabel!

    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        self.contentView.backgroundColor = UIColor(red: 18/255, green: 198/255, blue: 210/255, alpha: 1.0)
        nameLabel = UILabel()
        nameLabel.font = UIFont(name: "KohinoorTelugu-Light", size: 35)
        nameLabel.textColor = .white
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        dateLabel = UILabel()
        dateLabel.font = UIFont(name: "KohinoorTelugu-Light", size: 20)
        dateLabel.textColor = .white
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(panAction))
        panGesture.delegate = self
        
    
  
        contentView.addSubview(nameLabel)
        contentView.addSubview(dateLabel)
        addGestureRecognizer(panGesture)
    }

    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return abs((panGesture.velocity(in:panGesture.view)).x) > abs((panGesture.velocity(in: panGesture.view)).y)
    }

    @objc func panAction(sender: UIPanGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.began {
            
        }else if sender.state == UIGestureRecognizerState.changed {
            setNeedsLayout()
        }else {
            if abs(sender.velocity(in: self).x) > 500{
                let collectionView: UICollectionView = self.superview as! UICollectionView
                let indexPath: IndexPath = collectionView.indexPathForItem(at: center)!
                collectionView.delegate?.collectionView!(collectionView, performAction: #selector(panAction), forItemAt: indexPath, withSender: nil)
            }else {
                UIView.animate(withDuration: 0.2, animations: {
                    self.setNeedsLayout()
                    self.layoutIfNeeded()
                })
                
            }
        }
    }

    override func updateConstraints() {
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.widthAnchor.constraint(equalToConstant: nameLabel.intrinsicContentSize.width)
            ])
        
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: -10),
            dateLabel.widthAnchor.constraint(equalToConstant: dateLabel.intrinsicContentSize.width)
            ])
        
        
        super.updateConstraints()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
