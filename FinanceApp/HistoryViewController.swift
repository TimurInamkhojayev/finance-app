//
//  HistoryViewController.swift
//  FinanceApp
//
//  Created by Timur Inamkhojayev on 24.03.2024.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let coreManager = CoreManager.shared
    private var transactions: [Transaction] = []
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.dataSource = self
        table.delegate = self
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        // Создание и настройка таблицы для отображения истории операций
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
        // Ограничения для таблицы
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        // Установка замыкания для обновления данных
        coreManager.setOnDataUpdate { [weak self] in
            self?.reloadData() // Вызываем метод обновления данных
        }
        
        // Обновление данных при загрузке представления
        reloadData()
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let transaction = transactions[indexPath.row]
        
        // Устанавливаем цвет текста и знак перед суммой в зависимости от operationCategory
        if transaction.operationCategory {
            cell.textLabel?.textColor = UIColor(red: 0, green: 0.5, blue: 0, alpha: 1.0)
            cell.textLabel?.text = "+\(transaction.sum)₸"
        } else {
            cell.textLabel?.textColor = .red
            cell.textLabel?.text = "-\(transaction.sum)₸"
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let transaction = transactions[indexPath.row]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        cell.detailTextLabel?.text = "Описание: \(transaction.descript ?? ""), Дата: \(dateFormatter.string(from: transaction.date ?? Date()))"
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { [weak self] (action, view, completionHandler) in
            guard let self = self else { return }
            let transactionToDelete = self.transactions[indexPath.row]
            transactionToDelete.deleteTransaction() // Удаление транзакции
            self.coreManager.fetchAllTransactions() // Перезагрузка данных из базы данных
            self.transactions = self.coreManager.transactions // Обновление списка транзакций
            tableView.deleteRows(at: [indexPath], with: .automatic) // Удаление строки из таблицы
            completionHandler(true)
        }
        deleteAction.backgroundColor = .red
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }

    
    

    
    // Функция обновления данных
    func reloadData() {
        transactions = coreManager.transactions
        tableView.reloadData() // Обновляем таблицу
    }
}
