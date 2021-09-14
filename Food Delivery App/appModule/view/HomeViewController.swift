//
//  HomeViewController.swift
//  Food Delivery App
//
//  Created by Maheesha De Silva on 2021-09-10.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    
    var presenter:   HomeViewToPresenterProtocol?
    
    @IBOutlet var scroll_view           : UIScrollView!
    @IBOutlet var page_control          : UIPageControl!
    @IBOutlet weak var scrollView       : UIScrollView!
    @IBOutlet weak var pizzaBtn         : UIButton!
    @IBOutlet weak var pastaBtn         : UIButton!
    @IBOutlet weak var sidesBtn         : UIButton!
    @IBOutlet weak var spicyBtn         : UIButton!
    @IBOutlet weak var veganBtn         : UIButton!
    @IBOutlet weak var cartBtn          : UIButton!
    @IBOutlet weak var itemsNoLbl       : UILabel!
    @IBOutlet weak var tableView        : UITableView!
    
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    var itemHeight : CGFloat = 0
    
    let pageControlPagesCount = 3
    
    var spicyFilterOn = false
    var veganFilterOn = false
    
    let mainTitleArray = ["Saturday\ndiscount", "Tuesday\ndiscount", "Friday\ndiscount"]
    let miniTitleArray = ["Coca-cola as a gift to any order", "There is a free drink to order", "Roll as a gift to any of pasta"]
    
    let disposeBag = DisposeBag()
    let items: BehaviorRelay<[HomeItemModel]> = BehaviorRelay(value: [])
    
    var data            : [HomeItemModel] = []
    var filteredData    : [HomeItemModel] = []
    
    var cartItems       : [HomeItemModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the scroll view's delegate to view controller
        scroll_view.delegate = self
        scrollView.delegate = self
        
        updatePageControl()
        
        bindTableView(itemArray: self.filteredData)
        
        // Fetching the pizza data
        presenter?.fetchData(category: .pizza)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if #available(iOS 11.0, *) {
            scroll_view.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        super.viewWillAppear(true)
    }
    
    // Filtering the data
    func applyFilters() {
        var dataAfterFiltering: [HomeItemModel] = []
        
        for (_, element) in self.data.enumerated() {
            if spicyFilterOn && veganFilterOn {
                if element.isSpice ?? false && element.isVegetarian ?? false {
                    dataAfterFiltering.append(element)
                }
            } else if spicyFilterOn {
                if element.isSpice ?? false {
                    dataAfterFiltering.append(element)
                }
            } else if veganFilterOn {
                if element.isVegetarian ?? false {
                    dataAfterFiltering.append(element)
                }
            } else {
                dataAfterFiltering = self.data
            }
        }
        
        self.filteredData = dataAfterFiltering
        self.items.accept(self.filteredData)
    }
    
    // Bind Table view
    func bindTableView(itemArray: [HomeItemModel]) {
        
        self.filteredData = itemArray
        self.items.accept(self.filteredData)
        // Set table view delegate
        tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
            
        // Bind items array and tableview
        items.asObservable()
            .bind(to: tableView.rx
                .items(cellIdentifier: "itemCell", cellType: ItemTVCell.self))
            { index, element, cell in
                
                LoadImage(urlString: element.imageURL ?? "", imageView: cell.itemImg).execute()
                
                cell.titleLbl.text = element.title
                cell.descriptionLbl.text = element.description
                cell.addBtn.setTitle("\(element.priceInUSD ?? 0) USD", for: .normal)
                cell.addBtn.tag = index
                cell.infoLbl.text = "\(element.weight ?? ""), \(element.size ?? "")"
                
                cell.callback = {
                    self.cartItems.append(self.filteredData[index])
                    self.cartBtn.isHidden = false
                    self.itemsNoLbl.isHidden = false
                    self.itemsNoLbl.text = "\(self.cartItems.count)"
                }
                
                if element.isSpice ?? false {
                    cell.indicatorView.backgroundColor = UIColor(named: "primary-red")
                } else {
                    cell.indicatorView.backgroundColor = UIColor(named: "primary-green")
                }
        }.disposed(by: disposeBag)
    }
    
    func cartItemsChanged(items: [HomeItemModel]) {
        self.cartItems = items
        self.itemsNoLbl.text = "\(self.cartItems.count)"
        
        if self.cartItems.count == 0 {
            self.itemsNoLbl.isHidden = true
        }
    }
}

// HomeViewType Protocol stubs
extension HomeViewController: HomeViewType {
    func showLoading() {
        AppUtils.showProgressIndicator(view: self.view)
    }
    
    func hideLoading() {
        AppUtils.hideProgressIndicator(view: self.view)
    }
    
    func displayAlert() {
        Alert.init(title: "Alert", msg: "Something went wrong!", vc: self).show(completion: {_ in})
    }
}

// HomePresenterToView Protocol stubs
extension HomeViewController: HomePresenterToViewProtocol {
    func showData(data: Array<HomeItemModel>) {
        self.data = data
        self.filteredData = data
        self.items.accept(self.filteredData)
        AppUtils.hideProgressIndicator(view: self.view)
    }
}

