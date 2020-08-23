//
//  Utility.swift
//  GithubUser_Mayur_Limbekar
//
//  Created by Admin on 23/08/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func checkEmptyString(_ str:String?) -> Bool {
        if  (str?.isEmpty == true || ((str == nil) || str == " ")) {
            return true
        } else {
            return false
        }
    }
    
    func displayAlert(title:String,message:String) {
        let alert = UIAlertController(title:title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension UILabel {
    func getAttribtedLabel(alignment:NSTextAlignment,getFont:UIFont,lines:Int) {
        self.font = getFont
        self.numberOfLines = lines
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.5
        self.textAlignment = alignment
    }
}

extension UIStackView {
    func getStack(axis:NSLayoutConstraint.Axis,alignment:UIStackView.Alignment,distribution:UIStackView.Distribution,spacing:CGFloat) {
        self.axis = axis
        self.alignment = alignment
        self.distribution = distribution
        self.spacing = spacing
    }
}

extension UITableView {
    func reloadData(completion: @escaping () -> ()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData()})
        {_ in completion() }
    }
}
