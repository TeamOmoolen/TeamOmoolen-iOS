//
//  NewLensCVC.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/05.
//

import UIKit

class NewLensCVC: UICollectionViewCell {
    static let identifier = "NewLensCVC"
    
    // MARK: - UI Components
    
    @IBOutlet weak var modelImageView: UIImageView!
    @IBOutlet weak var brandImageView: UIImageView!
    
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var lensLabel: UILabel!
    
    @IBOutlet weak var newLensTableView: UITableView!
    
    // MARK: - Local Variables
    
    var newLens = [NewLensDetailData]()
    private var tableList = [NewLensDetailData]()
    
    // MARK: - Life Cycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
        
        registerXib()
        setTableView()
    }
    
}

extension NewLensCVC {
    func setUI() {
        contentView.backgroundColor = .white
        
        modelImageView.layer.cornerRadius = 10
        modelImageView.layer.masksToBounds = true
        modelImageView.contentMode = .scaleAspectFit
        
        brandImageView.layer.cornerRadius = brandImageView.frame.width / 2
        brandImageView.layer.masksToBounds = true
        
        brandLabel.textColor = .omWhite
        brandLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 16)

        lensLabel.textColor = .omWhite
        lensLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 14)
    }
    
    func registerXib() {
        let detailNib = UINib(nibName: NewLensDetailTVC.identifier, bundle: nil)
        newLensTableView.register(detailNib, forCellReuseIdentifier: NewLensDetailTVC.identifier)
    }
    
    func setTableView() {
        newLensTableView.delegate = self
        newLensTableView.dataSource = self
        
        newLensTableView.separatorStyle = .none
        
        newLensTableView.isScrollEnabled = false
    }
    
    func initCell(lensData: [NewLensDetailData]) {
        newLens = lensData
        brandLabel.text = newLens.first?.brand
        lensLabel.text = newLens.first?.name
        
        guard let lensString = newLens.first?.imageList[1] else { return }
        let lensUrl = URL(string: lensString) ?? URL(string: "")
        self.modelImageView.kf.setImage(with: lensUrl)
        
        tableList.append(lensData[1])
        tableList.append(lensData[2])
        tableList.append(lensData[3])
        
        newLensTableView.reloadData()
    }
}

extension NewLensCVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = tableView.frame.height / 3
        return height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: NSNotification.Name("PushToDetailVC"), object: tableList[indexPath.row].id)
    }
}

extension NewLensCVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewLensDetailTVC.identifier) as? NewLensDetailTVC else {
            return UITableViewCell()
        }
        let data = tableList[indexPath.row]
        cell.initCell(brand: data.brand, name: data.name, price: data.price, imageList: data.imageList)
        return cell
    }
    
}
