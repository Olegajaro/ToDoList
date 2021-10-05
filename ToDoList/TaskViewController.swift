//
//  TaskViewController.swift
//  ToDoList
//
//  Created by Олег Федоров on 05.10.2021.
//

import UIKit
import CoreData

class TaskViewController: UIViewController {
    
    var delegate: TaskViewControllerDelegate!
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // Создаем текстовое поле
    // Свойство должно быть ленивым, чтобы мы могли вызывать его только тогда, когда к нему обращаемся
    // В нашем случае мы его вызываем во viewDidLoad.
    // Внутри фигурных скобок создаем экземпляр класса UITextField.
    // Далее нужно задать параметра для внешнего виде текстового поля.
    // С помощью экземпляра класса UITextField, вызываем свойства placeholder и borderStyle и устанавливаем для них нужные нам значения
    // borderStyle отвечает за внешний вид самого текстового поля
    // в конце возвращаем экземпляр класса UITextField
    private lazy var newTaskTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "New Task"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 21/255, green: 101/255, blue: 192/255, alpha: 1)
        button.setTitle("Save Task", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(save), for: .touchUpInside)
        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.94, green: 0.35, blue: 0.19, alpha: 1)
        button.setTitle("Cancel", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupSubviews(newTaskTextField, saveButton, cancelButton)
        setConstraints()
    }
    
    // Создаем метод для отображения элементов пользовательского интерфейса на супервью
    // метод принимает один параметр subviews с типом набор UIView элементов (по сути массив элементов)
    // внутри метода перебираем массив subviews и внутри цикла добавляем на супер вью (view) элемент пользовательского интерфейса (subview)
    private func setupSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    // Создаем метод для размещения элементов пользовательского интерфейса при помощи констрейнтов
    // внутри метода сразу нужно отключить автоматическое ограничение элементов
    private func setConstraints() {
        newTaskTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newTaskTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            newTaskTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            newTaskTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: newTaskTextField.bottomAnchor, constant: 20),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 20),
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }

    @objc private func save() {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Task", in: context) else { return }
        guard let task = NSManagedObject(entity: entityDescription, insertInto: context) as? Task else { return }
        task.title = newTaskTextField.text
        
        if context.hasChanges {
            do {
                try context.save()
            } catch let error {
                print(error)
            }
        }
        
        delegate.reloadData()
        dismiss(animated: true)
    }
    
    @objc private func cancel() {
        dismiss(animated: true)
    }
}
