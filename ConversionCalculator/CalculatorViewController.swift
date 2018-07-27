//
//  ViewController.swift
//  ConversionCalculator
//
//  Created by Jacob Sokora on 7/12/18.
//  Copyright © 2018 Jacob Sokora. All rights reserved.
//

import UIKit

struct Converter {
    let label: String
    let inputUnit: String
    let outputUnit: String
}

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var outputDisplay: UITextField!
    @IBOutlet weak var inputDisplay: UITextField!
    
    var inputText: String = ""
    
    let converters = [
        Converter(label: "fahrenheit to celcius", inputUnit: "°F", outputUnit: "°C"),
        Converter(label: "celcius to fahrenheit", inputUnit: "°C", outputUnit: "°F"),
        Converter(label: "miles to kilometers", inputUnit: "mi", outputUnit: "km"),
        Converter(label: "kilometers to miles", inputUnit: "km", outputUnit: "mi")
    ]
    var currentConverter: Converter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setConverter(converters[0])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeConverter(_ sender: UIButton) {
        let actionSheet = UIAlertController(title: "Choose converter", message: nil, preferredStyle: .actionSheet)
        for converter in converters {
            actionSheet.addAction(UIAlertAction(title: converter.label, style: .default) { action in
                self.setConverter(converter)
            })
        }
        present(actionSheet, animated: true)
    }
    
    func setConverter(_ converter: Converter) {
        currentConverter = converter
        updateConversion()
    }
    
    func updateConversion() {
        guard let converter = currentConverter,
            let value = Double(inputText) else {
                return
        }
        inputDisplay.text = "\(inputText) \(converter.inputUnit)"
        var convertedValue = value
        switch converter.label {
        case "fahrenheit to celcius":
            convertedValue = (convertedValue - 32) * (5 / 9)
        case "celcius to fahrenheit":
            convertedValue = (convertedValue * (9 / 5)) + 32
        case "miles to kilometers":
            convertedValue = convertedValue * 1.60934
        case "kilometers to miles":
            convertedValue = convertedValue / 1.60934
        default:
            break
        }
        outputDisplay.text = "\(String(format: "%.2f", convertedValue)) \(converter.outputUnit)"
    }
    
    @IBAction func clear(_ sender: UIButton) {
        guard let converter = currentConverter else {
            return
        }
        inputText = ""
        inputDisplay.text = converter.inputUnit
        outputDisplay.text = converter.outputUnit
    }
    
    @IBAction func invert(_ sender: UIButton) {
        if inputText.contains("-") {
            inputText.remove(at: inputText.startIndex)
        } else {
            inputText = "-" + inputText
        }
        updateConversion()
    }
    
    @IBAction func append(_ sender: UIButton) {
        if let period = inputText.index(of: ".") {
            if inputText[inputText.index(after: period)...].count == 2 {
                return
            }
        }
        inputText += sender.titleLabel?.text ?? ""
        updateConversion()
    }
    
    @IBAction func decimal(_ sender: UIButton) {
        if !inputText.contains(".") {
            inputText += "."
        }
        updateConversion()
    }
}

