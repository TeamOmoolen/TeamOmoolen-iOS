//
//  PopupModalVC.swift
//  TeamOmoolen-iOS
//
//  Created by kimhyungyu on 2021/07/12.
//

import UIKit

class PopupModalVC: UIViewController {

    // MARK: - Properties
    var titleText: String?
    var subtitleText: String?
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var popupTitle: UILabel!
    @IBOutlet weak var popupSubtitle: UILabel!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - @IBAction Properties
    @IBAction func dismissToSuggest(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Methods
    private func setUI() {
        
        popupTitle.attributedText = NSAttributedString(string: titleText!, attributes: [.kern: -0.95])

        popupView.layer.cornerRadius = 10
        popupTitle.adjustsFontSizeToFitWidth = true
        popupTitle.font = UIFont(name: "NotoSansCJKKr-Bold", size: 19)
        popupTitle.numberOfLines = 10
        popupSubtitle.font = UIFont(name: "NotoSansCJKKr-Regular", size: 12)
        popupSubtitle.attributedText = NSAttributedString(string: subtitleText!, attributes: [.kern: -0.3])
        popupSubtitle.textColor = .omSecondGray
        popupSubtitle.numberOfLines = 10
        popupTitle.text = titleText
        popupSubtitle.text = subtitleText
    }
}
