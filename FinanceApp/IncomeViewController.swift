//
//  IncomeViewController.swift
//  FinanceApp
//
//  Created by Timur Inamkhojayev on 24.03.2024.
//

import UIKit
import CoreData

class IncomeViewController: UIViewController {
    
    
    var amountTextField: UITextField!
    var descriptionTextField: UITextField!
    var managedObjectContext: NSManagedObjectContext?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Создание и настройка текстовых полей для ввода суммы и описания
        
        
        
        amountTextField = UITextField()
        amountTextField.translatesAutoresizingMaskIntoConstraints = false
        amountTextField.placeholder = "Сумма"
        amountTextField.keyboardType = .numberPad
        view.addSubview(amountTextField)
        
        descriptionTextField = UITextField()
        descriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextField.placeholder = "Описание"
        view.addSubview(descriptionTextField)
        
        // Ограничения для текстовых полей
        NSLayoutConstraint.activate([
            amountTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            amountTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            amountTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descriptionTextField.topAnchor.constraint(equalTo: amountTextField.bottomAnchor, constant: 20),
            descriptionTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        // Создание кнопки "Сохранить"
        let saveButton = UIButton(type: .system)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.addTarget(self, action: #selector(saveTransaction), for: .touchUpInside)
        view.addSubview(saveButton)
        
        // Ограничения для кнопки "Сохранить"
        NSLayoutConstraint.activate([
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        // Получение доступа к контексту CoreData
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
//        managedObjectContext = appDelegate.persistentContainer.viewContext
    }
    
    @objc func saveTransaction() {
        //логика сохранения операции
    }
}