// Table view delegate methods
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.estimatedRowHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if itemHeight < cell.frame.size.height {
            itemHeight = cell.frame.size.height
        }
        
        tableViewHeightConstraint.constant = itemHeight * CGFloat(self.filteredData.count)
    }
}

// Scroll view delegate methods
extension HomeViewController: UIScrollViewDelegate {
    // Set the current page of the page control
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        page_control.currentPage = Int(pageNumber)
    }
    
    // Show the hidden cart button when scrolling begin
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        let contentYoffset = self.scrollView.contentOffset.y
        
        if contentYoffset > 0 && self.cartBtn.isHidden {
            UIView.animate(withDuration: 2.0) {
                self.cartBtn.isHidden = false
            }
        }
    }
}

// IBActions
extension HomeViewController {
    @IBAction func pizzaBtnClicked(_ sender: UIButton) {
        changeBtnTextColor(clickedBtn: sender)
        clearFilterSelections()
        
        // Fetching the pizza data
        presenter?.fetchData(category: .pizza)
    }
    
    @IBAction func pastaBtnClicked(_ sender: UIButton) {
        changeBtnTextColor(clickedBtn: sender)
        clearFilterSelections()
        
        // Fetching the pasta data
        presenter?.fetchData(category: .pasta)
    }
    
    @IBAction func sidesBtnClicked(_ sender: UIButton) {
        changeBtnTextColor(clickedBtn: sender)
        clearFilterSelections()
        
        // Fetching the pasta data
        presenter?.fetchData(category: .sides)
    }
    
    // Activate the spicy filter
    @IBAction func spicyBtnClicked(_ sender: UIButton) {
        changeBtnSettings(button: spicyBtn, status: spicyFilterOn, isSpicyVar: true)
    }
    
    // Activate the vegan filter
    @IBAction func veganBtnClicked(_ sender: UIButton) {
        changeBtnSettings(button: veganBtn, status: veganFilterOn, isSpicyVar: false)
    }
    
    // Cart button clicked action
    @IBAction func cartBtnClicked(_ sender: UIButton) {
        // Go To Cart View if cart is not empty
        if self.cartItems.count > 0 {
            self.presenter?.showCartController(navigationController: self.navigationController!, cartItems: self.cartItems)
        }
    }
}

// UI Changes
extension HomeViewController {
    
    // Update page control
    func updatePageControl() {
        
        scroll_view.isPagingEnabled = true
        scroll_view.showsHorizontalScrollIndicator = false
        scroll_view.showsVerticalScrollIndicator = false
        
        page_control.numberOfPages = pageControlPagesCount
        page_control.currentPage = 0
                
        for i in (0..<pageControlPagesCount) {
            
            let imageView = UIImageView()
            imageView.frame = CGRect(x: i * Int(self.view.frame.width) , y: 0 , width: Int(self.view.frame.size.width) , height: Int(self.scroll_view.frame.height))

            imageView.clipsToBounds = true
            imageView.contentMode = UIView.ContentMode.scaleAspectFill
            imageView.alpha = 0.8

            imageView.image = UIImage(named: "main-background")
            
            let x1 = (self.view.frame.width - self.view.frame.size.width*8/10)/2
            let y1 = (self.scroll_view.frame.height - self.view.frame.size.width)/2
            
            let roundView = UIView()
            roundView.frame = CGRect(x: i * Int(self.view.frame.width) + Int(x1) , y: Int(y1) , width: Int(self.view.frame.size.width*8/10) , height: Int(self.view.frame.size.width*8/10))
            roundView.center = CGPoint(x: CGFloat(i * Int(self.view.frame.width)) + self.view.center.x, y: self.scroll_view.center.y)
            roundView.makeRound()
            roundView.backgroundColor = UIColor(named: "primary-red")
            
            let waveImg = UIImage(named: "wave-image")
            let newWidth = self.view.frame.size.width*3/4
            let newHeight = newWidth * (waveImg?.size.height ?? 0) / (waveImg?.size.width ?? 0)
            
            let wave1 = UIImageView()
            wave1.frame = CGRect(x: 0 , y: 0 , width: newWidth , height: newHeight)
            wave1.center = CGPoint(x: 0, y: self.view.frame.height*5/10)
            wave1.clipsToBounds = true
            wave1.contentMode = UIView.ContentMode.scaleAspectFill
            wave1.image = waveImg
            
            let wave2 = UIImageView()
            wave2.frame = CGRect(x: 0 , y: 0 , width: newWidth , height: newHeight)
            wave2.center = CGPoint(x: self.view.frame.width, y: self.view.frame.height*2/10)
            wave2.clipsToBounds = true
            wave2.contentMode = UIView.ContentMode.scaleAspectFill
            wave2.image = waveImg
            
            let wave3 = UIImageView()
            wave3.frame = CGRect(x: 0 , y: 0 , width: newWidth , height: newHeight)
            wave3.center = CGPoint(x: self.view.frame.width*2, y: self.view.frame.height*5/10)
            wave3.clipsToBounds = true
            wave3.contentMode = UIView.ContentMode.scaleAspectFill
            wave3.image = waveImg
            
            let wave4 = UIImageView()
            wave4.frame = CGRect(x: 0 , y: 0 , width: newWidth , height: newHeight)
            wave4.center = CGPoint(x: self.view.frame.width*3, y: self.view.frame.height*2/10)
            wave4.clipsToBounds = true
            wave4.contentMode = UIView.ContentMode.scaleAspectFill
            wave4.image = waveImg
            
            var itemSize = "Kazarov\nDelivery".getItemSize(font: UIFont(name: "OpenSans-SemiBold", size: 14) ?? UIFont.preferredFont(forTextStyle: .largeTitle))
            
            let infoLabel = UILabel(frame: CGRect(x: 0, y: 0, width: itemSize.width, height: itemSize.height))
            infoLabel.center = CGPoint(x: roundView.center.x, y: roundView.frame.origin.y - 40)
            infoLabel.font = UIFont(name: "OpenSans-SemiBold", size: 14)
            infoLabel.textAlignment = .center
            infoLabel.textColor = .white
            infoLabel.numberOfLines = 2
            infoLabel.text = "Kazarov\nDelivery"
            
            itemSize = mainTitleArray[i].getItemSize(font: UIFont(name: "OpenSans-Bold", size: 40) ?? UIFont.preferredFont(forTextStyle: .largeTitle))
            
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: itemSize.width, height: itemSize.height))
            label.center = CGPoint(x: roundView.center.x, y: roundView.center.y)
            label.font = UIFont(name: "OpenSans-Bold", size: 40)
            label.textAlignment = .center
            label.textColor = .white
            label.numberOfLines = 2
            label.text = mainTitleArray[i]
            label.setLineHeight(lineHeight: 0.7)
            
