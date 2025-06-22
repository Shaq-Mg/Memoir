//
//  ChartView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 15/06/2025.
//

import SwiftUI

struct ChartView: View {
    @StateObject private var viewModel = ChartViewModel()
    @State private var currentDate = Date()
    @Binding var isMenuShowing: Bool
    
    var body: some View {
        VStack {
            MenuHeaderView(showSideMenu: $isMenuShowing, title: "Home")
            VStack(spacing: 16) {
                ChartStateView(viewModel: viewModel)
                
                bookApptButton
                    .padding(.bottom, 16)
                
                upcomingApptHeader
                
                ScrollView(showsIndicators: false) {
                    BookingScrollView(viewModel: viewModel, currentDate: $currentDate)
                        .padding(.top, 16)
                        .scrollTargetLayout()
                        .safeAreaPadding(.horizontal)
                }
                .scrollTargetBehavior(.paging)
            }
            .padding()
        }
    }
}

#Preview {
    NavigationStack {
        ChartView(isMenuShowing: .constant(false))
            .environmentObject(ChartViewModel())
    }
}

private extension ChartView {
    private var bookApptButton: some View {
        NavigationLink {
            FormView(showSideMenu: $isMenuShowing, currentDate: currentDate)
                .navigationBarBackButtonHidden()
        } label: {
            BookApptLabelView()
        }
    }
    
    private var upcomingApptHeader: some View {
        HStack {
            HStack {
                Text("Activity")
                    .fontWeight(.light)
                    .foregroundStyle(Color(.darkGray))
                Text("Today?")
                    .font(.headline)
            }
            .padding(10)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color("OffWhite")))
            .overlay {
                RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1)
                    .fill(Color(.systemGray))
            }
            Spacer()
            
            NavigationLink {
                DayView(currentDate: currentDate)
                    .navigationBarBackButtonHidden()
            } label: {
                Text("See all")
                    .font(.headline)
                    .foregroundStyle(Color(.systemBlue))
                    .padding(12)
            }
        }
        .font(.subheadline)
        .fontWeight(.semibold)
    }
}
