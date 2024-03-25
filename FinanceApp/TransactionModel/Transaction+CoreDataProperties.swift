//
//  Transaction+CoreDataProperties.swift
//  FinanceApp
//
//  Created by Timur Inamkhojayev on 25.03.2024.
//
//

import Foundation
import CoreData


extension Transaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }

    @NSManaged public var id: String?
    @NSManaged public var sum: Int32
    @NSManaged public var descript: String?
    @NSManaged public var date: Date?
    @NSManaged public var operationCategory: Bool

}

extension Transaction : Identifiable {
    func deleteTransaction(){
        managedObjectContext?.delete(self)
        try? managedObjectContext?.save()
    }
}
