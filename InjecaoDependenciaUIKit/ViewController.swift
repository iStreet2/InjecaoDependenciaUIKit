//
//  ViewController.swift
//  InjecaoDependenciaUIKit
//
//  Created by Gabriel Vicentin Negro on 08/11/24.
//

import UIKit

class ViewController: UIViewController {

    var viewModel: ViewModelProtocol
    var data: String = ""

    // Elementos da interface
    private let getDataButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Get data!", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let dataLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Reset", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    init(viewModel: ViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupActions()
    }

    // Configuração das views
    private func setupViews() {
        view.addSubview(getDataButton)
        view.addSubview(dataLabel)
        view.addSubview(resetButton)

        NSLayoutConstraint.activate([
            getDataButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            getDataButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            getDataButton.widthAnchor.constraint(equalToConstant: 120),
            getDataButton.heightAnchor.constraint(equalToConstant: 50),

            dataLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dataLabel.topAnchor.constraint(equalTo: getDataButton.bottomAnchor, constant: 20),

            resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resetButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20),
            resetButton.widthAnchor.constraint(equalToConstant: 120),
            resetButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    // Configuração das ações dos botões
    private func setupActions() {
        getDataButton.addTarget(self, action: #selector(getDataTapped), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetTapped), for: .touchUpInside)
    }

    // Ações dos botões
    @objc private func getDataTapped() {
        viewModel.getData { [weak self] data in
            guard let self = self else { return }
            self.data = data

            // Animação
            UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut) {
                self.dataLabel.text = data
                self.getDataButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            } completion: { _ in
                UIView.animate(withDuration: 0.3) {
                    self.getDataButton.transform = .identity
                }
            }
            
            // Animação de scale no texto
            self.dataLabel.text = data
            self.dataLabel.transform = CGAffineTransform(scaleX: 0.5, y: 0.5) // Texto começa menor
            
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                usingSpringWithDamping: 0.5,
                initialSpringVelocity: 1,
                options: .curveEaseInOut,
                animations: {
                    self.dataLabel.transform = .identity // Texto volta ao tamanho original com animação
                }
            )
        }
    }
    
    @objc private func resetTapped() {
        // Animação para o texto encolher antes de desaparecer
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 1,
            options: .curveEaseInOut,
            animations: {
                self.dataLabel.transform = CGAffineTransform(scaleX: 0.5, y: 0.5) // Texto encolhe
                self.dataLabel.alpha = 0 // Texto fica invisível
            },
            completion: { _ in
                // Após a animação, redefina o texto e volte ao estado original
                self.data = ""
                self.dataLabel.text = ""
                self.dataLabel.transform = .identity // Restaura o tamanho original
                self.dataLabel.alpha = 1 // Restaura a opacidade
            }
        )
    }
}

#Preview {
    ViewController(viewModel: ViewModelMock())
}

