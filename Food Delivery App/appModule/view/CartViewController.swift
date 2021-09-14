//
//  CartViewController.swift
//  Food Delivery App
//
//  Created by Maheesha De Silva on 2021-09-13.
//

import UIKit
import RxSwift
import RxCocoa

class CartViewController: UIViewController, UIScrollViewDelegate {

    var presenter:   CartViewToPresenterProtocol?

    @IBOutlet weak var collectionView   : UICollectionView!
    @IBOutlet weak var scrollView       : UIScrollView!
    @IBOutlet weak var tableView        : UITableView!
    @IBOutlet weak var totalAmount      : UILabel!
    
    var cartItems : [HomeItemModel] = []
    
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    var itemHeight : CGFloat = 80
    
    let disposeBag = DisposeBag()
    let items       : BehaviorRelay<[HomeItemModel]> = BehaviorRelay(value: [])
    
    let sectionItems    = ["Cart", "Orders", "Information"]
    let sections        : BehaviorRelay<[String]>        = BehaviorRelay(value: [])
    
    var selectFirstItem = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.delegate = self        
        collectionView.delegate = self

        tableView.rowHeight = itemHeight
        
        bindTableView(itemArray: self.cartItems)
        self.dataDidChange()
        
        bindCollectionView(sectionItems: self.sectionItems)
    }
    
    func dataDidChange() {
        var total = 0.0
        
        for (_, element) in self.cartItems.enumerated() {
            total += element.priceInUSD ?? 0
        }
        
        self.totalAmount.text = "\(total) USD"
        tableViewHeightConstraint.constant = itemHeight * CGFloat(self.cartItems.count)
    }
    
    // Bind Table view
    func bindTableView(itemArray: [HomeItemModel]) {
        self.items.accept(itemArray)
        // Set table view delegate
        tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
            
        // Bind items array and tableview
        items.asObservable()
            .bind(to: tableView.rx
                .items(cellIdentifier: "cartTVCell", cellType: CartItemTVCell.self))
            { index, element, cell in
                
                LoadImage(urlString: element.imageURL ?? "", imageView: cell.itemImg).execute()
                
                cell.titleLbl.text = element.title
                cell.priceLbl.text = "\(element.priceInUSD ?? 0) USD"
                
                cell.callback = {
                    Alert.init(title: "Confirm", msg: "Do you want to delete this item?", vc: self, b1Name: "Yes", b2Name: "No").show(completion:{
                    (clicked_on) in
                        if clicked_on == 1 {
                            self.cartItems.remove(at: index)
                            self.items.accept(self.cartItems)
                            
                            self.dataDidChange()
                            
                            if self.cartItems.count == 0 {
                                self.presenter?.goBackToPrevController(navigationController: self.navigationController!, cartItems: [])
                            }
                        }
                    })
                }
        }.disposed(by: disposeBag)
    }
    
    private func bindCollectionView(sectionItems: [String]) {
        self.sections.accept(sectionItems)
        
        sections.bind(to: collectionView.rx.items(cellIdentifier: "cartCVCell", cellType: CartSectionCVCell.self)) { (index, element, cell) in
            cell.cellTitle.text = element
            
            if index == 0 {
                cell.isSelected = true
            } else {
                cell.isSelected = false
            }
            
        }.disposed(by: disposeBag)
        
        collectionView.rx.itemSelected.subscribe(onNext:{ indexPath in
                    
        }).disposed(by: disposeBag)
    }
}

// IBActions
extension CartViewController {
    @IBAction func backBtnClicked(_ sender: UIButton) {
        presenter?.goBackToPrevController(navigationController: self.navigationController!, cartItems: self.cartItems)
    }
}

extension CartViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = self.sectionItems[indexPath.row]
        let itemSize = item.getItemSize(font: UIFont.boldSystemFont(ofSize: 30))
        return CGSize(width: itemSize.width + 50, height: self.view.frame.height*8/100)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if selectFirstItem {
            selectFirstItem = false
            let selectedIndexPath = IndexPath(item: 0, section: 0)
            collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: [])
        }
    }
}
