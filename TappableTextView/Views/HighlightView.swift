//
//  HighlightView.swift
//  TappableTextView
//
//  Created by Willie Johnson on 5/15/18.
//  Copyright © 2018 Willie Johnson. All rights reserved.
//

import UIKit

class HighlightView: UIView {
  @IBOutlet var contentView: UILabel!
  var word: Word!
  var tapped: Bool = false
  
  @IBInspectable var color: UIColor? {
    didSet {
      contentView.backgroundColor = color
    }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }

  convenience init(word: Word) {
    self.init(frame: word.rect)
    self.word = word
    contentView.text = word.text
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupView()
  }
}

// MARK: - Animations
extension HighlightView {
  func expandAnimation() {
    /* Do Animations */
    CATransaction.begin()
    CATransaction.setAnimationDuration(0.2)
    CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut))

    // View animations
    contentView.backgroundColor = .black
    UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: [.curveEaseInOut, .allowUserInteraction], animations: {
      self.transform = .identity
      self.contentView.backgroundColor = self.color
    }, completion: nil)

    // Layer animations
    let cornerAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.cornerRadius))
    cornerAnimation.fromValue = 0
    cornerAnimation.toValue = frame.height / 4

    contentView.layer.cornerRadius = frame.height / 4
    contentView.layer.add(cornerAnimation, forKey: #keyPath(CALayer.cornerRadius))

    CATransaction.commit()
  }
}

// MARK: - Helper methods
private extension HighlightView {
  /// Configure the UITextView with the required gestures to make text in the view tappable.
  func setupView() {
    backgroundColor = .clear
//    layer.cornerRadius = frame.height / 4
//    layer.shadowOpacity = 0.5
    let randomHue = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
//    layer.shadowColor = UIColor(hue: randomHue, saturation: 0.6, brightness: 0.6, alpha: 1).cgColor
//    layer.shadowRadius = 2
//    layer.shadowOffset = CGSize(width: 0, height: 2)
    contentView = loadNib(viewType: UILabel.self)
    addSubview(contentView)
    contentView.constrain(to: self)
    contentView.clipsToBounds = true
    contentView.textColor = UIColor(hue: randomHue, saturation: 0.9, brightness: 0.3, alpha: 1)
    color = UIColor(hue: randomHue, saturation: 0.6, brightness: 0.9, alpha: 1)
  }
}
