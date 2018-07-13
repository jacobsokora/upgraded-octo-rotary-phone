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
        outputDisplay.text = converter.outputUnit
        inputDisplay.text = converter.inputUnit
    }
}

