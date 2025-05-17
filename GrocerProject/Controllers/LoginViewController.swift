//
//  LoginViewController.swift
//  GrocerProject
//
//  Created by Farooq Ahmad on 17/05/2025.
//

import UIKit

class LoginViewController: UIViewController {
    private let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter valid email"
        tf.borderStyle = .roundedRect
        tf.autocapitalizationType = .none
        return tf
    }()

    private let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter valid password"
        tf.isSecureTextEntry = true
        tf.borderStyle = .roundedRect
        return tf
    }()

    private let loginButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Login", for: .normal)
        btn.backgroundColor = UIColor(red: 52/255, green: 199/255, blue: 89/255, alpha: 1.0)
        btn.tintColor = .white
        btn.layer.cornerRadius = 5
        btn.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return btn
    }()

    private let errorLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .red
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        return lbl
    }()

    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        return indicator
    }()

    private let viewModel: LoginViewModel

    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindViewModel()
        addTextFieldTargets()
    }

    private func setupViews() {
        view.backgroundColor = .white

        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton, errorLabel, activityIndicator])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        loginButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        loginButton.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
    }

    private func bindViewModel() {
        viewModel.onLoginSuccess = { [weak self] in
            DispatchQueue.main.async {
                self?.errorLabel.text = ""
                let homeVC = HomeViewController()
                let navController = UINavigationController(rootViewController: homeVC)

                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = windowScene.windows.first {
                    window.rootViewController = navController
                    window.makeKeyAndVisible()
                }
            }
        }

        viewModel.onLoginFailure = { [weak self] error in
            DispatchQueue.main.async {
                self?.errorLabel.text = error
            }
        }

        viewModel.onLoadingStateChange = { [weak self] isLoading in
            DispatchQueue.main.async {
                isLoading ? self?.activityIndicator.startAnimating() : self?.activityIndicator.stopAnimating()
            }
        }

        viewModel.onEmailValidation = { [weak self] error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.errorLabel.text = error
                } else {
                    self?.errorLabel.text = ""
                }
            }
        }

        viewModel.onPasswordValidation = { [weak self] error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.errorLabel.text = error
                } else {
                    self?.errorLabel.text = ""
                }
            }
        }
    }

    private func addTextFieldTargets() {
        emailTextField.addTarget(self, action: #selector(emailTextFieldsDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldsDidChange), for: .editingChanged)
    }

    @objc private func emailTextFieldsDidChange() {
        viewModel.liveValidateForEmail(email: emailTextField.text ?? "")
    }
    
    @objc private func passwordTextFieldsDidChange() {
        viewModel.liveValidateForPassword(password: passwordTextField.text ?? "")
    }

    @objc private func handleLogin() {
        viewModel.login(email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
    }
}
