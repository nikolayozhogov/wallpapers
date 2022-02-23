//
//  SearchController.swift
//  wallpapers
//
//  Created by Николай on 02.02.2022.
//

import UIKit

class SearchController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var inputSearch: UITextField!
    
    private var tags: [Tag] = []
    
    private var cellWidth: Int = 0
    private var cellHeight: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setUI() {
        
        cellWidth = Int(collectionView.frame.size.width)
        cellHeight = Config.searchCellHeight
    
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 4
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        
        collectionView.collectionViewLayout = layout
        collectionView.register(TagViewCell.nib(), forCellWithReuseIdentifier: TagViewCell.identifier)
    }
    
    @IBAction func searchEditing(_ sender: Any) {
        
        var q = inputSearch.text ?? ""
        /*
        let cond = ProductCond(section_id: self.section.id, for_index: 0, sklad: 0)
        BackendProduct.getList(cond: cond) { products in
        
            //print(products)
            self.products = products
            
            //Страница на стадии заполнения
            if(self.products.isEmpty) {
                self.productCellWidth = Int(self.productCollectionView.frame.size.width)
                self.products.insert(Product(), at: 0)
            }
            
            self.productCollectionView.reloadData()
        }
         */
    }
    
}

extension SearchController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        /*
        let storyboard = UIStoryboard(name: Config.storyboardName, bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: ProductController.identifier) as? ProductController else { return }
        vc.product = self.products[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
         */
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(tags[indexPath.row].id > 0) {
                
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagViewCell.identifier, for: indexPath) as! TagViewCell
            cell.configure(tag: tags[indexPath.row])
            return cell
                    
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LabelViewCell.identifier, for: indexPath) as! LabelViewCell
            cell.configure(text: Config.contentEmpty)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: cellWidth, height: cellHeight)
        }
    
}
