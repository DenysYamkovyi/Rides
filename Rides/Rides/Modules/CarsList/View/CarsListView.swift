//
//  CarsListView.swift
//  RidesSwiftUI_Storyboard
//
//  Created by macbook pro on 2024-10-01.
//

import Combine
import SwiftUI

protocol CarsListViewViewModel: ObservableObject {
    associatedtype ContentRow: ContentRowViewViewModel, Hashable
    
    var isLoading: Bool { get }
    var listSize: String { get set }
    var list: [ContentRow] { get }
    var sortBy: SortOption { get set }
    var error: String { get }
    
    func didTapFetchCarsList()
}

struct CarsListView<ViewModel>: View where ViewModel: CarsListViewViewModel {
    @ObservedObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    TitleText(
                        style: .small,
                        text: viewModel.error,
                        color: .error
                    )
                    .padding(.horizontal, 16)
                    Spacer()
                }

                HStack {
                    TextField("Enter cars amount".toLocalized(), text: $viewModel.listSize)
                        .textFieldStyle(
                            RoundedTextFieldStyle(
                                isErrored: false,
                                backgroundColor: .white.opacity(0.9),
                                borderColor: .border,
                                errorColor: .clear
                            )
                        )
                    
                    Button(action: viewModel.didTapFetchCarsList) {
                        HStack {
                            Spacer()
                            TitleText(
                                style: .mediumSemiBold,
                                text: "Go".toLocalized(),
                                color: .highlighted
                            )
                            Spacer()
                        }
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(BorderedButtonStyle.secondaryButtonStyle)
                    .frame(width: 50, height: 50)
                    
                }
                
                VStack(spacing: 3) {
                    Text("Sort By")
                        .foregroundColor(.black)

                    Picker("Sort By", selection: $viewModel.sortBy) {
                        ForEach(SortOption.allCases, id: \.self) { option in
                            Text(option.rawValue).tag(option)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    .accentColor(.blue)
                }
                
                // Contents Row
                List(viewModel.list, id: \.self) { car in
                    ContentRowView(viewModel: car)
                }
                .listStyle(PlainListStyle())
                .background(Color.clear)
                .padding(.bottom, 16)
                
                Spacer()
            }
            .padding(.horizontal, 43)
            
            LoadingView()
                .opacity(viewModel.isLoading ? 1.0 : 0)
        }
        .background(.placeholder)
    }
}

#if DEBUG
#Preview {
    CarsListView<CarsListViewModel>(viewModel: .init())
}
#endif

