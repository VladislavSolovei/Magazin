//
//  SecondViewController.swift
//  Magazin
//
//  Created by Sergey Shinkarenko on 4.05.21.
//

import UIKit

protocol StorageContentDelegate: AnyObject {
    func itemAdded(item: String)
}

class SecondViewController: UIViewController {
    weak var shop: Shop?
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var itemToAddTextField: UITextField!
    @IBOutlet private weak var storageContentLabel: UILabel!
    weak var delegate: StorageContentDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addButton.round()
        showStorageContent()
        itemToAddTextField.delegate = self
    }

    func showStorageContent() {
        var storageContentString = "Содержимое склада: "

        for item in shop?.storage ?? [] {
            storageContentString.append("\n\(item)")
        }
        storageContentLabel.text = storageContentString
    }

    @IBAction func add(_ sender: Any) {
        guard let itemToAdd = itemToAddTextField.text,
              itemToAdd != "" else {
            let alert = UIAlertController(title: "Error", message: "Please enter item name", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            return
        }
        shop?.storage.append(itemToAdd)
        UserDefaults.standard.set(shop?.storage, forKey: "ShopStorage")
        showStorageContent()
        itemToAddTextField.text = ""
        delegate?.itemAdded(item: itemToAdd)
    }
    
    
}

extension SecondViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        add(self)
        view.endEditing(true)
        return true
    }
}