            itemSize = miniTitleArray[i].getItemSize(font: UIFont(name: "OpenSans-Regular", size: 12) ?? UIFont.preferredFont(forTextStyle: .largeTitle))
            
            let label1 = UILabel(frame: CGRect(x: 0, y: 0, width: itemSize.width, height: itemSize.height))
            label1.center = CGPoint(x: roundView.center.x, y: label.frame.origin.y + label.frame.height)
            label1.font = UIFont(name: "OpenSans-Regular", size: 12)
            label1.textAlignment = .center
            label1.textColor = .white
            label1.numberOfLines = 1
            label1.text = miniTitleArray[i]

            self.scroll_view.addSubview(imageView)
            self.scroll_view.addSubview(roundView)
            self.scroll_view.addSubview(wave1)
            self.scroll_view.addSubview(wave2)
            self.scroll_view.addSubview(wave3)
            self.scroll_view.addSubview(wave4)
            self.scroll_view.addSubview(infoLabel)
            self.scroll_view.addSubview(label)
            self.scroll_view.addSubview(label1)

        }
                
        let width1 = (Float(pageControlPagesCount) * Float(self.view.frame.size.width))
        scroll_view.contentSize = CGSize(width: CGFloat(width1), height: 1)
        
        self.page_control.addTarget(self, action: #selector(self.pageChanged(sender:)), for: UIControl.Event.valueChanged)
    }
    
    @objc func pageChanged(sender:AnyObject) {
        let xVal = CGFloat(pageControlPagesCount) * view.frame.size.width
        scroll_view.setContentOffset(CGPoint(x: xVal, y: 0), animated: true)
    }
    
    func changeBtnTextColor(clickedBtn: UIButton) {
        pizzaBtn.setTitleColor(.lightGray, for: .normal)
        pastaBtn.setTitleColor(.lightGray, for: .normal)
        sidesBtn.setTitleColor(.lightGray, for: .normal)
        clickedBtn.setTitleColor(.black, for: .normal)
    }
    
    func changeBtnSettings(button: UIButton, status: Bool, isSpicyVar: Bool) {
        if status {
            clearFilterUI(btn: button)
        } else {
            button.addBorder(borderColor: UIColor(named: "primary-green") ?? UIColor.green, borderWidth: 1)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = UIColor(named: "primary-green")
        }
        
        if isSpicyVar {
            spicyFilterOn = !spicyFilterOn
        } else {
            veganFilterOn = !veganFilterOn
        }
        
        applyFilters()
    }
    
    func clearFilterUI(btn: UIButton) {
        btn.addBorder(borderColor: UIColor.lightGray, borderWidth: 1)
        btn.setTitleColor(.lightGray, for: .normal)
        btn.backgroundColor = UIColor(named: "background-light-gray")
    }
    
    func clearFilterSelections() {
        clearFilterUI(btn: spicyBtn)
        clearFilterUI(btn: veganBtn)
        
        spicyFilterOn = false
        veganFilterOn = false
    }
}
