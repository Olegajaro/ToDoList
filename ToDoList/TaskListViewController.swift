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
    private func setupNavigationBar() {
        // устанавливаем Title
        // меняем стиль Navigation bar на Large titles
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
        
        // Добавляем кнопку в Navigation Bar для добавления задачи
        // Для этого нужно у navigationItem вызвать свойство rightBarButtonItem, которое размещает итем справа
        // и присваиваем ему экземпляр класса UIBarButtonItem
        // в инициализатор класса передаем 3 параметра:
        // barButtonSystemItem, отвечающий за предназначение кнопки, в нашем случае это add
        // target, где будет вызываться данный экземпляр, передаем self, т.к. вызывается в этом же классе
        // action, действие для кнопки, которое передается через селектор, в котором нужно указать @objc метод
        // метод будет добавлять новую задачу addNewTask
        // в этом варианте, этот метод будет служить переходом на другой ViewController, где мы будем создавать и добавлять задачу уже на главный экран
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewTask)
        )
        
        navigationController?.navigationBar.tintColor = .white
        // Для того, чтобы Navigation Bar был покрашен во всех его состояниях,
        // нужно присвоить экземпляр класса UINavigationBarAppearance двум параметрам,
        // которые отвечают  за состояние Navigation Bar
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    @objc private func addNewTask() {
        // Для перехода на другой ViewController в методе нужно создать экземпляр этого ViewController.
        // И чтобы его открыть нужно вызвать метод present, в который необходимо передать два параметра:
        // первый параметр - это представление, которые мы хотим открыть, т.е наш TaskViewController
        // второй параметр отвечает за анимацию, почти всегда ставится true, так как все происходит на глазах у пользователя
        let taskVC = TaskViewController()
        present(taskVC, animated: true)
    }
}

