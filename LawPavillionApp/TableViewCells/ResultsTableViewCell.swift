//
//  ResultsTableViewCell.swift
//  LawPavillionApp
//
//  Created by Apple on 5/13/22.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {
    
    static let id = "resultsIdentifier"
    
    var notName : UILabel = {
        
        let label = UILabel()
        label.text = "Notification Name"
        label.textColor = Constants.navyBlue
        label.font = UIFont(name: "Poppins-Bold", size: 15)
        //label.numberOfLines = 0
        return label
    }()
    
    var image_view: UIImageView = {
        
        let img = UIImageView(image: UIImage(named: "img_avatar"))
        
        return img
    }()
    
    var avatar_url: UILabel = {
        
        let label = UILabel()
        label.text = "avatar url"
        label.textColor = .darkGray
        label.font = UIFont(name: "Poppins-Regular", size: 9)
        return label
    }()
    
    var typeUrl: UILabel = {
        
        let label = UILabel()
        label.text = "type"
        label.textColor = .darkGray
        label.font = UIFont(name: "Poppins-Regular", size: 9)
        return label
    }()

    override func layoutSubviews() {
          super.layoutSubviews()
          //set the values for top,left,bottom,right margins
          let margins = UIEdgeInsets(top: 50, left: 0, bottom: 50, right: 0)
          contentView.frame = contentView.frame.inset(by: margins)
          contentView.layer.cornerRadius = 8
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        let outerMostView = UIView()
        addSubview(outerMostView)
        //constraint(paddingTop: 8, paddingBottom: 8, paddingLeft: 8, paddingRight: 8)
        isUserInteractionEnabled = true
        outerMostView.backgroundColor = .white
        outerMostView.constraint(equalToTop:topAnchor, equalToBottom: bottomAnchor, equalToLeft: leadingAnchor, equalToRight: trailingAnchor, paddingTop: 8, paddingBottom: 16, paddingLeft: 8, paddingRight: 8)
        outerMostView.shadowBorder()
        outerMostView.isUserInteractionEnabled = true
        
        image_view.constraint(width: 50, height: 50)
        
        image_view.contentMode = .scaleAspectFit
        
        let avatarStack = UIStackView(arrangedSubviews: [image_view, notName])
        outerMostView.addSubview(avatarStack)
        avatarStack.constraint(equalToTop: outerMostView.topAnchor, equalToLeft: outerMostView.leadingAnchor, paddingTop: 16, paddingLeft: 16)
        //avatarStack.centre(centreY: outerMostView.centerYAnchor)
        avatarStack.spacing = 12
        avatarStack.axis = .horizontal
        avatarStack.distribution = .fill
        
        outerMostView.addSubview(avatar_url)
        avatar_url.constraint(equalToTop: avatarStack.bottomAnchor, equalToLeft: outerMostView.leadingAnchor, equalToRight: outerMostView.trailingAnchor, paddingTop: 12, paddingLeft: 6, paddingRight: 6)
        
        outerMostView.addSubview(typeUrl)
        typeUrl.constraint(equalToTop: avatar_url.bottomAnchor, equalToLeft: outerMostView.leadingAnchor, paddingTop: 12, paddingLeft: 6)
        
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
