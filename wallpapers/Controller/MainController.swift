//
//  MainController.swift
//  wallpapers
//
//  Created by Николай on 12.12.2021.
//

import UIKit
import StoreKit

class MainController: UIViewController {
    
    static var identifier = "MainController"

    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var loaderView: UIView!
    
    private var wallpaper = Wallpaper()
    
    //Показанные обоев
    private var showedIds: [Int] = []
    private var stack_index: Int = 0
    
    //Сколько обоев было показано?
    //После первых 5 обоин будет показана реклама
    private var showedWallpapersCnt: Int = 0
    
    //Храним в памяти одну предыдущую обоину
    private var lastWallpaper: [Int: UIImage] = [:]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI();
        
        //Purchases.default.initialize()
    }
    
    public func showWallpaper(id: Int = 0) {
        
        print("call showWallpaper")
        
        if(loader.isAnimating == false) {
            
            startLoadAnimation()
            
            Backend.wallpaper(id: id, category_id: Storage.getCategorySwitchedIds(), limit: 1, complete: { status, result in

                if(status) {
                    
                    if(id == 0) {
                        
                        //Сохраняем в память текущую обоину
                        //self.lastWallpaper.removeAll()
                        //self.lastWallpaper[self.wallpaper.id] = self.imageBackground.image!
                    }
                    
                    self.wallpaper = result
                    
                    //print(self.lastWallpaper)
                    //print(id)
                    
                    if(self.lastWallpaper[self.wallpaper.id] != nil) {
                        
                        print("load from memory")
                        self.imageBackground.image = self.lastWallpaper[self.wallpaper.id]
                        self.stopLoadAnimation()
                        
                    } else {
                        
                        Image.setImage(from: self.wallpaper.url, complete: { (image: UIImage) in
                            
                            self.imageBackground.image = image
                            self.stopLoadAnimation()
                
                            if(id == 0) {
                                
                                //записываем id всех просмотренных обоин, что бы была возможность вернуться назад
                                self.showedIds.append(self.wallpaper.id)
                                self.stack_index += 1
                                
                                self.showedWallpapersCnt += 1
                                print("showedWallpapersCnt \(self.showedWallpapersCnt)")
                            }
                        })
                    }
                    
                } else {
                    
                    self.stopLoadAnimation()
                    
                    let alert = UIAlertController(title:  NSLocalizedString("Server error", comment: ""),
                                                  message:  NSLocalizedString("Download error", comment: ""), preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString( NSLocalizedString("Close", comment: ""), comment: ""), style: .cancel))
                    self.present(alert, animated: true)
                }
            })
            
        }
    }
    
    func startLoadAnimation() {
        
        loader.startAnimating();
        loader.layer.opacity = 1
        loaderView.layer.opacity = 1
    }
    
    func stopLoadAnimation() {
        
        loader.stopAnimating()
        loader.layer.opacity = 0
        loaderView.layer.opacity = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showWallpaper();
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is SettingsController {
            let vc = segue.destination as? SettingsController
            vc?.wallpaper = self.wallpaper
        }
        if segue.destination is CategoryController {
            let vc = segue.destination as? CategoryController
            vc?.delegate = self
        }
    }

    @IBAction func handleCategoryListClick(_ sender: Any) {
        self.performSegue(withIdentifier: "categoryListSegue", sender: self)
    }
    
    @IBAction func handleSettingsClick(_ sender: Any) {
        self.performSegue(withIdentifier: "settingsSegue", sender: self)
    }
    
    @IBAction func handleSearchClick(_ sender: Any) {
        self.performSegue(withIdentifier: "searchSegue", sender: self)
    }
    
    private func setUI() {
        
        imageBackground.image = UIImage(named: "bg1")
        
        loaderView.layer.cornerRadius = 10
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapOnImage))
        tapRecognizer.numberOfTapsRequired = 1
        tapRecognizer.numberOfTouchesRequired = 1
        imageBackground.addGestureRecognizer(tapRecognizer)
        imageBackground.isUserInteractionEnabled = true
        
        let leftSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeImage))
        leftSwipeRecognizer.direction  = .left
        imageBackground.addGestureRecognizer(leftSwipeRecognizer)
        
        let rightSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeImage))
        rightSwipeRecognizer.direction  = .right
        imageBackground.addGestureRecognizer(rightSwipeRecognizer)
    }
    
    func showPrev() {
        
        print("call showPrev")
        
        if(showedIds.count > 1 && stack_index > 0) {
            stack_index -= 1
            let prev_id = showedIds[stack_index - 1]
            showWallpaper(id: prev_id)
        }
    }
    
    @objc func handleSwipeImage(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
                case .right:
                    showWallpaper()
                case .down:
                    showPrev()
                case .left:
                    showPrev()
                case .up:
                    showWallpaper()
                default:
                break
            }
        }
    }

    @objc func handleTapOnImage(recognizer: UITapGestureRecognizer) {
        if(recognizer.state == UIGestureRecognizer.State.ended) {
            showWallpaper()
        }
    }
    
}

extension MainController {
    
    @IBAction func handleSavePhoto(_ sender: Any) {
        UIImageWriteToSavedPhotosAlbum(imageBackground.image!,
                                       self,
                                       #selector(savingImageCallback(_:didFinishSavingWithError:contextInfo:)),
                                       nil)
    }
    
    @objc func savingImageCallback(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: NSLocalizedString("Save error", comment: ""), message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: NSLocalizedString("Picture is saved!", comment: ""),
                                       message: "", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default))
            present(ac, animated: true)
            
            Backend.incDownload(id: self.wallpaper.id)
        }
    }
}

extension MainController: MainViewControllerDelegate {
    
    func claimShowWallpaper() {
        showWallpaper(id: 0)
    }
}
