//
//  QuoteDisplayViewController.swift
//  MindfulQuote
//
//  Created by Reshma Unnikrishnan on 20.09.22.
//

import UIKit

enum Language: String, CaseIterable {
    case de, en, nl, fr
}

final class QuoteDisplayViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var languageButton: UIButton!
    @IBOutlet weak var quoteText: UILabel!
    @IBOutlet weak var refreshQuoteButton: UIButton!
    @IBOutlet weak var languagePickerView: UIPickerView!
    
    var language: Language = Language.de
    let viewModel: QuoteDisplayViewModelInput

    // MARK: - Initializer
    init(viewModel: QuoteDisplayViewModelInput) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func selectlanguageButtonTapped(_ sender: Any) {
        self.quoteText.text = ""
        self.languagePickerView.isHidden = false
    }
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
        self.quoteText.text = ""
        loadQuote()
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.languagePickerView.delegate = self

        loadQuote()
        setupUI()
    }
    
    // MARK: - Private Methods
    fileprivate func loadQuote() {
        viewModel.fetchQuote(lang: language.rawValue) { [weak self] in
            guard let self = self else {
                return
            }
            self.quoteText.text = self.viewModel.quoteText
        }
    }

    private func setupUI() {
        self.languageButton.titleLabel?.text = language.rawValue
        self.quoteText.numberOfLines = 0
        self.languageButton.backgroundColor = .lightGray
        self.languagePickerView.isHidden = true
    }
}

// MARK: - UIPickerViewDelegate & UIPickerViewDataSource
extension QuoteDisplayViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Language.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Language.allCases[row].rawValue //dropdown item
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.languagePickerView.isHidden = true
        let languageStat = Language.allCases[row].rawValue
        languageButton.titleLabel?.text = languageStat
        language = Language.allCases[row]
        viewModel.fetchQuote(lang: languageStat) {
            self.quoteText.text = self.viewModel.quoteText
        }
    }
}
