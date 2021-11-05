//
//  RoutersFabric.swift
//  ABC
//
//  Created by Игорь Майсюк on 8.09.21.
//

import Foundation

protocol RoutersFabric: AnyObject {
    var delegate: MainMenuNavigatable? { get set }
    func makeRouter(for item: MainMenuItem) -> Router
}

final class DefaultRouterFabric: RoutersFabric {

    weak var delegate: MainMenuNavigatable?

    func makeRouter(for item: MainMenuItem) -> Router {
        switch item {
        case .subscribe:
            let router = SubscribeRouter(parameters: .init(fetcher: RevenueCatProductsFetcher.shared))
            router.delegate = delegate
            return router
        case .alphabet, .numbers:
            let alphabet = item == .alphabet ? AlphabetsFactory.getAlphabet(.english) : AlphabetsFactory.getAlphabet(.numbers)
            let mode: AlphabetViewMode = item == .alphabet ? .alphabet : .numbers
            let alphabetRouter = AlphabetRouter(parameters: .init(alphabet: alphabet, mode: mode))
            alphabetRouter.delegate = delegate
            return alphabetRouter
        case .canvas:
            return CanvasRouter(parameters: .init(canvas: AlphabetsFactory.getAlphabet(.english)))
        case .memorize:
            let memorizeRouter = MemorizeRouter(parameters: .init(memorizable: AlphabetsFactory.getAlphabet(.english)))
            memorizeRouter.delegate = delegate
            return memorizeRouter
        case .makeAWord:
            let makeAWordRouter = MakeAWordRouter(parameters: .init(canvas: AlphabetsFactory.getAlphabet(.english)))
            makeAWordRouter.delegate = delegate
            return makeAWordRouter
        case .listen:
            return ListenRouter(parameters: .init(alphabet: AlphabetsFactory.getAlphabet(.english), mode: .alphabet))
        case .pictures:
            let router = PicturesRouter(parameters: .init(picturesStorage: WordsStorage.shared))
            router.delegate = delegate
            return router
        case .catchLetter:
            let router = CatchLetterRouter(parameters: .init(alphabet: AlphabetsFactory.getAlphabet(.english)))
            router.delegate = delegate
            return router
        }
    }
}
