//
//  Purchases.swift
//  wallpapers
//
//  Created by Николай on 04.02.2022.
//

import StoreKit

class Purchases: NSObject {
    
    static let `default` = Purchases()
    
    private var models = [SKProduct]()
    
    private let productIdentifiers = Set<String>(
        arrayLiteral: "monthly_subscription"
    )
    
    private var productRequest: SKProductsRequest?

    func initialize() {
        requestProducts()
        
        //SKPaymentQueue.default().add(Observer(self)
    }

    private func requestProducts() {
        
        productRequest?.cancel()

        let productRequest = SKProductsRequest(productIdentifiers: productIdentifiers)
        productRequest.delegate = self
        productRequest.start()

        self.productRequest = productRequest
    }

    public func buy() {
     
        if(!models.isEmpty) {
            let payment = SKPayment(product: models[0])
            SKPaymentQueue.default().add(payment)
        } else {
            print("models is empty")
        }
    }
}

extension Purchases: SKProductsRequestDelegate {
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        guard !response.products.isEmpty else {
            print("Found 0 products")
            return
        }

        for product in response.products {
            print("Found product: \(product.productIdentifier)")
        }
        
        models = response.products
    }

    func request(_ request: SKRequest, didFailWithError error: Error) {
        print("Failed to load products with error:\n \(error)")
    }
}
                                     
                                     
extension Purchases: SKPaymentTransactionObserver {
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        print(transactions)
        
        transactions.forEach({
            switch $0.transactionState {
            case .purchased:
                print("purchased")
                SKPaymentQueue.default().finishTransaction($0)
            case .failed:
                print("failed")
                SKPaymentQueue.default().finishTransaction($0)
            case .restored:
                print("restored")
            case .deferred:
                print("deferred")
            default:
                print($0.transactionState)
            }
        })
    }
}
