//
//  CategoryController.swift
//  wallpapers
//
//  Created by Николай on 12.12.2021.
//

import UIKit

class CategoryController: UIViewController {
    
    static var identifier = "CategoryController"
    
    weak var delegate: MainViewControllerDelegate?

    @IBOutlet weak var collectionView: UICollectionView!
    private var categories = [Category]()
    
    var cell_width: Int = 0
    var cell_height: Int = 35
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        cell_width = Int(collectionView.frame.size.width)
                        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 4
        layout.itemSize = CGSize(width: cell_width,height: cell_height)
                
        collectionView.collectionViewLayout = layout
        collectionView.register(CategoryViewCell.nib(), forCellWithReuseIdentifier: CategoryViewCell.identifier)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        print("viewDidDisappear")
        
        delegate?.claimShowWallpaper()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Backend.categoryList(complete: { result in
            self.categories = result
            
            self.collectionView.reloadData()
        })
    }
}

extension CategoryController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryViewCell.identifier, for: indexPath) as! CategoryViewCell
        let index = categories[indexPath.row].id
        
        var name = categories[indexPath.row].name; //ru
        if(Config.getCurrentLanguageCode() != "ru") {
            name = categories[indexPath.row].name_en
        }
                
        cell.configure(index: index,
                        name: name,
                       isOn: Storage.switch_state[index])
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cell_width, height: cell_height)
    }
    
}
