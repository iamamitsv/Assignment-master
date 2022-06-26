//
//  DetailsTableViewCell.swift
//  Assignment
//
//  Created by Amit Srivastava on 24/06/22.
//  Copyright © 2022 Amit Srivastava. All rights reserved.
//

import UIKit

class ContentTableViewCell: UITableViewCell {
    lazy var width: NSLayoutConstraint = {
        let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
        width.isActive = true
        return width
    }()
    
    var contentImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.white
        imageView.tag = 1
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        if UIDevice.isPad { label.font = UIFont.systemFont(ofSize: 22)}
        else{ label.font = UIFont.systemFont(ofSize: 14)}
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var separatorLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        if UIDevice.isPad { label.font = UIFont.systemFont(ofSize: 22)}
        else{ label.font = UIFont.systemFont(ofSize: 14)}
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        translatesAutoresizingMaskIntoConstraints = false
        addViews()
    }
    
    var feedsValue: UserContentsModel? {
        didSet {
            guard let feeds = feedsValue else {
                return
            }
            descriptionLabel.text = feeds.description
            titleLabel.text = feeds.title
            self.contentImage.contentMode =   UIView.ContentMode.scaleAspectFit
            self.contentImage .clipsToBounds =  true
    
        }
    }
    func addViews(){
        //Add Description Title
        contentView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        //Add Separator
        contentView.addSubview(separatorLabel)
        separatorLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        separatorLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        separatorLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        separatorLabel.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        //Add Content Image
        contentView.addSubview(contentImage)
        contentImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0).isActive = true
        contentImage.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        contentImage.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        if UIDevice.isPad { contentImage.heightAnchor.constraint(equalToConstant: 250).isActive = true}
        else{  contentImage.heightAnchor.constraint(equalToConstant: 150).isActive = true}
        
        //Add Content Description
        contentView.addSubview(descriptionLabel)
        descriptionLabel.topAnchor.constraint(equalTo: contentImage.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        descriptionLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        
        if let lastSubview = contentView.subviews.last {
            contentView.bottomAnchor.constraint(equalTo: lastSubview.bottomAnchor, constant: 10).isActive = true
        }
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        width.constant = bounds.size.width
        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
    }
}

