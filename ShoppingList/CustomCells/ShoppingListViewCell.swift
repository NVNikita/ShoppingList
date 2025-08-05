//
//  ShoppingListViewCell.swift
//  ShoppingList
//
//  Created by Никита Нагорный on 05.08.2025.
//

import UIKit

final class ShoppingListViewCell: UITableViewCell {
    
    var titleLabel = UILabel()
    var squareImageView = UIImageView()
    var isActive = false {
        didSet {
            updateImage()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupUI() {
        titleLabel.font = .systemFont(ofSize: 16, weight: .regular)
        titleLabel.numberOfLines = 1
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(squareImageView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        squareImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            squareImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            squareImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            squareImageView.widthAnchor.constraint(equalToConstant: 24),
            squareImageView.heightAnchor.constraint(equalToConstant: 24),
            
            titleLabel.leadingAnchor.constraint(equalTo: squareImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
    private func updateImage() {
        if isActive {
            squareImageView.image = UIImage(systemName: "checkmark.square")
            squareImageView.tintColor = .systemGreen
        } else {
            squareImageView.image = UIImage(systemName: "square")
            squareImageView.tintColor = .systemRed
        }
    }
    
    func configure(title: String, isActive: Bool = false) {
        titleLabel.text = title
        self.isActive = isActive
    }
}
