//
//  SearchInTVC.swift
//  TeamOmoolen-iOS
//
//  Created by kyoungjin on 2021/07/06.
//
import Foundation
import UIKit
import RealmSwift

class SearchInTVC: UITableViewCell {

    static let identifier = "SearchInTVC"
    
    //MARK: - IB Outlets
    @IBOutlet weak var searchHistoryTableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    //MARK: - Variables
    var enteredText: String?
    var realm: Realm?
    var searchList: Array<String> = []
    var resultArray: Array<String> = []

    //MARK: - Life Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        realm = try? Realm()
        registerXib()
        setSearchList()
        setSearchHistoryTable()
        checkNotification()
        

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - objc Methods
    @objc func removeWord(notification: NSNotification){
        if let word = notification.object as? String {
            do {
                removeFromRealm(target: word)
                searchHistoryTableView.reloadData()
            } catch  {
                print("지워지지 않았습니다")
            }
        }
    }
    
    @objc func allClear() {
        if (searchList.count == 0) {
            print("지울 단어가 없어요")
        }
        do {
            try! realm?.write {
                realm?.deleteAll()
                searchList.removeAll()
                searchList.removeAll()
                searchHistoryTableView.reloadData()
                
            }
        } catch {
            print("지워지지 않았습니다" )
        }
    }
    
    //MARK: - Methods
    func registerXib() {
        let SearchWordNib = UINib(nibName: SearchWordTVC.identifier, bundle: nil)
        let NoRecentNib = UINib(nibName: NoRecentTVC.identifier, bundle: nil)
        let AllClearNib = UINib(nibName: AllClearTVC.identifier, bundle: nil)
        
        searchHistoryTableView.register(SearchWordNib, forCellReuseIdentifier: SearchWordTVC.identifier)
        searchHistoryTableView.register(NoRecentNib, forCellReuseIdentifier: NoRecentTVC.identifier)
        searchHistoryTableView.register(AllClearNib, forCellReuseIdentifier: AllClearTVC.identifier)
    }
    
    func setSearchList(){
        let savedWords = realm?.objects(RecentSearch.self)
        let Results: Results<RecentSearch> = (savedWords)!
        let ResultArray = Results.toArray()
        
        if (ResultArray.count == 0) {
            return
        } else if (ResultArray.count == 1){
            searchList.append(ResultArray[ResultArray.count-1].word)
        } else if (ResultArray.count == 2){
            searchList.append(ResultArray[ResultArray.count-1].word)
            searchList.append(ResultArray[ResultArray.count-2].word)
        } else {
            searchList.append(ResultArray[ResultArray.count-1].word)
            searchList.append(ResultArray[ResultArray.count-2].word)
            searchList.append(ResultArray[ResultArray.count-3].word)
        }
    }
    
    func setSearchHistoryTable() {
        searchHistoryTableView.delegate = self
        searchHistoryTableView.dataSource = self
        searchHistoryTableView.separatorStyle = .none
    }
   
    func checkNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(searchEntered), name: NSNotification.Name("SearchEntered"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(removeWord), name: NSNotification.Name("RemoveWord"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(allClear), name: NSNotification.Name("AllClear"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(returnHome), name: NSNotification.Name("ReturnHome"), object: nil)

    }
    
    @objc func returnHome(notification: NSNotification) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("SearchEntered"), object: nil)
        setSearchList()
    }
    
    
    @objc func searchEntered(notification: NSNotification) {
        
        let enteredText = notification.object as! String
        if enteredText.isEmpty {
            print("검색어를 입력해 주세요")
        } else { do {
            try realm!.write {
                let searchWord = RecentSearch()
                searchWord.word = enteredText
                if (realm?.objects(RecentSearch.self).count == 0) {
                    //처음 입력 받았을때
                    realm?.add(searchWord)
                    print("검색어를 입력해 주세요")
                }
                else if (searchList.contains(searchWord.word)) {
                    print("db 추가할 필요 없음")
                } else {
                    realm?.add(searchWord)
                }
                setSearchList()
            }
        } catch {
            print("문제")
        }
        }
    }
        
    
    func inputData(database: RecentSearch) -> RecentSearch {
        if let text = enteredText {
            database.word = text
        }
        return database
    }
    
    func removeFromRealm(target: String) {
        let targetWord = realm?.objects(RecentSearch.self).filter("word CONTAINS[c] %@", target)
            try! realm?.write {
                if let obj = targetWord {
                    //db에서 지워주기
                    realm?.delete(obj)
                    let idx = searchList.firstIndex(of: target)!
                    searchList.remove(at: idx)
                }
            }
    }
}

//Mark: - Extensions
extension Results {
    func toArray() -> Array<Element> {
        return self.map{$0}
    }
}

