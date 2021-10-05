//
//  TaskListViewController.swift
//  ToDoList
//
//  Created by Олег Федоров on 05.10.2021.
//

import UIKit

class TaskListViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .white
        setupNavigationBar()
    }
    
    // метод для настройки Navigation Bar
    // устанавливаем Title
    // меняем стиль Navigation bar на Large titles
    private func setupNavigationBar() {
        title = "Task List"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Создаем экземпляр класса UINavigationBarAppearance, который отвечает за внешний вид Navigation Bar
        let navBarAppearance = UINavigationBarAppearance()
        
        // Настраиваем свойство backgroundColor
        navBarAppearance.backgroundColor = UIColor(
            red: 21/255,
            green: 101/255,
            blue: 192/255,
            alpha: 194/255
        )
        
        // Устанавливаем цвет для текста в Navigation Bar
        // Вначале устанавливаем для свойства titleTextAttributes, которое является словарем.
        // В словарь нужно передать ключ, отвечающий за параметр, который нужно изменить
        // и значение по этому ключу, в нашем случае для параметра foregroundColor необходимо установить белый цвет.
        // Затем присваиваем то же самое значение для свойства largeTitleTextAttributes (текст, который в Large Title).
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        // Для того, чтобы Navigation Bar был покрашен во всех его состояниях,
        // нужно присвоить экземпляр класса UINavigationBarAppearance двум параметрам,
        // которые отвечают  за состояние Navigation Bar
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
}

