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
    private var foodList: [ItemModel] = []
    private var selectedItems: Set<String> = []
    private let savedItemsKey = "savedShoppingList"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
        setupUI()
        setupTable()
        activateConstraints()
    }
    
    private func setupTable() {
        shoppingTableView.dataSource = self
        shoppingTableView.delegate = self
        shoppingTableView.register(ShoppingListViewCell.self, forCellReuseIdentifier: "cell")
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
    
    private func saveItems() {
        if let encodedData = try? JSONEncoder().encode(foodList) {
            UserDefaults.standard.set(encodedData, forKey: savedItemsKey)
        }
    }
    
    private func loadItems() {
        if let savedData = UserDefaults.standard.data(forKey: savedItemsKey),
           let decodedItems = try? JSONDecoder().decode([ItemModel].self, from: savedData) {
            foodList = decodedItems
        } else {
            foodList = [
                ItemModel(name: "banana", isChecked: false),
                ItemModel(name: "pecan", isChecked: false),
                ItemModel(name: "pasta", isChecked: false),
                ItemModel(name: "apple", isChecked: false),
                ItemModel(name: "orange", isChecked: false)
            ]
        }
    }
    
    @objc private func addButtonTapped() {
        let alert = UIAlertController(title: "Добавить", message: nil, preferredStyle: .alert)
        alert.addTextField { $0.placeholder = "Название" }
        
        let addAction = UIAlertAction(title: "Добавить", style: .default) { [weak self] _ in
            guard let self = self,
                  let text = alert.textFields?.first?.text,
                  !text.isEmpty else { return }
            
            let newItem = ItemModel(name: text, isChecked: false)
            self.foodList.append(newItem)
            self.shoppingTableView.reloadData()
            self.saveItems()
        }
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        alert.addAction(addAction)
        present(alert, animated: true)
    }
    
    @objc private func deleteButtonTapped() {
        let alert = UIAlertController(title: "Удалить выбранное из списка?", message: nil, preferredStyle: .alert)
        
        let buttonYes = UIAlertAction(title: "Да", style: .default) { [weak self] _ in
            guard let self = self else { return }
            
            self.foodList.removeAll { self.selectedItems.contains($0.name) }
            self.selectedItems.removeAll()
            self.shoppingTableView.reloadData()
            self.saveItems()
        }
        
        alert.addAction(UIAlertAction(title: "Нет", style: .cancel))
        alert.addAction(buttonYes)
        present(alert, animated: true)
    }
}

extension ShoppingListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ShoppingListViewCell
        cell.selectionStyle = .none
        let item = foodList[indexPath.row]
        cell.configure(title: item.name, isActive: selectedItems.contains(item.name))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = foodList[indexPath.row]
        
        if selectedItems.contains(item.name) {
            selectedItems.remove(item.name)
        } else {
            selectedItems.insert(item.name)
        }
        
        foodList[indexPath.row].isChecked.toggle()
        saveItems()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { (_, _, completion) in
            let item = self.foodList[indexPath.row]
            self.selectedItems.remove(item.name)
            self.foodList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self.saveItems()
            completion(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
