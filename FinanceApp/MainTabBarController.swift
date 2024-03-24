//
//  ViewController.swift
//  FinanceApp
//
//  Created by Timur Inamkhojayev on 24.03.2024.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        setTabBarAppearance()
    }
    
    private func generateTabBar() {
        viewControllers = [
            generateVC(
                viewController: HomeViewController(),
                title: "Главная",
                image: UIImage(systemName: "house.fill")
            ),
            generateVC(
                viewController: HistoryViewController(),
                title: "История",
                image: UIImage(systemName: "person.fill")
            ),
            generateVC(
                viewController: IncomeViewController(),
                title: "Доход",
                image: UIImage(systemName: "plus.circle")
            ),
            
            generateVC(
                viewController: ExpenseViewController(),
                title: "Расход",
                image: UIImage(systemName: "minus.circle")
            )
            

        ]
    }
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
    
    private func setTabBarAppearance() {
        let positionOnX: CGFloat = 10
        let positionOnY: CGFloat = 14
        let width = tabBar.bounds.width - positionOnX * 2
        let height = tabBar.bounds.height + positionOnY * 2
        
        let roundLayer = CAShapeLayer()
        
        let bezierPath = UIBezierPath(
            roundedRect: CGRect(
                x: positionOnX,
                y: tabBar.bounds.minY - positionOnY,
                width: width,
                height: height
            ),
            cornerRadius: height / 2
        )
        
        roundLayer.path = bezierPath.cgPath
        
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        
        tabBar.itemWidth = width / 5
        tabBar.itemPositioning = .centered
        
        roundLayer.fillColor = UIColor.mainWhite.cgColor
        
        tabBar.tintColor = .tabBarItemAccent
        tabBar.unselectedItemTintColor = .tabBarItemLight
    }
}

