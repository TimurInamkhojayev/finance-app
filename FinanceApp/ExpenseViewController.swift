//
//  IncomeViewController.swift
//  FinanceApp
//
//  Created by Timur Inamkhojayev on 24.03.2024.
//

import UIKit
import CoreData

class ExpenseViewController: UIViewController {
    var amountTextField: UITextField!
    var descriptionTextField: UITextField!
    var coreManager: CoreManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        amountTextField = UITextField()
        amountTextField.translatesAutoresizingMaskIntoConstraints = false
        amountTextField.placeholder = "Сумма в ₸"
        amountTextField.keyboardType = .numberPad
        view.addSubview(amountTextField)

        descriptionTextField = UITextField()
        descriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextField.placeholder = "Описание"
        view.addSubview(descriptionTextField)

        NSLayoutConstraint.activate([
            amountTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            amountTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            amountTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descriptionTextField.topAnchor.constraint(equalTo: amountTextField.bottomAnchor, constant: 20),
            descriptionTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])

        let saveButton = UIButton(type: .system)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.addTarget(self, action: #selector(saveTransaction), for: .touchUpInside)
        view.addSubview(saveButton)

        NSLayoutConstraint.activate([
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        coreManager = appDelegate.coreManager
    }
    
    @objc func saveTransaction() {
        guard let coreManager = coreManager,
              let amountText = amountTextField.text,
              let descriptionText = descriptionTextField.text,
              let amount = Int32(amountText) else {
            return
        }

        // Добавление новой транзакции
        coreManager.addNewTransaction(sum: amount, description: descriptionText, operationCategory: false)

        // Очистка полей ввода
        amountTextField.text = nil
        descriptionTextField.text = nil
    }

}
