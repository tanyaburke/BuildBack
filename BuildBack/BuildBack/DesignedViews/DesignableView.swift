//
//  DesignableView.swift
//  BuildBack
//
//  Created by Tanya Burke on 5/28/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit

@IBDesignable

class DesignableView: UIView {
  @IBInspectable var cornerRadius: CGFloat = 0
  @IBInspectable var borderWidth: CGFloat = 0
    @IBInspectable var borderColor: CGColor = UIColor.tertiarySystemGroupedBackground.cgColor
  
  override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = cornerRadius
    layer.borderWidth = borderWidth
    layer.borderColor = borderColor
  }
}

class DesignableButton: UIButton {
  @IBInspectable var cornerRadius: CGFloat = 0
  @IBInspectable var borderWidth: CGFloat = 0
  @IBInspectable var borderColor: CGColor = UIColor.systemPink.cgColor
  
  override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = cornerRadius
    layer.borderWidth = borderWidth
    layer.borderColor = borderColor
  }
}

class DesignableLabel: UILabel {
  @IBInspectable var cornerRadius: CGFloat = 0
  @IBInspectable var borderWidth: CGFloat = 0
    @IBInspectable var bottomborderWidth: CGFloat = 0
  @IBInspectable var borderColor: CGColor = UIColor.tertiarySystemGroupedBackground.cgColor
  
  override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = cornerRadius
    layer.borderWidth = borderWidth
    layer.borderWidth = bottomborderWidth
    layer.borderColor = borderColor
  }
}

class DesignableTextField: UITextField {
  @IBInspectable var cornerRadius: CGFloat = 0
  @IBInspectable var borderWidth: CGFloat = 0
  @IBInspectable var borderColor: CGColor = UIColor.tertiarySystemGroupedBackground.cgColor
  
  override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = cornerRadius
    layer.borderWidth = borderWidth
    layer.borderColor = borderColor
  }
}

class DesignableImageView: UIImageView {
  @IBInspectable var cornerRadius: CGFloat = 0
  @IBInspectable var borderWidth: CGFloat = 0
  @IBInspectable var borderColor: CGColor = UIColor.tertiarySystemGroupedBackground.cgColor
  
  override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = cornerRadius
    layer.borderWidth = borderWidth
    layer.borderColor = borderColor
  }
}

