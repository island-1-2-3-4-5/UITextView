//
//  ViewController.swift
//  UITextView
//
//  Created by Roman on 06.02.2020.
//  Copyright © 2020 Roman. All rights reserved.
//

import UIKit
// TextView может быть только outlet, т.е. оно не активно 

class ViewController: UIViewController {

    var myTextView = UITextView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextViev(param:)), name: UIResponder.keyboardDidShowNotification, object: nil) // вызываем метод когда нотификация показывается
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextViev(param:)), name: UIResponder.keyboardWillHideNotification, object: nil) // когда нотификация прячется
        createTextView()
    }

    // MARK: Делам текстовое поле
    func createTextView() {
        myTextView = UITextView(frame: CGRect(x: 20, y: 100, width: self.view.bounds.width - 50, height: self.view.bounds.height / 2))
        myTextView.text = "Введите текст..."
        myTextView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0) // расположение текста
        myTextView.font = UIFont.systemFont(ofSize: 17) // шрифт
        myTextView.backgroundColor = .gray
        self.view.addSubview(myTextView)
    }
    
    // MARK: Отмена клавы нажатием
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) { // скрываем клавиатуру
        self.myTextView.resignFirstResponder() // регистрирует первое касание экрана
    }

    
    // MARK: Делаем прокрутку
  @objc  func updateTextViev(param: Notification) { // используем уведомления
        let userInfo = param.userInfo // берем параметры пользователя, это словарь
        // получаем контуры и координаты клавиатуры.
        let getKeyBoardRect = (userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue //  получем значение по ключу. конвертируем в NSValue. тк это графика, нужен cgRect
        let keyboardFrame = self.view.convert(getKeyBoardRect, to: view.window) // конвертируем
        
        if param.name == UIResponder.keyboardWillHideNotification {
            myTextView.contentInset = UIEdgeInsets.zero // если клавиатура прячется, то текст возвращается в исходное положение. contentInset - Пользовательское расстояние, на которое вид содержимого вставляется от безопасной области или краев прокрутки.
        } else {
            myTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0) // если есть клавиатура, то текст смещается по высоте
            myTextView.scrollIndicatorInsets = myTextView.contentInset // отслеживает курсор прокрутки
        }
    myTextView.scrollRangeToVisible(myTextView.selectedRange) // прокрутка
    }
}

