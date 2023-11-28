//
//  TableViewCell.swift
//  Let's Chat
//
//  Created by PhyoWai Aung on 11/22/23.
//

import UIKit

class TableViewCell: UITableViewCell {

    static let identifier = "TableViewCell"
    
    let messageView : UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    let messageBody : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .cyan
        return label
    }()
    
    let SenderImageView : UIImageView = {
        let mI = UIImageView()
        mI.contentMode = .scaleAspectFit
        mI.image = UIImage(named: "YouAvatar")
        mI.layer.cornerRadius = 10
        mI.clipsToBounds = true
        mI.translatesAutoresizingMaskIntoConstraints = false
        return mI
    }()
    
    let SelfImageView : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "MeAvatar")
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        messageView.addSubview(messageBody)
        contentView.addSubview(messageView)
        contentView.addSubview(SenderImageView)
        contentView.addSubview(SelfImageView)
        
        NSLayoutConstraint.activate([
            
            contentView.heightAnchor.constraint(equalToConstant: 50),
            SenderImageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            SenderImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            SenderImageView.widthAnchor.constraint(equalToConstant: 30),
            SenderImageView.heightAnchor.constraint(equalToConstant: 30),
            SenderImageView.trailingAnchor.constraint(equalTo: messageView.leadingAnchor),
            
            messageBody.topAnchor.constraint(equalTo: messageView.topAnchor, constant: 10),
            messageBody.leadingAnchor.constraint(equalTo: messageView.leadingAnchor, constant: 7),
            messageBody.trailingAnchor.constraint(equalTo: messageView.trailingAnchor, constant: 7),
            messageBody.bottomAnchor.constraint(equalTo: messageView.bottomAnchor, constant: -10),
            
            SelfImageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            SelfImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            SelfImageView.leadingAnchor.constraint(equalTo: messageView.trailingAnchor,constant: -10),
            SelfImageView.widthAnchor.constraint(equalToConstant: 30),
            SelfImageView.heightAnchor.constraint(equalToConstant: 30),
            
            messageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            messageView.leadingAnchor.constraint(equalTo: SenderImageView.trailingAnchor),
            messageView.trailingAnchor.constraint(equalTo: SelfImageView.leadingAnchor,constant: -10),
            messageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50)
        ])
    }
}


