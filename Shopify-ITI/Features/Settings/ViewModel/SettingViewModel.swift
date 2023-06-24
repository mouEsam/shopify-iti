//
//  SettingViewModel.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 17/06/2023.
//

import Foundation
import Combine
import Shopify_ITI_SDK

class SettingViewModel: ObservableObject {
    
    @Published private(set) var isLoggedIn: Bool = false
    @Published private(set) var uiState: UIState<Localization> = .initial
    @Published private(set) var logoutState: UIState<Void> = .initial
    @Published var langauge: ShopifyAPI.LanguageCode
    @Published var country: ShopifyAPI.CountryCode
    @Published var address: Address
    private var cancellables: Set<AnyCancellable> = []

    private var logoutTask: Task<Void, Error>? = nil
    
    private let authManager: AuthenticationManager
    private let settingModel: SettingsModel
    private let addressManger: AddressManger

    init(authManager: AuthenticationManager,
         settingModel: SettingsModel,
         addressManger: AddressManger) {
        self.authManager = authManager
        self.settingModel = settingModel
        
        langauge = settingModel.getLanguage()
        country = settingModel.getCountry()
        address = Address(street: "", city: "", state: "", postalCode: "")
        self.addressManger = addressManger
        self.initialize()
    }
    
    private func initialize() {
        isLoggedIn = authManager.state.user != nil
        authManager.statePublisher
            .map(\.user)
            .map { $0 != nil }
            .assign(to: &$isLoggedIn)
        addressManger.selectedStatePublisher.prepend(addressManger.selectedState)
            .receive(on: DispatchQueue.global()).sink { addressState in
                switch addressState{
                case .data(data: let addressString):
                    Task{
                        await MainActor.run{
                            self.address = Address.fromString(addressString) ?? Address(street: "", city: "", state: "", postalCode: "")
                        }
                    }
                case .loading:
                    break
                default:
                    break
                }
            }.store(in: &cancellables)
        
        $country.removeDuplicates().sink { country in
            self.change(country: country)
        }.store(in: &cancellables)
        
        $langauge.removeDuplicates().sink { language in
            self.change(language: language)
        }.store(in: &cancellables)
    }
    
    private func update() {
        langauge = settingModel.getLanguage()
        country = settingModel.getCountry()
    }
    
    func fetch() async {
        await MainActor.run {
            uiState = .loading
        }
        let result = await settingModel.fetch()
        await MainActor.run {
            switch result {
                case .success(let data):
                    uiState = .loaded(data: data)
                    syncValues(data.data)
                    return
                case .failure(let error):
                    uiState = .error(error: error)
                    return
            }
        }
    }
    
    func change(language: ShopifyAPI.LanguageCode) {
        settingModel.changelanguage(language: language)
        self.update()
    }
    
    func change(country: ShopifyAPI.CountryCode) {
        settingModel.changeCountry(country: country)
        self.update()
    }
    
    func logout() {
        guard logoutTask == nil else { return }
        logoutTask = Task {
            await MainActor.run {
                logoutState = .loading
            }
            await authManager.logout().value
            await MainActor.run {
                logoutState = .initial
                self.logoutTask = nil
            }
        }
    }
    
    private func syncValues(_ localizations: Localization) {
        if !localizations.languages.contains(where: { lang in lang == langauge }),
           let language = localizations.languages.first {
            settingModel.changelanguage(language: language)
        }
        if !localizations.countries.contains(where: { con in con == country }),
           let country = localizations.countries.first {
            settingModel.changeCountry(country: country)
        }
        self.update()
    }
}
