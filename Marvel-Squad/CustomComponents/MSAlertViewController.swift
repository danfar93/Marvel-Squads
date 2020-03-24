//
//  MSAlertViewController.swift
//  Marvel-Squad
//
//  Created by Daniel Farrell on 22/03/2020.
//  Copyright © 2020 Daniel Farrell. All rights reserved.
//


import UIKit

class MSAlertViewController: UIViewController {
    
    let containerView = UIView()
    let titleLabel = MSTitleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel = MSBodyLabel(textAlignment: .center)
    let dismissButton = MSButton(backgroundColor: .systemGray2, title: "Dismiss")
    let confirmButton = MSButton(backgroundColor: .systemRed, title: "Confirm")

    let notificationGenerator = UINotificationFeedbackGenerator()
    
    var alertTitle: String?
    var message: String?
    var dismissButtonTitle: String?
    var confirmButtonTitle: String?
    
    let padding: CGFloat = 20
    let newPadding: CGFloat = 70
    
    init(title: String, message: String, dismissButtonTitle: String, confirmButtonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.message = message
        self.dismissButtonTitle = dismissButtonTitle
        self.confirmButtonTitle = confirmButtonTitle
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        configureContainerView()
        configureTitleLabel()
        configureDismissButton()
        configureActionButton()
        configureMessageLabel()
    }

    /*
     * Configuring container view & constraints for
     * custom alert view.
     */
    func configureContainerView() {
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 16
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    
    /*
     * Configuring titleLabel view & constraints for
     * custom alert view.
     */
    func configureTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.text = alertTitle ?? "Something went wrong"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    
    /*
     * Configuring dismissButton view & constraints for
     * custom alert view.
     */
    func configureDismissButton() {
        containerView.addSubview(dismissButton)
        dismissButton.setTitle(dismissButtonTitle ?? "Dismiss", for: .normal)
        dismissButton.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            dismissButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            dismissButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            dismissButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            dismissButton.heightAnchor.constraint(equalToConstant: 44)
            
        ])
    }
    
    
    /*
     * Configuring actionButton view & constraints for
     * custom alert view.
     */
    func configureActionButton() {
        containerView.addSubview(confirmButton)
        confirmButton.setTitle(confirmButtonTitle ?? "", for: .normal)
        confirmButton.addTarget(self, action: #selector(confirmFireSquadMember), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            confirmButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -newPadding),
            confirmButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            confirmButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            confirmButton.heightAnchor.constraint(equalToConstant: 44)
            
        ])
    }
    
    
    /*
     * Configuring messageLabel view & constraints for
     * custom alert view.
     */
    func configureMessageLabel() {
        containerView.addSubview(messageLabel)
        messageLabel.text = message ?? ""
        messageLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            messageLabel.bottomAnchor.constraint(equalTo: confirmButton.topAnchor, constant: -12)
 
        ])
    }
    
    
    @objc func dismissAlert() {
        dismiss(animated: true)
    }

    
    /*
     * Sends NSNotification when actionButton (confirm) is pressed
     * and provides haptic feedback to user.
     */
    @objc func confirmFireSquadMember() {
        notificationGenerator.notificationOccurred(.success)
        NotificationCenter.default.post(name: Notification.Name("FireSquadMemberNotification"), object: nil)
        dismiss(animated: true)
    }
    
}

