//
//  HomeViewController.swift
//  FinanceApp
//
//  Created by Timur Inamkhojayev on 24.03.2024.
//
import UIKit

class HomeViewController: UIViewController {
    
    var budgetLabel: UILabel!
    private let coreManager = CoreManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Создание и настройка метки для отображения бюджета
        budgetLabel = UILabel()
        budgetLabel.translatesAutoresizingMaskIntoConstraints = false
        budgetLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        budgetLabel.textAlignment = .center
        view.addSubview(budgetLabel)
        
        // Ограничения для метки
        NSLayoutConstraint.activate([
            budgetLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            budgetLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        // Обновляем бюджет
        updateBudget()
    }
    
    // Обновление бюджета
    func updateBudget() {
        let totalAmount = coreManager.transactions.reduce(0) { (result, transaction) in
            if transaction.operationCategory {
                return result + Int(transaction.sum)
            } else {
                return result - Int(transaction.sum)
            }
        }
        budgetLabel.text = "Ваш бюджет: \(totalAmount)₸"
    }
}

