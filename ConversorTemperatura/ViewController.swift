//
//  ViewController.swift
//  ConversorTemperatura
//
//  Created by unicred on 06/12/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var valueTF: UITextField!

    @IBOutlet var paraBtn: UIButton!
    @IBOutlet var deBtn: UIButton!

    @IBOutlet var resultLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        appendMenu(deBtn)
        appendMenu(paraBtn)
    }
	
	func appendMenu(_ button: UIButton) {
		let handler = { (_: UIAction) in self.updateUI() }

        button.menu = UIMenu(children: [
            UIAction(title: "C°", handler: handler),
            UIAction(title: "K°", handler: handler),
            UIAction(title: "F°", handler: handler),
        ])
		
        button.showsMenuAsPrimaryAction = true
        button.changesSelectionAsPrimaryAction = true
    }

    @IBAction func valueChange(_: Any) {
        updateUI()
    }

    func updateUI() {
        guard let value = Double(valueTF.text ?? "") else {
			resultLabel.text = "Temperatura invalida!"
			return
		}
		
		let para = paraBtn.currentTitle!
		let result = convert(deBtn.currentTitle!, para, value)
		
		resultLabel.text = String(format: "%.2f \(para)", result)
    }
	
	func convert(_ de: String, _ para: String, _ value: Double) -> Double {
		if de == para {
			return value
		}
		
		switch de {
			case "C°":
				return para == "K°" ? value + 273.15 : cToF(value)
			case "K°":
				return para == "C°" ? kToC(value) : cToF(kToC(value))
			default:
				return para == "C°" ? fToC(value) : kToC(fToC(value))
		}
	}
		
	func kToC(_ x: Double) -> Double {
		return x - 273.15
	}

    func cToF(_ x: Double) -> Double {
        return (x * (9 / 5)) + 32
    }

    func fToC(_ x: Double) -> Double {
        return (x - 32) * 5 / 9
    }
}
