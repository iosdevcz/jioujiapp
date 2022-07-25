//
//  ViewListTransparentAccounts.swift
//  Jioujiapp
//
//  Created by Ladislav Žižka on 24.07.2022.
//

import ComposableArchitecture
import SwiftUI

struct ViewListTransparentAccounts: View {
    let store: Store<TransparentAccountState, TransparentAccountAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            NavigationView {
                ScrollView {
                    LazyVStack {
                        ForEach(viewStore.accounts) { account in
                            ViewTransparentAccount(
                                store: store,
                                account: account)
                            .padding([.leading, .trailing, .bottom])
                        }
                    }
                }
                .onAppear {
                    viewStore.send(.onAppear)
                }
                .navigationTitle("Transparent Accounts")
                .navigationBarTitleDisplayMode(.inline)
            }
            .accentColor(Color.mint)
        }
    }
}

struct ViewTransparentAccount: View {
    let store: Store<TransparentAccountState, TransparentAccountAction>
    let account: ModelTransparentAccount
    @State var showDetailAccount = false
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack {
                Text(account.name)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    Text("\(account.accountNumber) / \(account.bankCode)")
                        .font(.caption)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 2)
                        .padding(.bottom, 2)
                    Spacer()
                    Text(String(account.balance))
                        .font(.subheadline)
                    Text(account.currency ?? "???")
                        .font(.subheadline)
                }
            }
            .padding()
            .foregroundColor(Color.white)
            .background(Color.mint)
            .cornerRadius(8.0)
            .onTapGesture {
                showDetailAccount = true
            }
            .background(
                NavigationLink("",
                               destination:
                                ViewDetailTransparentAccount(
                                    store: store,
                                    account: account),
                               isActive: $showDetailAccount))
        }
    }
}

struct ViewDetailTransparentAccount: View {
    let store: Store<TransparentAccountState, TransparentAccountAction>
    let account: ModelTransparentAccount
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return formatter
    }
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            NavigationView {
                VStack(spacing: 10) {
                    HStack {
                        Text("Name:")
                        Spacer()
                        Text(account.name)
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    HStack {
                        Text("Account Number:")
                        Spacer()
                        Text(account.accountNumber)
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    HStack {
                        Text("Bank Code:")
                        Spacer()
                        Text(account.bankCode)
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    HStack {
                        Text("IBAN:")
                        Spacer()
                        Text(account.iban)
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    HStack {
                        Text("Balance:")
                        Spacer()
                        Text(String(account.balance))
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    HStack {
                        Text("Currency:")
                        Spacer()
                        Text(account.currency ?? "Unknown")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    HStack {
                        Text("Transparency From:")
                        Spacer()
                        Text(
                            dateFormatter.date(
                                from: account.transparencyFrom) ?? Date.distantPast, style: .date)
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    HStack {
                        Text("Transparency To:")
                        Spacer()
                        Text(
                            dateFormatter.date(
                                from: account.transparencyTo) ?? Date.distantPast, style: .date)
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    HStack {
                        Text("Last Update:")
                        Spacer()
                        Text(
                            dateFormatter.date(
                                from: account.actualizationDate) ?? Date.distantPast, style: .date)
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding()
                .foregroundColor(Color.white)
                .background(Color.mint)
                .cornerRadius(8.0)
                .navigationTitle("Detail")
                .navigationBarTitleDisplayMode(.inline)
                .frame(minWidth: .zero,
                       maxWidth: .infinity,
                       minHeight: .zero,
                       maxHeight: .infinity,
                       alignment: .topLeading)
            }
        }
    }
}

struct ViewListTransparentAccounts_Previews: PreviewProvider {
    static var previews: some View {
        ViewListTransparentAccounts(
            store: Store(
                initialState: TransparentAccountState(accounts: []),
                reducer: transparentAccountReducer,
                environment: .preview(
                    environment: TransparentAccountEnvironment(
                        transparentAccountsRequest: dummyTransparentAccountEffect))))
    }
}

func dummyTransparentAccountEffect() -> Effect<[ModelTransparentAccount], ApiError> {
    let transparentAccountDummy: [ModelTransparentAccount] = [
        ModelTransparentAccount(
            accountNumber: "00000-11111",
            bankCode: "0800",
            transparencyFrom: "Dummy",
            transparencyTo: "Dummy",
            actualizationDate: "2018-01-17T13:00:00",
            balance: 1000000.0, currency: "CZK",
            name: "Neko",
            iban: "Dummy"),
        ModelTransparentAccount(
            accountNumber: "00000-22222",
            bankCode: "0800",
            transparencyFrom: "Dummy",
            transparencyTo: "Dummy",
            actualizationDate: "2018-01-17T13:00:00",
            balance: 500000.0, currency: "CZK",
            name: "Inu",
            iban: "Dummy"),
        ModelTransparentAccount(
            accountNumber: "00000-33333",
            bankCode: "0800",
            transparencyFrom: "Dummy",
            transparencyTo: "Dummy",
            actualizationDate: "2018-01-17T13:00:00",
            balance: 100000.0, currency: "CZK",
            name: "Usagi",
            iban: "Dummy")]
    return Effect(value: transparentAccountDummy)
}