extension SearchInTVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (searchList.count == 0) {
            switch indexPath.section {
            case 0:
                return 80 //최근검색어 없음
            case 1:
                return 55 //전체삭제
            default:
                return 50 //나중에 변경
            }
        } else if (searchList.count == 1) {
            switch indexPath.section {
            case 0:
                return 50 //단어 1
            case 1:
                return 55 //전체삭제
            default:
                return 50
            }
        } else if (searchList.count == 2) {
            switch indexPath.section {
            case 0:
                return 50 //단어 1
            case 1:
                return 50 //단어 2
            case 2:
                return 55 //전체삭제
            default:
                return 55
            }
        } else {
            //검색어 세개 다 꽉 찬 경우
            switch indexPath.section {
            case 0:
                return 50
            case 1:
                return 50
            case 2:
                return 50
            case 3:
                return 55
            default:
                return 55
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
        var keyword = ""
        switch indexPath.section {
        case 0:
            if (searchList.count != 0) {
                keyword = searchList[0]
            }
        case 1:
            if (searchList.count != 0 && searchList.count <= 3) {
             keyword = searchList[1]
            }
        case 2:
            if (searchList.count == 3) {
                keyword = searchList[2]
            }
        case 3:
            return
        default:
            return
        }
        /*let indexPath = tableView.indexPathForSelectedRow!

        let currentCell = tableView.cellForRow(at: indexPath)! as UITableViewCell*/
        
        //예외처리: 전체삭제를 눌렀을 때는 그냥 단어를 지워주기만 해야함!
        //검색어 0개면 x
        //1개면 index 0번째만
        //2개면 index 0,1
        //3개면 index 0,1,2만 가능
        /*if (searchList.count == 0 || indexPath.row == searchList.count) {
            //0개이거나 전체삭제 버튼이거나
            return
        }
        print("우리는 여기")
        print(indexPath.row)
         */
        NotificationCenter.default.post(name: NSNotification.Name("RecentToSearchResult"), object: keyword)
    }
}


extension SearchInTVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        
        var num = 0
        if (searchList.count == 0){ //검색어 3개에서 전체 삭제 했을 때 여기로 들어옴
            tableViewHeight.constant = 135
            num = 2
        } else if (searchList.count == 1){
            tableViewHeight.constant = 131
            num = 2
        } else if (searchList.count == 2){
            tableViewHeight.constant = 169
            num = 3
        } else { //검색어 3개
            tableViewHeight.constant = 231
            num = 4
        }
        NotificationCenter.default.post(name: NSNotification.Name("AdjustHeight"), object: tableViewHeight.constant)
        return num
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (searchList.count == 0) {
            switch indexPath.section {
            case 0: //최근검색어 없음
                guard let cell = tableView.dequeueReusableCell(withIdentifier:  NoRecentTVC.identifier, for: indexPath) as? NoRecentTVC else {
                    return UITableViewCell()
                }
                cell.selectionStyle = .none
                return cell
            case 1: //전체삭제 버튼
                guard let cell = tableView.dequeueReusableCell(withIdentifier:  AllClearTVC.identifier, for: indexPath) as? AllClearTVC else {
                    return UITableViewCell()
                }
                cell.selectionStyle = .none
                return cell
            default:
                return UITableViewCell()
            }
        } else if (searchList.count == 1) {
            switch indexPath.section {
            case 0: //단어 1
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchWordTVC.identifier, for: indexPath) as? SearchWordTVC else {
                    return UITableViewCell()
                }
                cell.searchLabel.text = searchList[0]
                cell.selectionStyle = .none

                return cell
            case 1: //전체삭제 버튼
                guard let cell = tableView.dequeueReusableCell(withIdentifier: AllClearTVC.identifier, for: indexPath) as? AllClearTVC else {
                    return UITableViewCell()
                }
                cell.selectionStyle = .none
                return cell
            default:
                return UITableViewCell()
            }
        } else if (searchList.count == 2){
            switch indexPath.section {
            case 0: //단어 1
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchWordTVC.identifier, for: indexPath) as? SearchWordTVC else {
                    return UITableViewCell()
                }
                cell.searchLabel.text = searchList[0]
                cell.selectionStyle = .none
                return cell

            case 1: //단어 2
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchWordTVC.identifier, for: indexPath) as? SearchWordTVC else {
                    return UITableViewCell()
                }
                cell.searchLabel.text = searchList[1]
                cell.selectionStyle = .none
                return cell
            
            case 2: //전체삭제
                guard let cell = tableView.dequeueReusableCell(withIdentifier: AllClearTVC.identifier, for: indexPath) as? AllClearTVC else {
                    return UITableViewCell()
                }
                cell.selectionStyle = .none
                return cell
            default:
                return UITableViewCell()
            }
        } //3개 이상일 경우
            switch indexPath.section {
            case 0: //단어 1
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchWordTVC.identifier, for: indexPath) as? SearchWordTVC else {
                    return UITableViewCell()
                }
                cell.searchLabel.text = searchList[0]
                cell.selectionStyle = .none
                return cell
            
            case 1: //단어 2
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchWordTVC.identifier, for: indexPath) as? SearchWordTVC else {
                    return UITableViewCell()
                }
                cell.searchLabel.text = searchList[1]
                cell.selectionStyle = .none
                return cell
                
            case 2: //단어 3
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchWordTVC.identifier, for: indexPath) as? SearchWordTVC else {
                    return UITableViewCell()
                }
                cell.searchLabel.text = searchList[2]
                cell.selectionStyle = .none
                return cell
                
            case 3: //전체삭제
                guard let cell = tableView.dequeueReusableCell(withIdentifier: AllClearTVC.identifier, for: indexPath) as? SearchWordTVC else {
                return UITableViewCell()
                }
                cell.selectionStyle = .none
                return cell
            default:
                return UITableViewCell()
            }
        }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.reloadData()
    }
    
 
}
