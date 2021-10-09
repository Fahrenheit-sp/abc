//
//  ProductsFetchable.swift
//  ABC
//
//  Created by Игорь Майсюк on 9.10.21.
//

import Foundation

protocol ProductsFetchable: AnyObject {
    var delegate: ProductsFetcherDelegate? { get set }
    func fetchProducts()
    func getProductsInfo() -> [SubscriptionInfo]
    func getPurchaser() -> SubscriptionPurchaseable
}

protocol ProductsFetcherDelegate: AnyObject {
    func fetcherDidLoadPurchases(_ fetcher: ProductsFetchable)
}
