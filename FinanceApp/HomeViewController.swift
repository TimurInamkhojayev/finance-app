//
//  HomeViewController.swift
//  FinanceApp
//
//  Created by Timur Inamkhojayev on 24.03.2024.
//
import UIKit
import CoreData

class HomeViewController: UIViewController {
    
    var budgetLabel: UILabel!
    var managedObjectContext: NSManagedObjectContext?
    var operations: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Создание и настройка метки для отображения бюджета
        budgetLabel = UILabel()
        budgetLabel.translatesAutoresizingMaskIntoConstraints = false
        budgetLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        budgetLabel.textAlignment = .center
        budgetLabel.text = "Ваш бюджет: " // + Здесь должно быть значение с Локальной БД
        view.addSubview(budgetLabel)
        
        // Ограничения для метки
        NSLayoutConstraint.activate([
            budgetLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            budgetLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        // Получение доступа к контексту CoreData из AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
//        managedObjectContext = appDelegate.persistentContainer.viewContext
    }
    
    // Обновление бюджета
    func updateBudget(amount: Double) {
        // логика обновления бюджета
        // Например, если amount - это сумма операции, то вы можете вычесть эту сумму из текущего бюджета
        // После этого обновите текст метки budgetLabel
    }
}
