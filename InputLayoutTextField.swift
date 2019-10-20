//
//  InputLayoutTextField.swift
//  TextFieldTextInputLayout
//
//  Created by Radek Di Luca on 16/08/2019.
//  Copyright © 2019 Radek Di Luca. All rights reserved.
//

import UIKit

class InputLayoutTextField: UITextField {
  var placeHolderColor: UIColor? = UIColor.lightGray
  var defaultFont = UIFont.systemFont(ofSize: 15.0)
  var defaultTitleSize: CGFloat = 11.0
  
  var placeholderLabel = UILabel()
  var difference: CGFloat = 35.0
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  func setup() {
    self.clipsToBounds = false
    self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    self.setupPlaceholderLabel()
  }
  
  @objc private func textFieldDidChange() {
    self.placeholderLabel.alpha = 1
    self.attributedPlaceholder = nil
    self.placeholderLabel.textColor = self.placeHolderColor
    self.placeholderLabel.font = UIFont(name: defaultFont.fontName, size: defaultTitleSize)
    
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {() -> Void in
      if (self.text == nil) || (self.text?.count)! <= 0 {
        self.placeholderLabel.font = self.defaultFont
        self.placeholderLabel.frame = CGRect(x: self.placeholderLabel.frame.origin.x, y: 0, width :self.frame.size.width, height: self.frame.size.height)
      }
      else {
        self.placeholderLabel.frame = CGRect(x : self.placeholderLabel.frame.origin.x, y: -self.difference, width: self.frame.size.width, height : self.frame.size.height)
      }
    }, completion: nil)
  }
  
  private func setupPlaceholderLabel() {
    self.placeholderLabel = UILabel()
    self.placeholderLabel.frame = CGRect(x: 0, y : 0, width : 0, height :self.frame.size.height)
    self.placeholderLabel.font = UIFont.systemFont(ofSize: 10)
    self.placeholderLabel.alpha = 0
    self.placeholderLabel.clipsToBounds = true
    self.addSubview(self.placeholderLabel)
    self.placeholderLabel.attributedText = self.attributedPlaceholder
  }
  
  func placeholderText(_ placeholder: NSString){
    self.setupPlaceholderLabel()
  }
  
  private func update() {
    setupPlaceholderLabel()
    textFieldDidChange()
  }
  
  public func reset() {
    self.text = nil
    textFieldDidChange()
  }
  
  public func setupPlaceholderAttributes(text: String, font: UIFont, color: UIColor) {
    placeholder = text
    defaultFont = font
    placeHolderColor = color
    
    update()
  }
  
  public func setupPlaceholderAttributes(text: String, font: UIFont, color: UIColor, titleSize: CGFloat) {
    placeholder = text
    defaultFont = font
    placeHolderColor = color
    defaultTitleSize = titleSize
    
    update()
  }
}
