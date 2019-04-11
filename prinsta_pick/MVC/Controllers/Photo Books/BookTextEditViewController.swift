
//
//  BookTextEditViewController.swift
//  prinsta_pick
//
//  Created by apple on 10/02/19.
//  Copyright © 2019 Pankaj Jangid. All rights reserved.
//

import UIKit

protocol TextSendToOtherScreenDelegate {
    func textDetailSendDelegate(CoverText : String, textColor : UIColor, fontName : String)
    
}
class BookTextEditViewController: UIViewController {
    
    @IBOutlet weak var textField_BookName: UITextField!
    
    @IBOutlet weak var textField_Font: UITextField!
    @IBOutlet weak var textField_textColor: UITextField!
    
    @IBOutlet weak var btn_done: UIButton!
      var delegate : TextSendToOtherScreenDelegate?
        var customDatePicker:ActionSheetStringPicker = ActionSheetStringPicker.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setGradient()
        btn_done.setTitle("Done", for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        AppHelper.delay(0.3) {
            self.setGradient()
        }
    }
    
    func setGradient() {

        let color1:UIColor = UIColor(red: 233.0/255.0, green: 172.0/255.0, blue: 110.0/255.0, alpha: 0.5)
        let color2:UIColor = UIColor(red: 242.0/255.0, green: 122.0/255.0, blue: 132.0/255.0, alpha: 0.5)
        
        let color3:UIColor = UIColor(red: 233.0/255.0, green: 172.0/255.0, blue: 110.0/255.0, alpha: 1.0)
        let color4:UIColor = UIColor(red: 242.0/255.0, green: 122.0/255.0, blue: 132.0/255.0, alpha: 1.0)
        
        self.view.applyGradient(colours: [color2,color1], locations: [0.0, 0.5, 1.0,0.5])
        self.btn_done.applyGradient(colours: [color3,color4], locations: [0.0, 0.5, 1.0,0.5])
        textField_BookName.delegate = self
        textField_Font.delegate = self
        textField_textColor.delegate = self
        
    }
    
    var selected_Color : UIColor?
    var selected_font_name : String?
    
    @IBAction func btn_tap_done(_ sender: Any) {
        self.dismiss(animated: true) {
            self.delegate?.textDetailSendDelegate(CoverText : self.textField_BookName.text!, textColor : self.selected_Color ?? UIColor.black, fontName : self.selected_font_name ?? "Rockwell")
        }
    }
    @IBAction func btn_tap_cross(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func showActionSheet(textField:UITextField){
        if textField == textField_Font {
        
            let rowsArray = ["Snell Roundhand","Zapfino",
                "Rockwell",
                "Party LET",
                "Century Gothic"]
            
        let placeHolder =  "Select Font "
        
        customDatePicker = ActionSheetStringPicker.init(title:placeHolder, rows: rowsArray, initialSelection: 0, doneBlock:
            { picker, values, indexes in
                textField.text = (String(describing: indexes!))
                //self.genderButton.setTitle(String(describing: indexes!), for: UIControlState.normal)
                self.textField_BookName.font = UIFont(name: (String(describing: indexes!)), size: 16.0)
                self.selected_font_name = (String(describing: indexes!))
                return
        },
                                                        cancel: nil, origin: textField)
        customDatePicker.tapDismissAction = TapAction.cancel
        self.view.endEditing(true)
        customDatePicker.show()
        } else {
            
            let rowsArray  = ["Blue","Green","Gray", "Purple","Red"]
            let placeHolder =  "Selector Text Color"
            
            
            customDatePicker = ActionSheetStringPicker.init(title:placeHolder, rows: rowsArray, initialSelection: 0, doneBlock:
                { picker, values, indexes in
                    textField.text = (String(describing: indexes!))
                    switch textField.text {
                    case "Blue" :
                        self.textField_BookName.textColor = .blue
                        self.selected_Color = .blue
                        break
                    case "Green":
                        self.textField_BookName.textColor = .green
                        self.selected_Color = .green
                        break
                    case "Gray":
                        self.textField_BookName.textColor = .gray
                        self.selected_Color = .gray
                        break
                    case "Purple":
                        self.textField_BookName.textColor = .purple
                        self.selected_Color = .purple
                        break
                    case "Red":
                        self.textField_BookName.textColor = .red
                        self.selected_Color = .red
                        break
                    default:
                        self.textField_BookName.textColor = .black
                        self.selected_Color = .black
                        break
                    }
                    //self.genderButton.setTitle(String(describing: indexes!), for: UIControlState.normal)
                    return
            },
                                                            cancel: nil, origin: textField)
            customDatePicker.tapDismissAction = TapAction.cancel
            self.view.endEditing(true)
            customDatePicker.show()
            
            
        }
    }

}

extension BookTextEditViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == textField_BookName {
            return true
        } else {
            showActionSheet(textField: textField)
            return false
        }
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
}
