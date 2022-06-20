//
//  ViewController.swift
//  ScrollView
//
//  Created by Zahraa Herz on 19/06/2022.
//

import UIKit

class ViewController: UIViewController {
    
// MARK: -
    
    @IBOutlet var addButton: UIBarButtonItem!
    
    @IBOutlet var scrollView: UIScrollView!

    var pickerView = UIPickerView()
    
    var colorIndex = 0

    var height = 0.0
    
    let colors = [ "Red",
                   "Orange",
                   "Yellow",
                   "Green",
                   "Blue",
                   "Indigo",
                   "Violet",
                 ]
    
    let systemColors = [ UIColor.red,
                         UIColor.orange,
                         UIColor.yellow,
                         UIColor.green,
                         UIColor.blue,
                         UIColor.systemIndigo,
                         UIColor.purple,
                       ]

    var y = 0.0
    
// MARK: -
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let newView = UIView(frame: CGRect(x: 0, y: 0, width: scrollView.bounds.width , height: scrollView.bounds.height))

        newView.backgroundColor = UIColor.gray

        self.scrollView.addSubview(newView)

    }
    
    override func viewDidLayoutSubviews() {
        
        scrollView.isScrollEnabled = true
        scrollView.contentSize = CGSize(width: scrollView.bounds.width , height: scrollView.bounds.height)

    }
    
//MARK: - Action Buttons

    @IBAction func addButton(_ sender: Any) {
  
        // create the actual alert controller view that will be the pop-up
        let alertController = UIAlertController(title: "Add view", message: "", preferredStyle: .alert)

        alertController.preferredContentSize = CGSize(width: 250,height: 300)
        
        let height: NSLayoutConstraint = NSLayoutConstraint(item: alertController.view ?? "",
                                                            attribute: NSLayoutConstraint.Attribute.height,
                                                            relatedBy: NSLayoutConstraint.Relation.equal,
                                                            toItem: nil,
                                                            attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                            multiplier: 1,
                                                            constant: self.view.frame.height * 0.35)
        
        alertController.view.addConstraint(height);
        let pickerFrame = UIPickerView(frame: CGRect(x: 5,
                                                     y: 105,
                                                     width: 250,
                                                     height: 140))
        
        alertController.view.addSubview(pickerFrame)
        pickerFrame.dataSource = self
        pickerFrame.delegate = self
        
        alertController.addTextField { (textField) in

            textField.placeholder = "Height"
        }

        // add the buttons/actions to the view controller
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "Save", style: .default)
        { _ in

            self.height = Double(alertController.textFields![0].text!) ?? 0.0
            
            self.createUIView(height: self.height, colorIndex: self.colorIndex)
        }

        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)

        present(alertController, animated: true, completion: nil)
        
    }
    
//MARK: -
    
    func createUIView(height: Double, colorIndex : Int) {
        
        let newView = UIView(frame: CGRect(x: 0,
                                           y: scrollView.bounds.height + y,
                                           width: scrollView.bounds.width ,
                                           height: height)
                            )

        y += height
        
        // Change UIView background colour
        newView.backgroundColor = systemColors[colorIndex]
        scrollView.contentSize = CGSize(width: scrollView.bounds.width ,
                                        height: scrollView.bounds.height + y)

        self.scrollView.addSubview(newView)

    }

}

//MARK: - PickerView

extension ViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return colors.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return colors[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        colorIndex = row
    }

}
