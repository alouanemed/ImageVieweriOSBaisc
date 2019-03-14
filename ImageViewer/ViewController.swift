//
//  ViewController.swift
//  ImageViewer
//
//  Created by alouane on 11/6/18.
//  Copyright © 2018 alouanemed. All rights reserved.
//

import UIKit
import SwiftEntryKit
import SwiftMessages
import SCLAlertView


class ViewController: UITableViewController {

    var pictures = [String]()
    var alertView : SCLAlertView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Image Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true

        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        let title = String(pictures[indexPath.row].dropLast(4))
        cell.textLabel?.text =  title
        cell.detailTextLabel?.text  = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showQtyAlert()
        
    }
    
    func showQtyAlert(){
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false, showCircularIcon: false, shouldAutoDismiss: true, disableTapGesture: false
        )
        
        alertView = SCLAlertView(appearance: appearance)
        
        
        var alertViewResponder = SCLAlertViewResponder(alertview: alertView)
        
        let alertViewText = alertView.addTextField("aty")
        alertViewText.keyboardType = .numberPad
        alertViewText.text = "qty"
        _ = alertView.addButton("Update") {
            if var qtyValue = alertViewText.text {
                
                if qtyValue.isEmpty{
                    qtyValue = "1"
                    alertViewText.text = qtyValue
                }
                
                alertViewText.resignFirstResponder()
                alertViewText.endEditing(true)
                alertViewResponder.close()
                
                self.alertView = nil
                SwiftMessages.showSuccessMessage(with: "Success")
            }
        }
        
        alertView.addButton("Cancel") {
            alertViewResponder.close()
        }
        
        
        if !alertView.isShowing() {
            alertViewResponder = alertView.showEdit("", subTitle: "alertViewResponderalertViewResponderalertViewResponder")
        }
        
    }
    
    
    func addNewCategory() {
        
        var textField : [EKProperty.TextFieldContent] = []
        let title = EKProperty.LabelContent(text: "Create New Category", style: .init(font: .systemFont(ofSize: 16), color: .red, alignment: .center, numberOfLines: 1))
        
        let buttonText = EKProperty.LabelContent(text: "Create", style: .init(font: .systemFont(ofSize: 16), color: .white))
        let description1 = EKProperty.LabelContent(text: "Category Title", style: .init(font: .systemFont(ofSize: 10), color: .darkGray))
        let image1 = UIImage(named: "pencil")
        let textField1 = EKProperty.TextFieldContent(keyboardType: .emailAddress, placeholder: description1, textStyle: .init(font: .systemFont(ofSize: 10), color: .black), isSecure: false, leadingImage: image1 , bottomBorderColor: .darkGray)
        let description2 = EKProperty.LabelContent(text: "Tag", style: .init(font: .systemFont(ofSize: 10), color: .darkGray))
        
        let textField2 = EKProperty.TextFieldContent(keyboardType: .emailAddress, placeholder: description2, textStyle: .init(font: .systemFont(ofSize: 10), color: .black), isSecure: false, bottomBorderColor: .darkGray)
        
        let button = EKProperty.ButtonContent(label: buttonText, backgroundColor: .purple, highlightedBackgroundColor: .blue) {
            
            
            if (!textField1.textContent.isEmpty){
                //Create New Category
                SwiftEntryKit.dismiss()
               
                SwiftMessages.showSuccessMessage(with: "Success")

            }
            SwiftEntryKit.dismiss()
            
        }
        
        var attributes = EKAttributes.centerFloat
        attributes = .float
        attributes.windowLevel = .normal
        attributes.position = .center
        attributes.displayDuration = .infinity
        attributes.entranceAnimation = .init(translate: .init(duration: 0.65, anchorPosition: .bottom,  spring: .init(damping: 1, initialVelocity: 0)))
        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.65, spring: .init(damping: 1, initialVelocity: 0))))
        attributes.entryInteraction = .absorbTouches
        attributes.screenInteraction = .dismiss
        attributes.entryBackground = .color(color: .white)
        attributes.screenBackground = .color(color: .green)
        attributes.border = .value(color: UIColor(white: 0.8784, alpha: 0.6), width: 0.6)
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.3, radius: 3))
        attributes.scroll = .enabled(swipeable: false, pullbackAnimation: .jolt)
        attributes.statusBar = .light
        attributes.positionConstraints.keyboardRelation = .bind(offset: .init(bottom: 15, screenEdgeResistance: 0))
        
        textField.append(textField1)
        textField.append(textField2)
        if textField != nil {
            let contentView = EKFormMessageView(with: title, textFieldsContent: textField, buttonContent: button)
            SwiftEntryKit.display(entry: contentView, using: attributes)
        }
    }
}
