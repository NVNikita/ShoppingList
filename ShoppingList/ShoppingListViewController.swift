//
//  ViewController.swift
//  ShoppingList
//
//  Created by Никита Нагорный on 03.08.2025.
//

import UIKit

final class ShoppingListViewController: UIViewController {
    
    private var shoppingTableView = UITableView()
    private let addButton = UIButton()
    private let deleteButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupTable()
        activateConstraints()
    }
    
    private func setupTable() {
        shoppingTableView.dataSource = self
        shoppingTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(shoppingTableView)
        view.addSubview(addButton)
        view.addSubview(deleteButton)
        
        shoppingTableView.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        
        shoppingTableView.layer.cornerRadius = 15
        shoppingTableView.layer.masksToBounds = true
        
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        addButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addButton.tintColor = .systemBlue
        
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        deleteButton.setImage(UIImage(systemName: "trash"), for: .normal)
        deleteButton.tintColor = .systemRed
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            shoppingTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            shoppingTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            shoppingTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            shoppingTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            addButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            addButton.heightAnchor.constraint(equalToConstant: 44),
            addButton.widthAnchor.constraint(equalToConstant: 44),
            
            deleteButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            deleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            deleteButton.heightAnchor.constraint(equalToConstant: 44),
            deleteButton.widthAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc private func addButtonTapped() {
        print("addButton tap")
    }
    
    @objc private func deleteButtonTapped() {
        print("deleteButton tap")
    }
}

extension ShoppingListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .systemFill
        return cell
    }
}
