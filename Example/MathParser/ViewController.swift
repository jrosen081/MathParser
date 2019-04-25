//
//  ViewController.swift
//  MathParser
//
//  Created by jrosen081 on 04/24/2019.
//  Copyright (c) 2019 jrosen081. All rights reserved.
//

import UIKit
import MathParser

class ViewController: UIViewController {
	@IBOutlet weak var additionOp: UITextField!
	@IBOutlet weak var subOp: UITextField!
	@IBOutlet weak var multOp: UITextField!
	@IBOutlet weak var divOp: UITextField!
	@IBOutlet weak var powOp: UITextField!
	@IBOutlet weak var exprField: UITextField!
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	@IBAction func parseExpression(_ sender: Any) {
		Operators.addOp = self.additionOp.text!
		Operators.subOp = self.subOp.text!
		Operators.multOp = self.multOp.text!
		Operators.divOp = self.divOp.text!
		Operators.powOp = self.powOp.text!
		if let result = Parser.parse(string: exprField.text!)?.evaluate() {
			let alert = UIAlertController(title: "The result", message: "\(result)", preferredStyle: .alert)
			let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
			alert.addAction(ok)
			self.present(alert, animated: true)
		} else {
			let alert = UIAlertController(title: "The result", message: "That could not be parsed.", preferredStyle: .alert)
			let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
			alert.addAction(ok)
			self.present(alert, animated: true)
		}
	}
}

extension ViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		return textField.endEditing(true)
	}
}

