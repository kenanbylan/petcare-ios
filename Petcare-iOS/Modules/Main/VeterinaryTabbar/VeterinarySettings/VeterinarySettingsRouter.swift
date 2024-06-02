//
//  VeterinarySettingsRouter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 31.03.2024.
//

import Foundation
import UIKit

protocol VeterinarySettingsRouterProtocol: AnyObject {
    func backToLogin() -> Void
    func navigateToDetail(detail: DayModel?)
}

final class VeterinarySettingsRouter: VeterinarySettingsRouterProtocol {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    static func build(navigationController: UINavigationController?) -> VeterinarySettingsViewController {
        let view = VeterinarySettingsViewController()
        let router = VeterinarySettingsRouter(navigationController: navigationController)
        let interactor = VeterinarySettingsInteractor()
        let presenter = VeterinarySettingsPresenter(view: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        interactor.output = presenter
        return view
    }
    
    func backToLogin() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func navigateToDetail(detail: DayModel?) {
        let vc = DateListInfoDetailRouter.build(navigationController: navigationController)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //    func request <T:Decodable> (_ endpoint : EndPoint , completion : @escaping (Result<T , Error>) ->Void) ->Void {
    //
    //        let urlSessionTask = URLSession.shared.dataTask(with: endpoint.request()) {(data ,response , error) in
    //            if let error = error {
    //                print(error)
    //            }
    //
    //            if let response = response as? HTTPURLResponse {}
    //
    //            if let data = data {
    //                do {
    //                    let jsonData = try JSONDecoder().decode(T.self, from: data)
    //                    completion(.success(jsonData))
    //
    //                }catch let error {
    //                    completion(.failure(error))
    //                }
    //            }
    //
    //        }
    //        urlSessionTask.resume()
    
    
    //    func getUser(completion: @escaping (Result<User , Error>) ->Void) -> Void {
    //        let endpoint = EndPoint.getUser
    //        request(endpoint, completion: completion)
    //    }
    
    //    Single Responsibility Principle
    //    Open/Closed Principle
    //    Liskov Substitution Principle
    //    Interface Segregation
    //    Dependency Inversion
    
    
    /*
     Singleton tasarım deseni, bir sınıfın static olarak yalnızca tek bir örneğinin oluşturulduğu ve bu örneğe,
     örnek aracılığı ile de sınıf içerisinde bulunan method ve nesnelere global şekilde erişebilmemizi sağlayan bir tasarım desenidir.
     */
    
    
    // fastlane
    
    // if let guard let farkı
    
    // arc weak and strong ne durumlarda kullanılır
    // rtc dil ve component farkı
    // ARC, nesnenin referans sayısının sıfır olması durumunda Bellek sızıntılarını (Memory Leak) otomatik olarak temizler.
    
    //2- Weak Referanslar: Bir nesneye zayıf bir şekilde sahip olur ve referans sayacını artırmaz. Bu referans türü,
    //otomatik olarak nil olabilen bir yapıya sahiptir.
    //Weak referanslar, bir nesnenin yaşam döngüsünü etkilemeden başka bir nesneye referans vermek istediğimiz durumlarda kullanılır.
    
    
    //MARK: -Protocol bir sınıfın kuralları diyebiliriz.
    
    
    //MARK: Collection typelar:
    /*
     1 - array
     2 - sets
     3 - Dictionaries
     */
    
    
    //tableview cell :
    /*
     UITableView içerisinde kullandığınız Cell’in boyutuna göre ekranda gösterilen ve gösterilmesi muhtemelen Cell’leri RAM’de tutarken diğer Cell’leri tutmaz.
     Bu sayede UITableView’i kaydırırken performans açısından bir sorun yaşamazken RAM yönetimi konusunda sizi destekler.
     
     */
}
