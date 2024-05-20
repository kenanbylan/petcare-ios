//
//  PrivacyPolicyPresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 10.02.2024.
//

import Foundation

protocol PrivacyPolicyPresenterProtocol {
    func setTitle() -> String
    func getPrivacyPolicyText() -> String
}

final class PrivacyPolicyPresenter {
    private weak var viewController: PrivacyPolicyViewController?
    let router: PrivacyPolicyRouterProtocol?
    let interactor: PrivacyPolicyInteractorProtocol?

    var privacyPolicyText: String = ""

    //MARK: Variable's
    var title:String = "PrivacyPolicyView_title".localized()
    
    init(viewController: PrivacyPolicyViewController? = nil, router: PrivacyPolicyRouterProtocol?, interactor: PrivacyPolicyInteractorProtocol?) {
        self.viewController = viewController
        self.router = router
        self.interactor = interactor
    }
}

extension PrivacyPolicyPresenter: PrivacyPolicyPresenterProtocol {
    
    func setTitle() -> String {
        return title
    }
    
    func getPrivacyPolicyText() -> String {
           // Privacy Policy Text
           let privacyPolicyText = """
           Gizlilik Politikası

           Bu gizlilik politikası, My PetCare uygulamasının kullanıcıları tarafından sağlanan bilgilerin nasıl toplandığını, kullanıldığını, korunduğunu ve açıklandığını açıklar.

           Toplanan Bilgiler

           My PetCare, kullanıcıların kişisel verilerini sadece hizmet sunumunu sağlamak amacıyla toplar. Bu veriler, kullanıcı adları, e-posta adresleri, cihaz bilgileri ve konum bilgileri gibi kullanıcılar tarafından sağlanan bilgileri içerebilir. Bu bilgiler, uygulamanın kullanımı sırasında kullanıcının etkileşimleri ile otomatik olarak toplanabilir.

           Çerezler ve İzleme Teknolojileri

           My PetCare , kullanıcı deneyimini iyileştirmek ve hizmetleri sağlamak için çerezler ve benzeri izleme teknolojilerini kullanabilir. Bu teknolojiler, kullanıcıların uygulamayı nasıl kullandıklarını analiz etmek ve tercihlerini hatırlamak için kullanılabilir.

           Üçüncü Taraf Bağlantıları

           My PetCare, üçüncü taraf web sitelerine veya hizmetlere bağlantılar içerebilir. Bu bağlantılar, kullanıcıları üçüncü taraf sitelerin veya hizmetlerin gizlilik politikalarını incelemeye yönlendirebilir. Üçüncü taraf sitelerin veya hizmetlerin içeriğinden veya uygulamalarından sorumlu değiliz ve bunların gizlilik uygulamalarını kontrol etmiyoruz.

           Güvenlik Önlemleri

           My PetCare, kullanıcı bilgilerinin güvenliğini sağlamak için endüstri standardı güvenlik önlemlerini alır. Bu önlemler, verilere yetkisiz erişimi önlemek, verilerin bütünlüğünü korumak ve verilerin kaybını önlemek için kullanılır.

           Değişiklikler ve Güncellemeler

           Bu gizlilik politikası, uygulamanın gereksinimlerine ve yasalara uygun olarak zaman zaman güncellenebilir. Herhangi bir değişiklik yapıldığında, güncellenmiş politikalar uygulamada yayınlanacak ve kullanıcılara bildirilecektir.

           İletişim Bilgileri

           Gizlilik politikamız hakkında sorularınız veya endişeleriniz varsa, lütfen bizimle iletişime geçmekten çekinmeyin. kenan.baylan4654@gmail.com

           Bu gizlilik politikası 20.06.2024 tarihinde yürürlüğe girmiştir.
           """
           
           return privacyPolicyText
       }
}

extension PrivacyPolicyPresenter: PrivacyPolicyInteractorOutput { }
