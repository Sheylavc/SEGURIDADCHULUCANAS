//
//  ConsultaViewController.swift
//  CHULUCANAS
//
//  Created by ucweb on 16/11/16.
//  Copyright © 2016 sheylavc. All rights reserved.
//

import UIKit

class ConsultaViewController: UIViewController,UITextFieldDelegate, UITextViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var txtTema: UITextField!
    @IBOutlet weak var txtConsulta: UITextView!
    
    private let registroTemas : [String] = ["SUGERENCIA", "QUEJA", "MEJORA", "FELICITACIÓN", "OTROS"]
    
    var pickerTema: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerTema = UIPickerView()
        pickerTema.delegate = self
        
        txtTema.inputView = pickerTema
        txtTema.inputAccessoryView = toolBarPicker()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
        
    }
    
    //MARK: IBActionMethods
    @IBAction func btnConfiguracion(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ncConfiguracion")
        self.present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func btnConsulta(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ncConsulta")
        self.present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func sendConsulta(_ sender: Any) {
        if (txtTema.text?.characters.count != 0 && txtConsulta.text.characters.count != 0){
            ModelHelper.sendConsulta(tipo: txtTema.text, consulta: txtConsulta.text, viewcontroller: self)
        }else{
            AlertHelper.notificationAlert(title: "Consulta Chulucanas", message: "Todos los campos son requeridos", viewController: self)
        }
        
    }
    
    
    
    //MARK: TextField Delegate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n"){
            textView.resignFirstResponder()
            return false
        }else{
            return true
        }
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if (textView.text == "Consulta"){
            textView.text = ""
            textView.textColor = UIColor.black
        }
        textView.becomeFirstResponder()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if (textView.text == ""){
            textView.text = "Consulta"
            textView.textColor = UIColor.gray
        }
        textView.resignFirstResponder()
    }
    
    //MARK: PickerView Delegate and Datasource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return registroTemas.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return registroTemas[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtTema.text = registroTemas[row]
        
    }
    
    
    //MARK: Styles Picker ToolBar
    func centerLabel()->UIBarButtonItem{
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        label.font = UIFont(name: "Helvetica", size: 12)
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.white
        label.text = "Seleccione"
        label.textAlignment = NSTextAlignment.center
        
        return UIBarButtonItem(customView: label)
    }
    
    func newToolBar()-> UIToolbar{
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.height/6, width: self.view.frame.size.width, height: 40.0))
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        
        toolBar.barStyle = UIBarStyle.blackTranslucent
        toolBar.tintColor = UIColor.white
        toolBar.backgroundColor = UIColor.gray
        return toolBar
    }
    
    func butonItem()->UIBarButtonItem{
        return UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        
    }
    
    
    
    func toolBarPicker()->UIToolbar{
        
        let toolBar = newToolBar()
        let defaultButton = UIBarButtonItem(title: "Cancelar", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ConsultaViewController.tappedToolBarBtn))
        let doneButton = UIBarButtonItem(title:"Hecho", style: UIBarButtonItemStyle.done, target: self, action: #selector(ConsultaViewController.donePressed))
        toolBar.setItems([defaultButton,butonItem(),centerLabel(),butonItem(),doneButton], animated: true)
        return toolBar
    }
    
    func donePressed(sender: UIBarButtonItem) {
        txtTema.resignFirstResponder()
    }
    
    func tappedToolBarBtn(sender: UIBarButtonItem) {
        txtTema.resignFirstResponder()
        
    }
    
    
    
    
    
}

