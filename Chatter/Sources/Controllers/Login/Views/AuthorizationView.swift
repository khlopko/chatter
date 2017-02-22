//
//  AuthorizationView.swift
//  Chatter
//
//  Created by Kirill Khlopko on 2/22/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import UIKit

class AuthorizationView: UIView {

    var title: String? {
        get { return titleLabel.text }
        set { titleLabel.text = newValue }
    }
    var email: String {
        return emailField.text ?? ""
    }
    var password: String {
        return passwordField.text ?? ""
    }
    var mainButtonTitle: String? {
        get { return mainButton.title(for: .normal) }
        set { mainButton.setTitle(newValue, for: .normal) }
    }
    var secondaryButtonTitle: String? {
        get { return secondaryButton.title(for: .normal) }
        set { secondaryButton.setTitle(newValue, for: .normal) }
    }
    var isSecondaryButtonHidden: Bool {
        get { return secondaryButton.isHidden }
        set { secondaryButton.isHidden = newValue }
    }
    var isProcessing: Bool {
        get { return indicator.isAnimating }
        set {
            isUserInteractionEnabled = !newValue
            if newValue {
                indicator.startAnimating()
            } else {
                indicator.stopAnimating()
            }
        }
    }

    private let titleLabel = Static.makeTitleLabel()
    private let emailField = Static.makeEmailField()
    private let passwordField = Static.makePasswordField()
    private let mainButton = Static.makeMainButton()
    private let secondaryButton = Static.makeSecondaryButton()
    private let indicator = Static.makeIndicator()

    private var all: [UIView] {
        return [titleLabel, indicator] + items
    }
    private var items: [UIView] {
        return [emailField, passwordField, mainButton, secondaryButton,]
    }

    fileprivate let chain = UITextField.Chain()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        all.forEach(addSubview)
        [passwordField, emailField,].forEach {
            chain.appendField($0)
            $0.delegate = self
        }
#if DEBUG
        emailField.text = "khlopko@gmail.com"
        passwordField.text = "12345678"
#endif
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateLayout()
    }

    @discardableResult
    override func becomeFirstResponder() -> Bool {
        return chain.first?.becomeFirstResponder() ?? false
    }

    // MARK: - Interface

    func addMainAction(_ action: Selector, target: AnyObject?) {
        mainButton.addTarget(target, action: action, for: .touchUpInside)
    }

    func addSecondaryAction(_ action: Selector, target: AnyObject?) {
        mainButton.addTarget(target, action: action, for: .touchUpInside)
    }

    func setEnabled(_ enabled: Bool, animated: Bool = true) {
        let builder = Animations(duration: animated ? 0.3 : 0)
        if enabled {
            items.forEach {
                $0.alpha = 0
                $0.isHidden = false
            }
        } else {
            builder.completion { _ in
                self.items.forEach { $0.isHidden = true }
            }
        }
        let alpha: CGFloat = enabled ? 1 : 0
        let titleColor: UIColor = enabled ? .v28 : .lightGray
        builder.run {
            self.items.forEach { $0.alpha = alpha }
            self.titleLabel.textColor = titleColor
        }
    }

    // MARK: - Private

    // MARK: - Layout

    private func updateLayout() {
        titleLabel.frame = CGRect(
            x: 0, y: 0, width: bounds.width, height: ceil(titleLabel.font.lineHeight))

        var y: CGFloat = titleLabel.frame.maxY + bounds.height * 0.08
        for view in [emailField, passwordField] {
            view.frame = CGRect(x: 0, y: y, width: bounds.width, height: 40)
            y = view.frame.maxY + bounds.height * 0.03
        }
        y += bounds.height * 0.04
        for view in [mainButton, secondaryButton] {
            view.frame = CGRect(x: 0, y: y, width: bounds.width, height: 44)
            y = view.frame.maxY + bounds.height * 0.01
        }
        indicator.frame = CGRect(
            x: mainButton.frame.minX, y: secondaryButton.frame.maxY,
            width: mainButton.frame.width, height: mainButton.frame.width)
    }

    // MARK: - Make views

    private static func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.font = Font.bold.withSize(34)
        return label
    }

    private static func makeEmailField() -> UITextField {
        let field = makeField()
        field.keyboardType = .emailAddress
        field.returnKeyType = .next
        field.placeholder = "Email"
        return field
    }

    private static func makePasswordField() -> UITextField {
        let field = makeField()
        field.returnKeyType = .done
        field.isSecureTextEntry = true
        field.placeholder = "Password"
        return field
    }

    private static func makeField() -> UITextField {
        let field = UnderlinedTextField()
        field.font = Font.light.withSize(16)
        field.lineColor = .lightGray
        field.lineHeight = 1
        field.textColor = .v28
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        return field
    }

    private static func makeMainButton() -> UIButton {
        let button = UIButton()
        button.setTitleColor(.v28, for: .normal)
        button.titleLabel?.font = Font.regular.withSize(12)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.v28.cgColor
        return button
    }

    private static func makeSecondaryButton() -> UIButton {
        let button = UIButton()
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = Font.light.withSize(13)
        return button
    }

    private static func makeIndicator() -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView(activityIndicatorStyle: .white)
        view.color = .v28
        view.hidesWhenStopped = true
        view.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        return view
    }
}

// MARK: - UITextFieldDelegate

extension AuthorizationView: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let next = chain.next {
            return next.becomeFirstResponder()
        } else {
            chain.reset()
            return textField.resignFirstResponder()
        }
    }
}
